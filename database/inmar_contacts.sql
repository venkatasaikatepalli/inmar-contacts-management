-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 20, 2018 at 09:16 PM
-- Server version: 5.7.21-0ubuntu0.16.04.1
-- PHP Version: 7.0.27-1+ubuntu16.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inmar_contacts`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `status` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `name`, `mobile`, `email`, `user_id`, `group_id`, `status`) VALUES
(103, '2wSwFk6fr9', '8142241415', 'venkatasaisoft@gmail.com', 103, 3, 'Active'),
(104, 'ZhvFNufPIf', '8142241415', 'venkatasaisoft@gmail.com', 105, NULL, 'Active'),
(105, 'u5Jmb9WRXU', '8142241415', 'venkatasaisoft@gmail.com', 104, NULL, 'Active'),
(106, 'Varun', '8142241415', 'venkatasaisoft@gmail.com', 102, 9, 'InActive'),
(107, 'Bharath', '8142241415', 'venkatasaisoft@gmail.com', 102, 6, 'Active'),
(108, 'xd1P3hCme4', '8142241415', 'venkatasaisoft@gmail.com', 103, 3, 'Active'),
(111, 'PdPmj83ToE', '8142241415', 'venkatasaisoft@gmail.com', 105, NULL, 'Active'),
(113, 'UBAMqyr8BU', '8142241415', 'venkatasaisoft@gmail.com', 105, NULL, 'Active'),
(114, 'vEIMwCdW10', '8142241415', 'venkatasaisoft@gmail.com', 103, 3, 'Active'),
(115, '2Iib0zlo1j', '8142241415', 'venkatasaisoft@gmail.com', 103, 3, 'Active'),
(117, 'Jaswanth', '8142241415', 'venkatasaisoft@gmail.com', 102, 8, 'Active'),
(118, 'txYH7qj2hj', '8142241415', 'venkatasaisoft@gmail.com', 104, NULL, 'Active'),
(120, '17PxkRLRKm', '8142241415', 'venkatasaisoft@gmail.com', 104, NULL, 'Active'),
(121, 'Sankar k', '8142241415', 'sankar@gmail.com', 102, 7, 'Active'),
(122, 'AzV8SDsxpv', '8142241415', 'venkatasaisoft@gmail.com', 105, NULL, 'Active'),
(124, 'Ib3yxBV77k', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(125, '6OrIUiLlYv', '8142241415', 'venkatasaisoft@gmail.com', 105, NULL, 'Active'),
(127, 'S0Cf0fYBtI', '8142241415', 'venkatasaisoft@gmail.com', 105, NULL, 'Active'),
(128, 'qMRatrt7G1', '8142241415', 'venkatasaisoft@gmail.com', 103, 3, 'Active'),
(129, 'kcjagWgm9y', '8142241415', 'venkatasaisoft@gmail.com', 103, 3, 'Active'),
(130, '6qRlNwhOLc', '8142241415', 'venkatasaisoft@gmail.com', 103, 3, 'Active'),
(131, 'UVA7Lvf1vW', '8142241415', 'venkatasaisoft@gmail.com', 104, NULL, 'Active'),
(132, 'LXQ5HRQaPF', '8142241415', 'venkatasaisoft@gmail.com', 103, 3, 'Active'),
(133, 'PVpkm6a0lB', '8142241415', 'venkatasaisoft@gmail.com', 103, 3, 'Active'),
(134, '7wDfmQP7ul', '8142241415', 'venkatasaisoft@gmail.com', 104, NULL, 'Active'),
(136, 'N2KFTw9GQ1', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(137, 'HM7F5tKeqw', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(139, 'cpRdk8oSTv', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(140, 'odS7H0XoCK', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(141, '73FaEGqCoh', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(142, 'Bvrk2pACEL', '8142241415', 'venkatasaisoft@gmail.com', 105, NULL, 'Active'),
(143, 'Tl0VZt4f3G', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(144, 'a18JqZ8NT2', '8142241415', 'venkatasaisoft@gmail.com', 103, 3, 'Active'),
(145, 'xWj5NPmCQg', '8142241415', 'venkatasaisoft@gmail.com', 103, 3, 'Active'),
(146, '1uJSpdrzkz', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(147, 'Zi7RlBk2Xc', '8142241415', 'venkatasaisoft@gmail.com', 104, NULL, 'Active'),
(148, 'ZAK3vIEROi', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(149, 'DN4AqEeEZu', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(150, 'Mujahid', '8142241415', 'venkatasaisoft@gmail.com', 102, 6, 'Active'),
(151, 'kd6I19nWZh', '8142241415', 'venkatasaisoft@gmail.com', 105, NULL, 'Active'),
(152, 'n1xLMjnv7b', '8142241415', 'venkatasaisoft@gmail.com', 105, NULL, 'Active'),
(153, 'iIOZYbuAFY', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(154, '8hYg8tF1A7', '8142241415', 'venkatasaisoft@gmail.com', 104, NULL, 'Active'),
(156, 'lY4JSqdT4l', '8142241415', 'venkatasaisoft@gmail.com', 104, NULL, 'Active'),
(157, '7KcfErTQOw', '8142241415', 'venkatasaisoft@gmail.com', 105, NULL, 'Active'),
(158, 'ZPfdi6dCFw', '8142241415', 'venkatasaisoft@gmail.com', 105, NULL, 'Active'),
(160, 'O9abtoiv7A', '8142241415', 'venkatasaisoft@gmail.com', 104, NULL, 'Active'),
(161, 'MHVsxEjmjs', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(162, 'zLTaFXmID1', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(163, 'zB0HJMtUYf', '8142241415', 'venkatasaisoft@gmail.com', 103, 3, 'Active'),
(164, 'oV3japHwZQ', '8142241415', 'venkatasaisoft@gmail.com', 103, 3, 'Active'),
(165, 'lsi7saXKjs', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(166, 'wFimLi7dNV', '8142241415', 'venkatasaisoft@gmail.com', 102, 8, 'Active'),
(167, 'CksBVNNbOp', '8142241415', 'venkatasaisoft@gmail.com', 104, NULL, 'Active'),
(168, 'xHaRbXJ2nw', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(169, 'mUGGdMqvzJ', '8142241415', 'venkatasaisoft@gmail.com', 104, NULL, 'Active'),
(170, 'Pzjm7pVF6u', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(171, 'cNJxgqErx0', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(172, 'YgL8DY7BhZ', '8142241415', 'venkatasaisoft@gmail.com', 105, NULL, 'Active'),
(174, 'ziEeMCZukT', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(175, 'NgENlLxc54', '8142241415', 'venkatasaisoft@gmail.com', 102, 9, 'Active'),
(176, '8KozwB4ykm', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(177, 'kXZL2kbBcq', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(178, 'JU0HWbL0df', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(181, 'YxIHFXWrl3', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(182, 'ep7RAGWThU', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(183, '4kugMxWnoa', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(185, 'KeQGtlMPpz', '8142241415', 'venkatasaisoft@gmail.com', 104, NULL, 'Active'),
(186, 'oTvBKLPxNh', '8142241415', 'venkatasaisoft@gmail.com', 103, 3, 'Active'),
(187, 'kYFdnj1eCU', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(188, 'eqbuohT5eF', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(189, 'ZRKU6Ncrwh', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(191, 'Om1u17vZb2', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(192, 'kE4HOmotGW', '8142241415', 'venkatasaisoft@gmail.com', 103, 3, 'Active'),
(194, 'kQfsdE2i6I', '8142241415', 'venkatasaisoft@gmail.com', 104, NULL, 'Active'),
(195, 'G7lPtaIkQq', '8142241415', 'venkatasaisoft@gmail.com', 104, NULL, 'Active'),
(196, 'xJ5eS157Sx', '8142241415', 'venkatasaisoft@gmail.com', 105, NULL, 'Active'),
(197, 'vlUXdkaYaa', '8142241415', 'venkatasaisoft@gmail.com', 103, 3, 'Active'),
(199, 'EfgbSbrPJP', '8142241415', 'venkatasaisoft@gmail.com', 102, NULL, 'Active'),
(201, 'tBr4Qatt6d', '8142241415', 'venkatasaisoft@gmail.com', 104, NULL, 'Active'),
(202, 'QkERM7e7pX', '8142241415', 'venkatasaisoft@gmail.com', 103, 3, 'Active'),
(209, 'Dady', '9704305081', 'dadyksr@gmaill.com', 102, 7, 'Active'),
(211, 'manideep', '9666959695', 'manideep@gmail.com', 102, 8, 'Active'),
(212, 'venkata', '9449191919', 'venkalatasai@gmail.com', 102, 6, 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `contact_groups`
--

CREATE TABLE `contact_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `status` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contact_groups`
--

INSERT INTO `contact_groups` (`id`, `user_id`, `name`, `status`) VALUES
(3, 103, 'Friends', 'Active'),
(6, 102, 'Friends Only', 'Active'),
(7, 102, 'Parents', 'Inactive'),
(8, 102, 'Office', 'Inactive'),
(9, 102, 'Farmer', 'Active'),
(10, 102, 'VENKATA SAI KATEPALLI', 'Active'),
(11, 102, 'Family', 'Active'),
(12, 102, 'Tour', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `u_id` int(11) NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `aadharno` varchar(12) NOT NULL,
  `account_status` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`u_id`, `firstname`, `lastname`, `email`, `password`, `aadharno`, `account_status`, `created_at`) VALUES
(102, 'Venkata', 'sai', 'venkatasaisoft@inmar.com', '123456', '736923429', 1, '2018-02-18 15:30:55'),
(103, 'venkata', 'sai', 'venkatsai@inmar.com', '123', '736923429518', 1, '2018-02-20 02:48:04'),
(111, 'VENKATA', 'KATEPALLI', 'venkatsaisoft@inmar.com', '123456', '736923429518', 1, '2018-02-20 03:22:02'),
(112, 'Venkata', 'sai', 'sai@inmar.com', '123456', '123456789012', 1, '2018-02-20 03:37:30'),
(113, 'Venkata', 'sai', 'saismart@inmar.com', '123456', '123456789012', 1, '2018-02-20 03:39:32'),
(114, 'Venkata', 'sai', 'saiss@inmar.com', '123456', '123456789012', 1, '2018-02-20 03:39:58');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`,`user_id`),
  ADD KEY `contacts_user_id_index` (`user_id`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `contact_groups`
--
ALTER TABLE `contact_groups`
  ADD PRIMARY KEY (`id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`u_id`,`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=213;
--
-- AUTO_INCREMENT for table `contact_groups`
--
ALTER TABLE `contact_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `u_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `contacts`
--
ALTER TABLE `contacts`
  ADD CONSTRAINT `contacts_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `contact_groups` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `contact_groups`
--
ALTER TABLE `contact_groups`
  ADD CONSTRAINT `contact_groups_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`u_id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
