-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 03, 2022 at 09:22 PM
-- Server version: 8.0.28
-- PHP Version: 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `projeto`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` bigint NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `username`, `email`, `password`, `isAdmin`) VALUES
(12, 'teste', 'teste@teste.pt', '$5$rounds=535000$4xkvL/ihCYBePgQS$E9hc6/eyZeV12hHo.0cIMUaCmXo/m1wXSEGpIRXZ.LC', 1),
(13, 'administrador', 'admin@admin.pt', '$5$rounds=535000$yYEVFrvalMWHYIh6$iFswRKsXxF6ez7lpHXdtyS9lEE8QD8WJgIFq1pIGsW2', 1);

-- --------------------------------------------------------

--
-- Table structure for table `quiz`
--

CREATE TABLE `quiz` (
  `id` bigint NOT NULL,
  `hostId` bigint NOT NULL,
  `title` varchar(75) COLLATE utf8mb4_unicode_ci NOT NULL,
  `metaTitle` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` tinytext COLLATE utf8mb4_unicode_ci,
  `module` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `score` smallint NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `publishedAt` datetime DEFAULT NULL,
  `startsAt` datetime DEFAULT NULL,
  `endsAt` datetime DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz`
--

INSERT INTO `quiz` (`id`, `hostId`, `title`, `metaTitle`, `slug`, `summary`, `module`, `score`, `published`, `createdAt`, `updatedAt`, `publishedAt`, `startsAt`, `endsAt`, `content`) VALUES
(1, 13, 'eee', 'eee', 'ddd', 'ewqeqwe', 'Python', 200, 1, '2022-03-24 22:46:56', '2022-04-03 22:46:56', '2022-03-24 22:46:56', '2022-04-30 14:00:00', '2022-04-30 15:00:00', 'Python'),
(2, 12, 'HTML', 'meta', 'slug', 'resumo', 'HTML', 200, 1, '2022-03-28 17:53:18', '2022-04-03 22:14:39', '2022-04-03 22:21:23', '2022-04-30 16:00:00', '2022-04-30 17:00:00', 'HTML');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_answer`
--

