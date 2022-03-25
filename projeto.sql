-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 25, 2022 at 09:43 PM
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
  `password` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `username`, `email`, `password`) VALUES
(1, 'admin', 'zadmin@admin.com', 'admin'),
(2, 'rui', 'rui@gmail.com', 'admin');

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
  `type` smallint NOT NULL DEFAULT '0',
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

INSERT INTO `quiz` (`id`, `hostId`, `title`, `metaTitle`, `slug`, `summary`, `type`, `score`, `published`, `createdAt`, `updatedAt`, `publishedAt`, `startsAt`, `endsAt`, `content`) VALUES
(1, 1, 'eee', 'eee', 'ddd', 'ewqeqwe', 1, 1, 1, '2022-03-24 22:46:56', '2022-03-24 22:46:56', '2022-03-24 22:46:56', '2022-03-24 22:46:56', '2022-03-24 22:46:56', 'dsds');

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
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
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
(1, 1, 'wqwq', 1, 1, 1, '2022-03-24 22:46:56', '2022-03-24 22:46:56', 'sasa'),
(6, 1, 'wqwqw', 1, 1, 1, '2022-03-24 22:46:56', '2022-03-24 22:46:56', 'dsdsds'),
(7, 1, '2', 2, 1, 2, '2022-03-24 23:09:01', '2022-03-24 23:09:01', 'dasd'),
(8, 1, '2', 2, 1, 2, '2022-03-24 23:09:01', '2022-03-24 23:09:01', 'dasd');

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
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `quiz`
--
ALTER TABLE `quiz`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `quiz_answer`
--
ALTER TABLE `quiz_answer`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz_meta`
--
ALTER TABLE `quiz_meta`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz_question`
--
ALTER TABLE `quiz_question`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `take`
--
ALTER TABLE `take`
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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
