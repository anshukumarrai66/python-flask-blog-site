from flask import Flask, request, url_for, render_template, session, redirect
from flask_sqlalchemy import SQLAlchemy
from werkzeug.utils import secure_filename
from flask_mail import Mail, Message
from google.auth.transport.requests import Request
from google.oauth2 import service_account
from google_auth_oauthlib.flow import InstalledAppFlow
import json, os, math
from datetime import datetime


with open("config.json", "r") as c:
    parameters = json.load(c)["parameters"]


local_server = True
app = Flask(__name__)

app.secret_key = 'super-secret-key'
app.config["UPLOAD_FOLDER"] = parameters['upload_location']

app.config.update(
    MAIL_SERVER="smtp.gmail.com",
    MAIL_PORT=465,
    MAIL_USE_SSL=True,
    MAIL_USE_TLS=False,
    MAIL_USERNAME=parameters["gmail-username"],
    MAIL_PASSWORD=parameters['gmail-password']
)
mail = Mail(app)

if local_server:
    app.config["SQLALCHEMY_DATABASE_URI"] = parameters["local_uri"]
else:
    app.config["SQLALCHEMY_DATABASE_URI"] = parameters["production_uri"]

# app.config["SQLALCHEMY_DATABASE_URI"] = "mysql://root:@localhost/codingthunder"
# app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///db.sqlite3'
db = SQLAlchemy(app)


class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(50), nullable=False)
    phone_num = db.Column(db.String(13), nullable=False)
    msg = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)


class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    tagline = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(50), nullable=False)
    content = db.Column(db.String(130), nullable=False)
    img_file = db.Column(db.String(12), nullable=False)
    date = db.Column(db.String(12), nullable=True)


@app.route("/")
def home():

    posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts) / int(parameters['no_of_posts']))
    # [0 : parameters["no_of_posts"]]

    # posts = posts[]

    page = request.args.get('page')
    if(not str(page).isnumeric()):
        page = 1
    page = int(page)
    
    posts = posts[(page-1)*int(parameters['no_of_posts']): (page-1)*int(parameters['no_of_posts']) + int(parameters['no_of_posts'])]
    # Pagination Logic
    # First Page
    if (page == 1):
        prev = "#"
        next = "/?page="+ str(page+1)
    elif(page==last):
        prev = "/?page="+ str(page-1)
        next = "#"
    else:
        prev = "/?page="+ str(page-1)
        next = "/?page="+ str(page+1)

    # Middle page
    # Last page

    return render_template("index.html", parameters=parameters, posts=posts, prev=prev, next=next)


@app.route("/dashboard", methods=['GET', 'POST'])
def dashboard():

    if ('user' in session and session['user'] == parameters['admin_user']): 
        posts = Posts.query.all()
        return render_template('dashboard.html', parameters=parameters, posts = posts)

    if request.method=='POST':
        username = request.form.get('uname')
        userpass = request.form.get('pass')
        if (username == parameters['admin_user'] and userpass == parameters['admin_password']):
            #set the session variable
            session['user'] = username
            posts = Posts.query.all()
            return render_template('dashboard.html', parameters=parameters, posts = posts)

    return render_template("login.html", parameters=parameters)


@app.route("/about")
def about():
    return render_template("about.html", parameters=parameters)


@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template("post.html", parameters=parameters, post=post)


@app.route("/edit/<string:sno>", methods=["GET", "POST"])
def edit(sno):
    if ('user' in session and session['user'] == parameters['admin_user']): 
        if request.method == 'POST':
            box_title = request.form.get('title')
            tline = request.form.get('tline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            date = datetime.now()

            if sno=="0":
                post = Posts(
                    title=box_title,
                    tagline=tline,
                    slug=slug,
                    content=content,
                    img_file=img_file,
                    date=date,
                )
                db.session.add(post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(sno=sno).first()
                post.title = box_title
                post.tagline = tline
                post.slug = slug
                post.content = content
                post.img_file = img_file
                post.date = date
                db.session.commit()
                return redirect('/edit/'+sno) 
        post = Posts.query.filter_by(sno=sno).first()
        return render_template('edit.html', parameters=parameters, post=post)


@app.route("/delete/<string:sno>", methods=["GET", "POST"])
def delete(sno):
    if ('user' in session and session['user'] == parameters['admin_user']): 
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')


@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/dashboard')


@app.route("/uploader", methods=["GET", "POST"])
def uploader():
    if ('user' in session and session['user'] == parameters['admin_user']): 
        if request.method == 'POST':
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            return "Uploaded Successfully"


@app.route("/contact", methods=["GET", "POST"])
def contact():
    if request.method == "POST":
        """Add entry to the database"""
        name = request.form.get("name")
        email = request.form.get("email")
        phone = request.form.get("phone")
        message = request.form.get("message")
        entry = Contacts(
            name=name, phone_num=phone, email=email, msg=message, date=datetime.now()
        )
        db.session.add(entry)
        db.session.commit()
        mail.send_message(
            "New Message From Blog By " + name,
            sender=email,
            recipients=[parameters["gmail-username"]],
            body=message + "\n\n\n" + "Phone Number:- " + phone + "\n\n" + "Email Address: -" + email,
        )
    return render_template("contact.html", parameters=parameters)


app.run(debug=True)