CREATE TABLE `quiz_answer` (
  `id` bigint NOT NULL,
  `quizId` bigint NOT NULL,
  `questionId` bigint NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `correct` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_answer`
--

INSERT INTO `quiz_answer` (`id`, `quizId`, `questionId`, `active`, `correct`, `createdAt`, `updatedAt`, `content`) VALUES
(1, 1, 1, 1, 1, '2022-03-25 23:19:36', '2022-04-03 22:01:37', 'print(\"Hello World\")'),
(2, 1, 1, 1, 0, '2022-03-25 23:20:55', '2022-04-03 22:10:34', 'echo(\"Hello World\");'),
(3, 1, 1, 1, 0, '2022-03-25 23:21:32', '2022-04-03 22:10:42', 'p(\"Hello World\")'),
(4, 1, 2, 1, 1, '2022-03-26 11:59:12', '2022-04-03 22:10:24', '# This is a comment'),
(5, 1, 2, 1, 0, '2022-03-26 11:59:48', '2022-04-03 22:10:14', '/* This is a comment */'),
(6, 1, 2, 1, 0, '2022-03-26 12:00:09', '2022-04-03 22:09:43', '// This is a comment'),
(7, 1, 2, 1, 0, '2022-03-26 21:32:19', '2022-04-03 21:32:19', '<!-- This is a comment -->'),
(10, 1, 10, 1, 1, '2022-03-28 15:38:32', '2022-04-03 22:12:04', 'my-var'),
(11, 1, 10, 1, 0, '2022-03-28 15:39:14', '2022-04-03 22:12:36', 'my_var'),
(12, 1, 10, 1, 0, '2022-03-28 15:39:34', '2022-04-03 22:13:26', '_myvar'),
(13, 2, 11, 1, 0, '2022-03-28 17:57:00', '2022-04-03 22:16:51', 'Hyperlinks and Text Markup Language'),
(14, 2, 11, 1, 1, '2022-03-28 17:57:41', '2022-04-03 22:17:48', 'Hyper Text Markup Language'),
(15, 2, 11, 1, 0, '2022-03-28 17:58:03', '2022-04-03 22:18:33', 'Home Tool Markup Language');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_meta`
--

CREATE TABLE `quiz_meta` (
  `id` bigint NOT NULL,
  `quizId` bigint NOT NULL,
  `key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_question`
--

CREATE TABLE `quiz_question` (
  `id` bigint NOT NULL,
  `quizId` bigint NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `level` smallint NOT NULL DEFAULT '0',
  `score` smallint NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_question`
--

INSERT INTO `quiz_question` (`id`, `quizId`, `type`, `active`, `level`, `score`, `createdAt`, `updatedAt`, `content`) VALUES
(1, 1, 'multiple-choice', 1, 2, 2, '2022-03-24 22:46:56', '2022-03-24 22:46:56', 'What is a correct syntax to output \"Hello World\" in Python?'),
(2, 1, 'multiple-choice', 1, 1, 2, '2022-03-26 11:20:00', '2022-04-03 11:20:00', 'How do you insert COMMENTS in Python code?'),
(10, 1, 'multiple-choice', 1, 1, 3, '2022-03-28 15:37:44', '2022-04-03 22:11:35', 'Which one is NOT a legal variable name?'),
(11, 2, 'multiple-choice', 1, 2, 4, '2022-03-28 17:56:08', '2022-04-03 22:14:10', 'What does HTML stand for?');

-- --------------------------------------------------------

--
-- Table structure for table `take`
--

CREATE TABLE `take` (
  `id` bigint NOT NULL,
  `userId` bigint NOT NULL,
  `quizId` bigint NOT NULL,
  `status` smallint NOT NULL DEFAULT '0',
  `score` smallint NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `startedAt` datetime DEFAULT NULL,
  `finishedAt` datetime DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `take_answer`
--

CREATE TABLE `take_answer` (
  `id` bigint NOT NULL,
  `takeId` bigint NOT NULL,
  `questionId` bigint NOT NULL,
  `answerId` bigint NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz`
--
ALTER TABLE `quiz`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_slug` (`slug`),
  ADD KEY `idx_quiz_host` (`hostId`);

--
-- Indexes for table `quiz_answer`
--
ALTER TABLE `quiz_answer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_answer_quiz` (`quizId`),
  ADD KEY `idx_answer_question` (`questionId`);

--
-- Indexes for table `quiz_meta`
--
ALTER TABLE `quiz_meta`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_quiz_meta` (`quizId`,`key`),
  ADD KEY `idx_meta_quiz` (`quizId`);

--
-- Indexes for table `quiz_question`
--
ALTER TABLE `quiz_question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_question_quiz` (`quizId`);

--
-- Indexes for table `take`
--
ALTER TABLE `take`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_take_user` (`userId`),
  ADD KEY `idx_take_quiz` (`quizId`);

--
-- Indexes for table `take_answer`
--
ALTER TABLE `take_answer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_answer_take` (`takeId`),
  ADD KEY `idx_tanswer_question` (`questionId`),
  ADD KEY `idx_tanswer_answer` (`answerId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `quiz`
--
ALTER TABLE `quiz`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `quiz_answer`
--
ALTER TABLE `quiz_answer`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `quiz_meta`
--
ALTER TABLE `quiz_meta`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz_question`
--
ALTER TABLE `quiz_question`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `take`
--
ALTER TABLE `take`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `take_answer`
--
ALTER TABLE `take_answer`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `quiz`
--
ALTER TABLE `quiz`
  ADD CONSTRAINT `fk_quiz_host` FOREIGN KEY (`hostId`) REFERENCES `accounts` (`id`);

--
-- Constraints for table `quiz_answer`
--
ALTER TABLE `quiz_answer`
  ADD CONSTRAINT `fk_answer_question` FOREIGN KEY (`questionId`) REFERENCES `quiz_question` (`id`),
  ADD CONSTRAINT `fk_answer_quiz` FOREIGN KEY (`quizId`) REFERENCES `quiz` (`id`);

--
-- Constraints for table `quiz_meta`
--
ALTER TABLE `quiz_meta`
  ADD CONSTRAINT `fk_meta_quiz` FOREIGN KEY (`quizId`) REFERENCES `quiz` (`id`);

--
-- Constraints for table `quiz_question`
--
ALTER TABLE `quiz_question`
  ADD CONSTRAINT `fk_question_quiz` FOREIGN KEY (`quizId`) REFERENCES `quiz` (`id`);

--
-- Constraints for table `take`
--
ALTER TABLE `take`
  ADD CONSTRAINT `fk_take_quiz` FOREIGN KEY (`quizId`) REFERENCES `quiz` (`id`),
  ADD CONSTRAINT `fk_take_user` FOREIGN KEY (`userId`) REFERENCES `accounts` (`id`);

--
-- Constraints for table `take_answer`
--
ALTER TABLE `take_answer`
  ADD CONSTRAINT `fk_answer_take` FOREIGN KEY (`takeId`) REFERENCES `take` (`id`),
  ADD CONSTRAINT `fk_tanswer_answer` FOREIGN KEY (`answerId`) REFERENCES `quiz_answer` (`id`),
  ADD CONSTRAINT `fk_tanswer_question` FOREIGN KEY (`questionId`) REFERENCES `quiz_question` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
