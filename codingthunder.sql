-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 07, 2024 at 02:02 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codingthunder`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_num` varchar(13) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone_num`, `msg`, `date`) VALUES
(1, 'abc', 'abc@a.com', '1234567890', 'first message', '2024-01-16 15:45:11'),
(2, 'anshu', 'anshu@rs.com', '6565656565', 'Hii, ', NULL),
(17, 'Manoj', 'manoj5665a@gmail.com', '5687315885', 'Hii,\r\nI am Manoj,\r\nI need some Guidance in learning python, flask, bash and html', '2024-01-17 01:14:37'),
(18, 'anshu', 'manoj5665a@gmail.com', '6565656565', 'Testing...', '2024-01-17 22:46:26'),
(19, 'anshu', 'anshu@rs.com', '6565656565', 'Testing message 1\r\n', '2024-03-28 16:15:06'),
(20, 'anshu', 'anshu@rs.com', '6565656565', 'Testing message 1\r\n', '2024-03-28 16:15:10'),
(21, 'anshu', 'anshu@rs.com', '6565656565', 'hii testing', '2024-03-30 13:34:08');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `tagline` text NOT NULL,
  `slug` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(12) NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tagline`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'This is my first post title', 'first post of  my blog page', 'first-post', 'Hii Everyone,\r\nI am Rohit and this is my first post and i am very excited about this blog and flask micro framework. ', 'post-bg.jpg', '2024-03-30 14:09:27'),
(2, 'This is my second post', 'post two', 'second-post', 'Hii Everyone,\r\nI am Rohit and this is my second post on this website.', 'post-bg.jpg', '2024-01-21 21:59:28'),
(3, 'A Minimal Application', 'A Minimal Application', 'third-post', 'For the common case of having one Flask application all you have to do is to create your Flask application, load the configuration of choice and then create the SQLAlchemy object by passing it the application.\r\n\r\nOnce created, that object then contains all the functions and helpers from both sqlalchemy and sqlalchemy.orm. Furthermore it provides a class called Model that is a declarative base which can be used to declare models:', 'post-bg.jpg', '2024-01-21 22:11:07'),
(4, 'A Minimal Application 2', 'Minimal Application 2', 'fouth-post', 'For the common case of having one Flask application all you have to do is to create your Flask application, load the configuration of choice and then create the SQLAlchemy object by passing it the application.\r\n\r\nOnce created, that object then contains all the functions and helpers from both sqlalchemy and sqlalchemy.orm. Furthermore it provides a class called Model that is a declarative base which can be used to declare models:', 'post-bg.jpg', '2024-01-21 22:11:07'),
(5, 'A Minimal Application 3', 'Minimal Application 3', 'fifth-post', 'For the common case of having one Flask application all you have to do is to create your Flask application, load the configuration of choice and then create the SQLAlchemy object by passing it the application.\r\n\r\nOnce created, that object then contains all the functions and helpers from both sqlalchemy and sqlalchemy.orm. Furthermore it provides a class called Model that is a declarative base which can be used to declare models:', 'post-bg.jpg', '2024-01-21 22:11:07'),
(6, 'A Minimal Application 4-5-6', 'Minimal Application 4', 'sixth-post', 'For the common case of having one Flask application all you have to do is to create your Flask application, load the configuration of choice and then create the SQLAlchemy object by passing it the application.\r\n\r\nOnce created, that object then contains all the functions and helpers from both sqlalchemy and sqlalchemy.orm. Furthermore it provides a class called Model that is a declarative base which can be used to declare models:', 'post-bg.jpg', '2024-04-06 12:18:44'),
(8, 'ghjk -5665', 'faghj', 'slug', 'agshj', 'post-bg.jpg', '2024-04-09 10:02:54'),
(10, '25', '25', '25', '25', 'img.png', '2024-04-09 10:10:07'),
(11, 'post 9', 'post 9', 'post 9', 'post 9', 'post9.png', '2024-04-10 11:53:08'),
(12, 'Post 10', 'Post 10', 'Post 10', 'Post 10', 'post10.png', '2024-05-07 16:04:16');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
