-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 03, 2013 at 02:01 PM
-- Server version: 5.5.28
-- PHP Version: 5.3.10-1ubuntu3.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `catalogscolar`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_425ae3c4` (`group_id`),
  KEY `auth_group_permissions_1e014c8f` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_1bb8f392` (`content_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=31 ;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add permission', 1, 'add_permission'),
(2, 'Can change permission', 1, 'change_permission'),
(3, 'Can delete permission', 1, 'delete_permission'),
(4, 'Can add group', 2, 'add_group'),
(5, 'Can change group', 2, 'change_group'),
(6, 'Can delete group', 2, 'delete_group'),
(7, 'Can add user', 3, 'add_user'),
(8, 'Can change user', 3, 'change_user'),
(9, 'Can delete user', 3, 'delete_user'),
(10, 'Can add content type', 4, 'add_contenttype'),
(11, 'Can change content type', 4, 'change_contenttype'),
(12, 'Can delete content type', 4, 'delete_contenttype'),
(13, 'Can add session', 5, 'add_session'),
(14, 'Can change session', 5, 'change_session'),
(15, 'Can delete session', 5, 'delete_session'),
(16, 'Can add site', 6, 'add_site'),
(17, 'Can change site', 6, 'change_site'),
(18, 'Can delete site', 6, 'delete_site'),
(19, 'Can add clase', 7, 'add_clase'),
(20, 'Can change clase', 7, 'change_clase'),
(21, 'Can delete clase', 7, 'delete_clase'),
(22, 'Can add elevi', 8, 'add_elevi'),
(23, 'Can change elevi', 8, 'change_elevi'),
(24, 'Can delete elevi', 8, 'delete_elevi'),
(25, 'Can add materii', 9, 'add_materii'),
(26, 'Can change materii', 9, 'change_materii'),
(27, 'Can delete materii', 9, 'delete_materii'),
(28, 'Can add note', 10, 'add_note'),
(29, 'Can change note', 10, 'change_note'),
(30, 'Can delete note', 10, 'delete_note');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `username`, `first_name`, `last_name`, `email`, `password`, `is_staff`, `is_active`, `is_superuser`, `last_login`, `date_joined`) VALUES
(1, 'florin', '', '', 'stancu.florin23@gmail.com', 'pbkdf2_sha256$10000$cPaw50clDe1m$ti5z/KFWn5YDn2wPzRx2hNtbZaiVtb7cvh6mRkKN/hs=', 1, 1, 1, '2012-12-22 07:43:14', '2012-12-22 07:43:14');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_403f60f` (`user_id`),
  KEY `auth_user_groups_425ae3c4` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_403f60f` (`user_id`),
  KEY `auth_user_user_permissions_1e014c8f` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `catalog_clase`
--

CREATE TABLE IF NOT EXISTS `catalog_clase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nume` varchar(100) NOT NULL,
  `an` varchar(100) NOT NULL,
  `profesor` varchar(100) NOT NULL,
  `status` int(11) NOT NULL,
  `descriere` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `catalog_clase`
--

INSERT INTO `catalog_clase` (`id`, `nume`, `an`, `profesor`, `status`, `descriere`) VALUES
(1, 'Clasa a IV-a', '2012 - 2013', 'Stancu Valentina', 2, 'Descrierea nu este obligatorie.');

-- --------------------------------------------------------

--
-- Table structure for table `catalog_elevi`
--

CREATE TABLE IF NOT EXISTS `catalog_elevi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nume` varchar(100) NOT NULL,
  `prenume` varchar(100) NOT NULL,
  `clasa_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `catalog_elevi_6890e0b9` (`clasa_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `catalog_elevi`
--

INSERT INTO `catalog_elevi` (`id`, `nume`, `prenume`, `clasa_id`) VALUES
(1, 'Stancu', 'Florin', 1),
(2, 'Turcu', 'Daniel', 1),
(4, 'Brinzea', 'Claudiu', 1);

-- --------------------------------------------------------

--
-- Table structure for table `catalog_materii`
--

CREATE TABLE IF NOT EXISTS `catalog_materii` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nume` varchar(100) NOT NULL,
  `clasa_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `catalog_materii_6890e0b9` (`clasa_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `catalog_materii`
--

INSERT INTO `catalog_materii` (`id`, `nume`, `clasa_id`) VALUES
(1, 'Engleza', 1),
(2, 'Romana', 1),
(3, 'Matematica', 1),
(4, 'Materie1', 1),
(5, 'Materie2', 1),
(6, 'Materie3', 1),
(7, 'Materie4', 1),
(8, 'Materie5', 1),
(9, 'Materie6', 1),
(10, 'Materie7', 1),
(11, 'Materie8', 1),
(12, 'Materie9', 1),
(13, 'Materie10', 1),
(14, 'Materie11', 1),
(15, 'Materie12', 1);

-- --------------------------------------------------------

--
-- Table structure for table `catalog_note`
--

CREATE TABLE IF NOT EXISTS `catalog_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `materie_id` int(11) NOT NULL,
  `semestru` int(11) NOT NULL,
  `nota` int(11) NOT NULL,
  `elev_id` int(11) NOT NULL,
  `data` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `catalog_note_202ce342` (`materie_id`),
  KEY `catalog_note_e9ff562` (`elev_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=24 ;

--
-- Dumping data for table `catalog_note`
--

INSERT INTO `catalog_note` (`id`, `materie_id`, `semestru`, `nota`, `elev_id`, `data`) VALUES
(10, 1, 1, 3, 4, '2012-10-16'),
(12, 1, 1, 2, 4, '2012-12-19'),
(14, 1, 1, 4, 4, '2012-12-26'),
(16, 1, 1, 3, 4, '2012-11-13'),
(17, 1, 1, 2, 4, '2012-10-19'),
(18, 2, 1, 4, 4, '2012-12-04'),
(19, 2, 1, 4, 4, '2012-12-13'),
(21, 1, 1, 1, 4, '2012-09-27'),
(22, 1, 2, 4, 4, '2013-03-20'),
(23, 1, 2, 2, 4, '2013-03-14');

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `name`, `app_label`, `model`) VALUES
(1, 'permission', 'auth', 'permission'),
(2, 'group', 'auth', 'group'),
(3, 'user', 'auth', 'user'),
(4, 'content type', 'contenttypes', 'contenttype'),
(5, 'session', 'sessions', 'session'),
(6, 'site', 'sites', 'site'),
(7, 'clase', 'catalog', 'clase'),
(8, 'elevi', 'catalog', 'elevi'),
(9, 'materii', 'catalog', 'materii'),
(10, 'note', 'catalog', 'note');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_3da3d3d8` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('128603330177a8086d4c23ed8bd8b76f', 'NTUzOGFjODVkOTQxYjdkNjAyNDcyNzgxMzI1OWZlODBmMWNhNGY0NjqAAn1xAVUEZWxldnECY2Rq\nYW5nby5kYi5tb2RlbHMuYmFzZQptb2RlbF91bnBpY2tsZQpxA2NjYXRhbG9nLm1vZGVscwpFbGV2\naQpxBF1jZGphbmdvLmRiLm1vZGVscy5iYXNlCnNpbXBsZV9jbGFzc19mYWN0b3J5CnEFh1JxBn1x\nByhVDF9jbGFzYV9jYWNoZXEIaANjY2F0YWxvZy5tb2RlbHMKQ2xhc2UKcQldaAWHUnEKfXELKFUG\nc3RhdHVzcQyKAFUGX3N0YXRlcQ1jZGphbmdvLmRiLm1vZGVscy5iYXNlCk1vZGVsU3RhdGUKcQ4p\ngXEPfXEQKFUGYWRkaW5ncRGJVQJkYnESVQdkZWZhdWx0cRN1YlUCYW5xFFgLAAAAMjAxMiAtIDIw\nMTNVBG51bWVxFVgMAAAAQ2xhc2EgYSBJVi1hVQhwcm9mZXNvcnEWWBAAAABTdGFuY3UgVmFsZW50\naW5hVQlkZXNjcmllcmVxF1gfAAAARGVzY3JpZXJlYSBudSBlc3RlIG9ibGlnYXRvcmllLlUCaWRx\nGIoBAXViVQdwcmVudW1lcRlYBwAAAENsYXVkaXVoDWgOKYFxGn1xGyhoEYloEmgTdWJoFVgHAAAA\nQnJpbnplYVUIY2xhc2FfaWRxHIoBAWgYigEEdWJzLg==\n', '2013-01-07 14:25:24'),
('729c44d08a6c96008632de6a75e18fda', 'ZGQ1MmViNWZjN2YxMWE3MjBmNDU0NGQyMzY0NzIyOGNkNzRjMGE5ZTqAAn1xAShVBGVsZXZjZGph\nbmdvLmRiLm1vZGVscy5iYXNlCm1vZGVsX3VucGlja2xlCnECY2NhdGFsb2cubW9kZWxzCkVsZXZp\nCnEDXWNkamFuZ28uZGIubW9kZWxzLmJhc2UKc2ltcGxlX2NsYXNzX2ZhY3RvcnkKcQSHUnEFfXEG\nKFUMX2NsYXNhX2NhY2hlcQdoAmNjYXRhbG9nLm1vZGVscwpDbGFzZQpxCF1oBIdScQl9cQooVQZz\ndGF0dXNxC4oBAlUGX3N0YXRlcQxjZGphbmdvLmRiLm1vZGVscy5iYXNlCk1vZGVsU3RhdGUKcQ0p\ngXEOfXEPKFUGYWRkaW5ncRCJVQJkYnERVQdkZWZhdWx0cRJ1YlUCYW5xE1gLAAAAMjAxMiAtIDIw\nMTNVBG51bWVxFFgMAAAAQ2xhc2EgYSBJVi1hVQhwcm9mZXNvcnEVWBAAAABTdGFuY3UgVmFsZW50\naW5hVQlkZXNjcmllcmVxFlgfAAAARGVzY3JpZXJlYSBudSBlc3RlIG9ibGlnYXRvcmllLlUCaWRx\nF4oBAXViVQdwcmVudW1lcRhYBwAAAENsYXVkaXVoDGgNKYFxGX1xGihoEIloEWgSdWJoFFgHAAAA\nQnJpbnplYVUIY2xhc2FfaWRxG4oBAWgXigEEdWJVB21hdGVyaWVoAmNjYXRhbG9nLm1vZGVscwpN\nYXRlcmlpCnEcXWgEh1JxHX1xHihoB2gCaAhdaASHUnEffXEgKGgLigEBaAxoDSmBcSF9cSIoaBCJ\naBFVB2RlZmF1bHRxI3ViaBNYCwAAADIwMTIgLSAyMDEzaBRYDAAAAENsYXNhIGEgSVYtYWgVWBAA\nAABTdGFuY3UgVmFsZW50aW5haBZYHwAAAERlc2NyaWVyZWEgbnUgZXN0ZSBvYmxpZ2F0b3JpZS5o\nF4oBAXViaBRYCAAAAE1hdGVyaWU4aBuKAQFoDGgNKYFxJH1xJShoEIloEWgjdWJoF4oBDHViVQVj\nbGFzYWgCaAhdaASHUnEmfXEnKGgLigEBaAxoDSmBcSh9cSkoaBCJaBFVB2RlZmF1bHRxKnViaBNY\nCwAAADIwMTIgLSAyMDEzaBRYDAAAAENsYXNhIGEgSVYtYWgVWBAAAABTdGFuY3UgVmFsZW50aW5h\naBZYHwAAAERlc2NyaWVyZWEgbnUgZXN0ZSBvYmxpZ2F0b3JpZS5oF4oBAXVidS4=\n', '2013-01-17 11:36:45'),
('c0c412fca5eb53985e6e1f1fe6b5be52', 'OWU2MDEwMWMxYWE2M2U0YTdjZGYzMWNmMWUwYjY2N2RlZGZlNzliNjqAAn1xAShVBGVsZXZjZGph\nbmdvLmRiLm1vZGVscy5iYXNlCm1vZGVsX3VucGlja2xlCnECY2NhdGFsb2cubW9kZWxzCkVsZXZp\nCnEDXWNkamFuZ28uZGIubW9kZWxzLmJhc2UKc2ltcGxlX2NsYXNzX2ZhY3RvcnkKcQSHUnEFfXEG\nKFUMX2NsYXNhX2NhY2hlaAJjY2F0YWxvZy5tb2RlbHMKQ2xhc2UKcQddaASHUnEIfXEJKFUGc3Rh\ndHVzcQqKAQJVBl9zdGF0ZXELY2RqYW5nby5kYi5tb2RlbHMuYmFzZQpNb2RlbFN0YXRlCnEMKYFx\nDX1xDihVBmFkZGluZ3EPiVUCZGJxEFUHZGVmYXVsdHERdWJVAmFucRJYCwAAADIwMTIgLSAyMDEz\nVQRudW1lcRNYDAAAAENsYXNhIGEgSVYtYVUIcHJvZmVzb3JxFFgQAAAAU3RhbmN1IFZhbGVudGlu\nYVUJZGVzY3JpZXJlcRVYHwAAAERlc2NyaWVyZWEgbnUgZXN0ZSBvYmxpZ2F0b3JpZS5VAmlkcRaK\nAQF1YlUHcHJlbnVtZXEXWAcAAABDbGF1ZGl1aAtoDCmBcRh9cRkoaA+JaBBoEXViaBNYBwAAAEJy\naW56ZWFVCGNsYXNhX2lkcRqKAQFoFooBBHViVQVjbGFzYWgCaAddaASHUnEbfXEcKGgKigECaAto\nDCmBcR19cR4oaA+JaBBVB2RlZmF1bHRxH3ViaBJYCwAAADIwMTIgLSAyMDEzaBNYDAAAAENsYXNh\nIGEgSVYtYWgUWBAAAABTdGFuY3UgVmFsZW50aW5haBVYHwAAAERlc2NyaWVyZWEgbnUgZXN0ZSBv\nYmxpZ2F0b3JpZS5oFooBAXVidS4=\n', '2013-01-07 16:50:45');

-- --------------------------------------------------------

--
-- Table structure for table `django_site`
--

CREATE TABLE IF NOT EXISTS `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `django_site`
--

INSERT INTO `django_site` (`id`, `domain`, `name`) VALUES
(1, 'example.com', 'example.com');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `group_id_refs_id_3cea63fe` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `permission_id_refs_id_5886d21f` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `content_type_id_refs_id_728de91f` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `group_id_refs_id_f116770` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `user_id_refs_id_7ceef80f` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `permission_id_refs_id_67e79cb` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `user_id_refs_id_dfbab7d` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `catalog_elevi`
--
ALTER TABLE `catalog_elevi`
  ADD CONSTRAINT `clasa_id_refs_id_23022bc4` FOREIGN KEY (`clasa_id`) REFERENCES `catalog_clase` (`id`);

--
-- Constraints for table `catalog_materii`
--
ALTER TABLE `catalog_materii`
  ADD CONSTRAINT `clasa_id_refs_id_68b00f4c` FOREIGN KEY (`clasa_id`) REFERENCES `catalog_clase` (`id`);

--
-- Constraints for table `catalog_note`
--
ALTER TABLE `catalog_note`
  ADD CONSTRAINT `elev_id_refs_id_1b346125` FOREIGN KEY (`elev_id`) REFERENCES `catalog_elevi` (`id`),
  ADD CONSTRAINT `materie_id_refs_id_128b47d5` FOREIGN KEY (`materie_id`) REFERENCES `catalog_materii` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
