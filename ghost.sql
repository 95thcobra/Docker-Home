-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Aug 18, 2018 at 04:33 AM
-- Server version: 10.1.35-MariaDB
-- PHP Version: 7.2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ghost`
--
DROP DATABASE `ghost`;
CREATE DATABASE IF NOT EXISTS `ghost` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ghost`;

-- --------------------------------------------------------

--
-- Table structure for table `accesstokens`
--

DROP TABLE IF EXISTS `accesstokens`;
CREATE TABLE IF NOT EXISTS `accesstokens` (
  `id` varchar(24) NOT NULL,
  `token` varchar(191) NOT NULL,
  `user_id` varchar(24) NOT NULL,
  `client_id` varchar(24) NOT NULL,
  `issued_by` varchar(24) DEFAULT NULL,
  `expires` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accesstokens_token_unique` (`token`),
  KEY `accesstokens_user_id_foreign` (`user_id`),
  KEY `accesstokens_client_id_foreign` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `accesstokens`
--

INSERT INTO `accesstokens` (`id`, `token`, `user_id`, `client_id`, `issued_by`, `expires`) VALUES
('5b77987386ea86007956775a', 'G6eOQOcgj1ym2KT3wVQrEuR9UvVbgYXRnDyveLuthJWPfMy4G2M0DHHrfvuS7BhbtyUwJQGY6yTkqAWMAGVKfbc08MVM8QWeFMiumWbTie839bs9sq7858pra5agyK2uBIKOTJA7YEaiblDudpSv9haENqs9ZnE2DTcY5blX84sS8I0KrCZNGQtHjRGFur6', '1', '5b77982bc10214003b07bf24', '5b77987386ea860079567759', 1537192467659);

-- --------------------------------------------------------

--
-- Table structure for table `apps`
--

DROP TABLE IF EXISTS `apps`;
CREATE TABLE IF NOT EXISTS `apps` (
  `id` varchar(24) NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `version` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'inactive',
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `apps_name_unique` (`name`),
  UNIQUE KEY `apps_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `app_fields`
--

DROP TABLE IF EXISTS `app_fields`;
CREATE TABLE IF NOT EXISTS `app_fields` (
  `id` varchar(24) NOT NULL,
  `key` varchar(50) NOT NULL,
  `value` text,
  `type` varchar(50) NOT NULL DEFAULT 'html',
  `app_id` varchar(24) NOT NULL,
  `relatable_id` varchar(24) NOT NULL,
  `relatable_type` varchar(50) NOT NULL DEFAULT 'posts',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_fields_app_id_foreign` (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `app_settings`
--

DROP TABLE IF EXISTS `app_settings`;
CREATE TABLE IF NOT EXISTS `app_settings` (
  `id` varchar(24) NOT NULL,
  `key` varchar(50) NOT NULL,
  `value` text,
  `app_id` varchar(24) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_settings_key_unique` (`key`),
  KEY `app_settings_app_id_foreign` (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `brute`
--

DROP TABLE IF EXISTS `brute`;
CREATE TABLE IF NOT EXISTS `brute` (
  `key` varchar(191) NOT NULL,
  `firstRequest` bigint(20) NOT NULL,
  `lastRequest` bigint(20) NOT NULL,
  `lifetime` bigint(20) NOT NULL,
  `count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `brute`
--

INSERT INTO `brute` (`key`, `firstRequest`, `lastRequest`, `lifetime`, `count`) VALUES
('wU+FjBVnYVPBZJ/guCSWLeGxQxQCynfR+6AnRS6rRGQ=', 1534564467506, 1534564467506, 1534568067511, 1);

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id` varchar(24) NOT NULL,
  `uuid` varchar(36) NOT NULL,
  `name` varchar(50) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `redirection_uri` varchar(2000) DEFAULT NULL,
  `client_uri` varchar(2000) DEFAULT NULL,
  `auth_uri` varchar(2000) DEFAULT NULL,
  `logo` varchar(2000) DEFAULT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'development',
  `type` varchar(50) NOT NULL DEFAULT 'ua',
  `description` varchar(2000) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clients_name_unique` (`name`),
  UNIQUE KEY `clients_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `uuid`, `name`, `slug`, `secret`, `redirection_uri`, `client_uri`, `auth_uri`, `logo`, `status`, `type`, `description`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
('5b77982bc10214003b07bf24', '35c9db89-a9f2-4ec0-b6ac-fcaf82c73d39', 'Ghost Admin', 'ghost-admin', '43d423eaa383', NULL, NULL, NULL, NULL, 'enabled', 'ua', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf25', '4da40a41-5129-48d7-a57d-926ed4b29e46', 'Ghost Frontend', 'ghost-frontend', '0acabf4b2ffa', NULL, NULL, NULL, NULL, 'enabled', 'ua', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf26', '2f41211c-e2fc-42c4-aaaa-bd3f618add33', 'Ghost Scheduler', 'ghost-scheduler', '2b75816f982b', NULL, NULL, NULL, NULL, 'enabled', 'web', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf27', '7875d69e-6d4a-4867-a8ed-87ea14e7c214', 'Ghost Backup', 'ghost-backup', '1250b1bc10ce', NULL, NULL, NULL, NULL, 'enabled', 'web', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1');

-- --------------------------------------------------------

--
-- Table structure for table `client_trusted_domains`
--

DROP TABLE IF EXISTS `client_trusted_domains`;
CREATE TABLE IF NOT EXISTS `client_trusted_domains` (
  `id` varchar(24) NOT NULL,
  `client_id` varchar(24) NOT NULL,
  `trusted_domain` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_trusted_domains_client_id_foreign` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `invites`
--

DROP TABLE IF EXISTS `invites`;
CREATE TABLE IF NOT EXISTS `invites` (
  `id` varchar(24) NOT NULL,
  `role_id` varchar(24) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'pending',
  `token` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `expires` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invites_token_unique` (`token`),
  UNIQUE KEY `invites_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `version` varchar(70) NOT NULL,
  `currentVersion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `migrations_name_version_unique` (`name`,`version`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `name`, `version`, `currentVersion`) VALUES
(1, '1-create-tables.js', 'init', '1.25'),
(2, '2-create-fixtures.js', 'init', '1.25'),
(3, '1-post-excerpt.js', '1.3', '1.25'),
(4, '1-codeinjection-post.js', '1.4', '1.25'),
(5, '1-og-twitter-post.js', '1.5', '1.25'),
(6, '1-add-backup-client.js', '1.7', '1.25'),
(7, '1-add-permissions-redirect.js', '1.9', '1.25'),
(8, '1-custom-template-post.js', '1.13', '1.25'),
(9, '2-theme-permissions.js', '1.13', '1.25'),
(10, '1-add-webhooks-table.js', '1.18', '1.25'),
(11, '1-webhook-permissions.js', '1.19', '1.25'),
(12, '1-remove-settings-keys.js', '1.20', '1.25'),
(13, '1-add-contributor-role.js', '1.21', '1.25'),
(14, '1-multiple-authors-DDL.js', '1.22', '1.25'),
(15, '1-multiple-authors-DML.js', '1.22', '1.25'),
(16, '1-update-koenig-beta-html.js', '1.25', '1.25'),
(17, '2-demo-post.js', '1.25', '1.25');

-- --------------------------------------------------------

--
-- Table structure for table `migrations_lock`
--

DROP TABLE IF EXISTS `migrations_lock`;
CREATE TABLE IF NOT EXISTS `migrations_lock` (
  `lock_key` varchar(191) NOT NULL,
  `locked` tinyint(1) DEFAULT '0',
  `acquired_at` datetime DEFAULT NULL,
  `released_at` datetime DEFAULT NULL,
  UNIQUE KEY `migrations_lock_lock_key_unique` (`lock_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `migrations_lock`
--

INSERT INTO `migrations_lock` (`lock_key`, `locked`, `acquired_at`, `released_at`) VALUES
('km01', 0, '2018-08-18 03:58:37', '2018-08-18 03:58:37');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` varchar(24) NOT NULL,
  `name` varchar(50) NOT NULL,
  `object_type` varchar(50) NOT NULL,
  `action_type` varchar(50) NOT NULL,
  `object_id` varchar(24) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `object_type`, `action_type`, `object_id`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
('5b77982bc10214003b07bf2d', 'Export database', 'db', 'exportContent', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf2e', 'Import database', 'db', 'importContent', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf2f', 'Delete all content', 'db', 'deleteAllContent', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf30', 'Send mail', 'mail', 'send', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf31', 'Browse notifications', 'notification', 'browse', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf32', 'Add notifications', 'notification', 'add', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf33', 'Delete notifications', 'notification', 'destroy', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf34', 'Browse posts', 'post', 'browse', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf35', 'Read posts', 'post', 'read', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf36', 'Edit posts', 'post', 'edit', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf37', 'Add posts', 'post', 'add', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf38', 'Delete posts', 'post', 'destroy', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf39', 'Browse settings', 'setting', 'browse', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf3a', 'Read settings', 'setting', 'read', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf3b', 'Edit settings', 'setting', 'edit', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf3c', 'Generate slugs', 'slug', 'generate', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf3d', 'Browse tags', 'tag', 'browse', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf3e', 'Read tags', 'tag', 'read', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf3f', 'Edit tags', 'tag', 'edit', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf40', 'Add tags', 'tag', 'add', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf41', 'Delete tags', 'tag', 'destroy', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf42', 'Browse themes', 'theme', 'browse', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf43', 'Edit themes', 'theme', 'edit', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf44', 'Activate themes', 'theme', 'activate', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf45', 'Upload themes', 'theme', 'add', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf46', 'Download themes', 'theme', 'read', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf47', 'Delete themes', 'theme', 'destroy', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf48', 'Browse users', 'user', 'browse', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf49', 'Read users', 'user', 'read', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf4a', 'Edit users', 'user', 'edit', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf4b', 'Add users', 'user', 'add', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf4c', 'Delete users', 'user', 'destroy', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf4d', 'Assign a role', 'role', 'assign', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf4e', 'Browse roles', 'role', 'browse', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf4f', 'Browse clients', 'client', 'browse', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf50', 'Read clients', 'client', 'read', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf51', 'Edit clients', 'client', 'edit', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf52', 'Add clients', 'client', 'add', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf53', 'Delete clients', 'client', 'destroy', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf54', 'Browse subscribers', 'subscriber', 'browse', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf55', 'Read subscribers', 'subscriber', 'read', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf56', 'Edit subscribers', 'subscriber', 'edit', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf57', 'Add subscribers', 'subscriber', 'add', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf58', 'Delete subscribers', 'subscriber', 'destroy', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf59', 'Browse invites', 'invite', 'browse', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf5a', 'Read invites', 'invite', 'read', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf5b', 'Edit invites', 'invite', 'edit', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf5c', 'Add invites', 'invite', 'add', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf5d', 'Delete invites', 'invite', 'destroy', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf5e', 'Download redirects', 'redirect', 'download', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf5f', 'Upload redirects', 'redirect', 'upload', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf60', 'Add webhooks', 'webhook', 'add', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf61', 'Delete webhooks', 'webhook', 'destroy', NULL, '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1');

-- --------------------------------------------------------

--
-- Table structure for table `permissions_apps`
--

DROP TABLE IF EXISTS `permissions_apps`;
CREATE TABLE IF NOT EXISTS `permissions_apps` (
  `id` varchar(24) NOT NULL,
  `app_id` varchar(24) NOT NULL,
  `permission_id` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `permissions_roles`
--

DROP TABLE IF EXISTS `permissions_roles`;
CREATE TABLE IF NOT EXISTS `permissions_roles` (
  `id` varchar(24) NOT NULL,
  `role_id` varchar(24) NOT NULL,
  `permission_id` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `permissions_roles`
--

INSERT INTO `permissions_roles` (`id`, `role_id`, `permission_id`) VALUES
('5b77982cc10214003b07bf73', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf2d'),
('5b77982cc10214003b07bf74', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf2e'),
('5b77982cc10214003b07bf75', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf2f'),
('5b77982cc10214003b07bf76', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf30'),
('5b77982cc10214003b07bf77', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf31'),
('5b77982cc10214003b07bf78', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf32'),
('5b77982cc10214003b07bf79', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf33'),
('5b77982cc10214003b07bf7a', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf34'),
('5b77982cc10214003b07bf7b', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf35'),
('5b77982cc10214003b07bf7c', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf36'),
('5b77982cc10214003b07bf7d', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf37'),
('5b77982cc10214003b07bf7e', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf38'),
('5b77982cc10214003b07bf7f', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf39'),
('5b77982cc10214003b07bf80', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf3a'),
('5b77982cc10214003b07bf81', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf3b'),
('5b77982cc10214003b07bf82', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf3c'),
('5b77982cc10214003b07bf83', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf3d'),
('5b77982cc10214003b07bf84', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf3e'),
('5b77982cc10214003b07bf85', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf3f'),
('5b77982cc10214003b07bf86', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf40'),
('5b77982cc10214003b07bf87', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf41'),
('5b77982cc10214003b07bf88', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf42'),
('5b77982cc10214003b07bf89', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf43'),
('5b77982cc10214003b07bf8a', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf44'),
('5b77982cc10214003b07bf8b', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf45'),
('5b77982cc10214003b07bf8c', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf46'),
('5b77982cc10214003b07bf8d', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf47'),
('5b77982cc10214003b07bf8e', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf48'),
('5b77982cc10214003b07bf8f', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf49'),
('5b77982cc10214003b07bf90', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf4a'),
('5b77982cc10214003b07bf91', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf4b'),
('5b77982cc10214003b07bf92', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf4c'),
('5b77982cc10214003b07bf93', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf4d'),
('5b77982cc10214003b07bf94', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf4e'),
('5b77982cc10214003b07bf95', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf4f'),
('5b77982cc10214003b07bf96', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf50'),
('5b77982cc10214003b07bf97', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf51'),
('5b77982cc10214003b07bf98', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf52'),
('5b77982cc10214003b07bf99', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf53'),
('5b77982cc10214003b07bf9a', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf54'),
('5b77982cc10214003b07bf9b', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf55'),
('5b77982cc10214003b07bf9c', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf56'),
('5b77982cc10214003b07bf9d', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf57'),
('5b77982cc10214003b07bf9e', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf58'),
('5b77982cc10214003b07bf9f', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf59'),
('5b77982cc10214003b07bfa0', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf5a'),
('5b77982cc10214003b07bfa1', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf5b'),
('5b77982cc10214003b07bfa2', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf5c'),
('5b77982cc10214003b07bfa3', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf5d'),
('5b77982cc10214003b07bfa4', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf5e'),
('5b77982cc10214003b07bfa5', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf5f'),
('5b77982cc10214003b07bfa6', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf60'),
('5b77982cc10214003b07bfa7', '5b77982bc10214003b07bf28', '5b77982bc10214003b07bf61'),
('5b77982cc10214003b07bfa8', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf34'),
('5b77982cc10214003b07bfa9', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf35'),
('5b77982cc10214003b07bfaa', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf36'),
('5b77982cc10214003b07bfab', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf37'),
('5b77982cc10214003b07bfac', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf38'),
('5b77982cc10214003b07bfad', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf39'),
('5b77982cc10214003b07bfae', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf3a'),
('5b77982cc10214003b07bfaf', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf3c'),
('5b77982cc10214003b07bfb0', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf3d'),
('5b77982cc10214003b07bfb1', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf3e'),
('5b77982cc10214003b07bfb2', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf3f'),
('5b77982cc10214003b07bfb3', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf40'),
('5b77982cc10214003b07bfb4', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf41'),
('5b77982cc10214003b07bfb5', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf48'),
('5b77982cc10214003b07bfb6', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf49'),
('5b77982cc10214003b07bfb7', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf4a'),
('5b77982cc10214003b07bfb8', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf4b'),
('5b77982cc10214003b07bfb9', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf4c'),
('5b77982cc10214003b07bfba', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf4d'),
('5b77982cc10214003b07bfbb', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf4e'),
('5b77982cc10214003b07bfbc', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf4f'),
('5b77982cc10214003b07bfbd', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf50'),
('5b77982cc10214003b07bfbe', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf51'),
('5b77982cc10214003b07bfbf', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf52'),
('5b77982cc10214003b07bfc0', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf53'),
('5b77982cc10214003b07bfc1', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf57'),
('5b77982cc10214003b07bfc2', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf59'),
('5b77982cc10214003b07bfc3', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf5a'),
('5b77982cc10214003b07bfc4', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf5b'),
('5b77982cc10214003b07bfc5', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf5c'),
('5b77982cc10214003b07bfc6', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf5d'),
('5b77982cc10214003b07bfc7', '5b77982bc10214003b07bf29', '5b77982bc10214003b07bf42'),
('5b77982cc10214003b07bfc8', '5b77982bc10214003b07bf2a', '5b77982bc10214003b07bf34'),
('5b77982cc10214003b07bfc9', '5b77982bc10214003b07bf2a', '5b77982bc10214003b07bf35'),
('5b77982cc10214003b07bfca', '5b77982bc10214003b07bf2a', '5b77982bc10214003b07bf37'),
('5b77982cc10214003b07bfcb', '5b77982bc10214003b07bf2a', '5b77982bc10214003b07bf39'),
('5b77982cc10214003b07bfcc', '5b77982bc10214003b07bf2a', '5b77982bc10214003b07bf3a'),
('5b77982cc10214003b07bfcd', '5b77982bc10214003b07bf2a', '5b77982bc10214003b07bf3c'),
('5b77982cc10214003b07bfce', '5b77982bc10214003b07bf2a', '5b77982bc10214003b07bf3d'),
('5b77982cc10214003b07bfcf', '5b77982bc10214003b07bf2a', '5b77982bc10214003b07bf3e'),
('5b77982cc10214003b07bfd0', '5b77982bc10214003b07bf2a', '5b77982bc10214003b07bf40'),
('5b77982cc10214003b07bfd1', '5b77982bc10214003b07bf2a', '5b77982bc10214003b07bf48'),
('5b77982cc10214003b07bfd2', '5b77982bc10214003b07bf2a', '5b77982bc10214003b07bf49'),
('5b77982cc10214003b07bfd3', '5b77982bc10214003b07bf2a', '5b77982bc10214003b07bf4e'),
('5b77982cc10214003b07bfd4', '5b77982bc10214003b07bf2a', '5b77982bc10214003b07bf4f'),
('5b77982cc10214003b07bfd5', '5b77982bc10214003b07bf2a', '5b77982bc10214003b07bf50'),
('5b77982cc10214003b07bfd6', '5b77982bc10214003b07bf2a', '5b77982bc10214003b07bf51'),
('5b77982cc10214003b07bfd7', '5b77982bc10214003b07bf2a', '5b77982bc10214003b07bf52'),
('5b77982cc10214003b07bfd8', '5b77982bc10214003b07bf2a', '5b77982bc10214003b07bf53'),
('5b77982cc10214003b07bfd9', '5b77982bc10214003b07bf2a', '5b77982bc10214003b07bf57'),
('5b77982cc10214003b07bfda', '5b77982bc10214003b07bf2a', '5b77982bc10214003b07bf42'),
('5b77982cc10214003b07bfdb', '5b77982bc10214003b07bf2b', '5b77982bc10214003b07bf34'),
('5b77982cc10214003b07bfdc', '5b77982bc10214003b07bf2b', '5b77982bc10214003b07bf35'),
('5b77982cc10214003b07bfdd', '5b77982bc10214003b07bf2b', '5b77982bc10214003b07bf37'),
('5b77982cc10214003b07bfde', '5b77982bc10214003b07bf2b', '5b77982bc10214003b07bf39'),
('5b77982cc10214003b07bfdf', '5b77982bc10214003b07bf2b', '5b77982bc10214003b07bf3a'),
('5b77982cc10214003b07bfe0', '5b77982bc10214003b07bf2b', '5b77982bc10214003b07bf3c'),
('5b77982cc10214003b07bfe1', '5b77982bc10214003b07bf2b', '5b77982bc10214003b07bf3d'),
('5b77982cc10214003b07bfe2', '5b77982bc10214003b07bf2b', '5b77982bc10214003b07bf3e'),
('5b77982cc10214003b07bfe3', '5b77982bc10214003b07bf2b', '5b77982bc10214003b07bf48'),
('5b77982cc10214003b07bfe4', '5b77982bc10214003b07bf2b', '5b77982bc10214003b07bf49'),
('5b77982cc10214003b07bfe5', '5b77982bc10214003b07bf2b', '5b77982bc10214003b07bf4e'),
('5b77982cc10214003b07bfe6', '5b77982bc10214003b07bf2b', '5b77982bc10214003b07bf4f'),
('5b77982cc10214003b07bfe7', '5b77982bc10214003b07bf2b', '5b77982bc10214003b07bf50'),
('5b77982cc10214003b07bfe8', '5b77982bc10214003b07bf2b', '5b77982bc10214003b07bf51'),
('5b77982cc10214003b07bfe9', '5b77982bc10214003b07bf2b', '5b77982bc10214003b07bf52'),
('5b77982cc10214003b07bfea', '5b77982bc10214003b07bf2b', '5b77982bc10214003b07bf53'),
('5b77982cc10214003b07bfeb', '5b77982bc10214003b07bf2b', '5b77982bc10214003b07bf57'),
('5b77982cc10214003b07bfec', '5b77982bc10214003b07bf2b', '5b77982bc10214003b07bf42');

-- --------------------------------------------------------

--
-- Table structure for table `permissions_users`
--

DROP TABLE IF EXISTS `permissions_users`;
CREATE TABLE IF NOT EXISTS `permissions_users` (
  `id` varchar(24) NOT NULL,
  `user_id` varchar(24) NOT NULL,
  `permission_id` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `id` varchar(24) NOT NULL,
  `uuid` varchar(36) NOT NULL,
  `title` varchar(2000) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `mobiledoc` longtext,
  `html` longtext,
  `amp` longtext,
  `plaintext` longtext,
  `feature_image` varchar(2000) DEFAULT NULL,
  `featured` tinyint(1) NOT NULL DEFAULT '0',
  `page` tinyint(1) NOT NULL DEFAULT '0',
  `status` varchar(50) NOT NULL DEFAULT 'draft',
  `locale` varchar(6) DEFAULT NULL,
  `visibility` varchar(50) NOT NULL DEFAULT 'public',
  `meta_title` varchar(2000) DEFAULT NULL,
  `meta_description` varchar(2000) DEFAULT NULL,
  `author_id` varchar(24) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  `published_at` datetime DEFAULT NULL,
  `published_by` varchar(24) DEFAULT NULL,
  `custom_excerpt` varchar(2000) DEFAULT NULL,
  `codeinjection_head` text,
  `codeinjection_foot` text,
  `og_image` varchar(2000) DEFAULT NULL,
  `og_title` varchar(300) DEFAULT NULL,
  `og_description` varchar(500) DEFAULT NULL,
  `twitter_image` varchar(2000) DEFAULT NULL,
  `twitter_title` varchar(300) DEFAULT NULL,
  `twitter_description` varchar(500) DEFAULT NULL,
  `custom_template` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `uuid`, `title`, `slug`, `mobiledoc`, `html`, `amp`, `plaintext`, `feature_image`, `featured`, `page`, `status`, `locale`, `visibility`, `meta_title`, `meta_description`, `author_id`, `created_at`, `created_by`, `updated_at`, `updated_by`, `published_at`, `published_by`, `custom_excerpt`, `codeinjection_head`, `codeinjection_foot`, `og_image`, `og_title`, `og_description`, `twitter_image`, `twitter_title`, `twitter_description`, `custom_template`) VALUES
('5b77988186ea860079567765', '4fc40cf4-8b89-4ebd-b6b9-deb9ee16a46d', 'Frequently Asked Questions', 'faq', '{\"version\":\"0.3.1\",\"atoms\":[[\"soft-return\",\"\",{}],[\"soft-return\",\"\",{}],[\"soft-return\",\"\",{}],[\"soft-return\",\"\",{}],[\"soft-return\",\"\",{}],[\"soft-return\",\"\",{}],[\"soft-return\",\"\",{}]],\"cards\":[[\"html\",{\"html\":\"<br />\"}],[\"html\",{\"html\":\"<br />\"}],[\"html\",{\"html\":\"<br />\"}],[\"html\",{\"html\":\"<br />\"}],[\"html\",{\"html\":\"<br />\"}],[\"html\",{\"html\":\"<br />\"}],[\"html\",{\"html\":\"<br />\"}],[\"html\",{\"html\":\"<br />\"}],[\"html\",{\"html\":\"<br />\"}],[\"html\",{\"html\":\"<br />\"}],[\"html\",{\"html\":\"<br />\"}],[\"html\",{\"html\":\"<br />\"}]],\"markups\":[[\"strong\"],[\"a\",[\"href\",\"https://openrsc.com/2018/08/09/open-rsc-statement-on-authentic-behaviour/\"]],[\"a\",[\"href\",\"https://github.com/open-rsc/docker-home#open-rsc-docker-home-\"]],[\"a\",[\"href\",\"https://github.com/open-rsc/docker-home#vps\"]],[\"em\"],[\"a\",[\"href\",\"https://github.com/Open-RSC/Docker-Home\"]]],\"sections\":[[1,\"p\",[[0,[0],1,\"How often is Open RSC updated?\"]]],[1,\"p\",[[0,[],0,\"The game is updated every Sunday evening during our scheduled change window. We test all code on our dev test world during the week so that it is verified not to be buggy by the time Sunday nights occur. If something truly game-breaking is found, it will be fixed immediately instead of waiting. This avoids the game server from needing to be restarted over and over to fix bugs, which would be disruptive to those actually trying to play the game.\"]]],[10,0],[1,\"p\",[[0,[0],1,\"Is this a replica? What is the experience rate? Some things aren\'t exactly like the original RSC.\"]]],[1,\"p\",[[0,[],0,\"The goal is to be as close to the original game as possible. We have a ways to go and are working hard to reach that goal. Experience rate is set at 1x (just like original RSC) and we do not want to change it on the main game world. Feel free to run your own version and configure which features you would like. We have had to make some executive decisions on which features are worth being kept kosher and which are quality of life improvements that need to be enabled in the main game world. \"]]],[1,\"p\",[[0,[],0,\"Read more here:\"],[1,[],0,0],[0,[1],1,\"https://openrsc.com/2018/08/09/open-rsc-statement-on-authentic-behaviour/\"]]],[10,1],[1,\"p\",[[0,[0],1,\"Is a single player version available?\"]]],[1,\"p\",[[0,[],0,\"Yes! Read through the page linked below and after running the setup script named \\\"Setup_Windows.cmd\\\", launch \\\"Run_Single_Player_Game_Windows.cmd\\\"\"],[1,[],0,1],[0,[2],1,\"https://github.com/open-rsc/docker-home#open-rsc-docker-home-\"]]],[10,2],[1,\"p\",[[0,[0],1,\"How do I run my own Open RSC private server?\"]]],[1,\"p\",[[0,[],0,\"Follow this guide:\"],[1,[],0,2],[0,[3],1,\"https://github.com/open-rsc/docker-home#vps\"]]],[10,3],[1,\"p\",[[0,[0],1,\"May I subscribe, donate, or buy anything? What about cosmetic items?\"]]],[1,\"p\",[[0,[],0,\"No! Open RSC is forever to be a free game. Modern day server hosting costs are akin to pocket change and we have real jobs. We don\'t want to sell you anything. This is our hobby and we don\'t need any money. Just come have fun!\"]]],[10,4],[1,\"p\",[[0,[0],1,\"Who are the Open RSC admins?\"]]],[1,\"p\",[[0,[],0,\"Marwolf and Kenix\"]]],[10,5],[1,\"p\",[[0,[0],1,\"How does the Open RSC government run the game?\"]]],[1,\"p\",[[0,[],0,\"We believe in non-interference. If real life illegal activity is found happening, then we will ban the person.\"],[1,[],0,3],[1,[],0,4],[0,[4],1,\"Swearing, advertising, botting, scamming, hacking, and bullying may be given temporary or permanent mutes if bad behavior persists.\"]]],[10,6],[1,\"p\",[[0,[0],1,\"What is Open RSC\'s stance on botting?\"]]],[1,\"p\",[[0,[],0,\"We don\'t approve but know it is futile to play cat and mouse. We may create another game called something like BotScape Classic where only the best bot scripts can defeat the other bots.\"]]],[10,7],[1,\"p\",[[0,[0],1,\"Does Open RSC need any mods?\"]]],[1,\"p\",[[0,[],0,\"Not at the moment. We generally want to leave the in-game players alone.\"]]],[10,8],[1,\"p\",[[0,[0],1,\"How can I help?\"]]],[1,\"p\",[[0,[],0,\"Join the Discord chat and come talk to us! We have many issues created in the GitHub repos.\"]]],[10,9],[1,\"p\",[[0,[0],1,\"How do I run my own copy?\"]]],[1,\"p\",[[0,[],0,\"Visit the \"],[0,[5],1,\"Open-RSC Docker-Home\"],[0,[],0,\" repository and follow the instructions. Open RSC is Windows, Mac, and Linux compatible!\"]]],[10,10],[1,\"p\",[[0,[0],1,\"From what period is Open RSC based on traditional RSC?\"]]],[1,\"p\",[[0,[],0,\"We believe the final version of traditional RSC is best to begin with but choose to disable some features added over time that we consider either annoying or pointless. \"],[1,[],0,5],[1,[],0,6],[0,[],0,\"For those that want to run their own version of Open RSC, disabled features can be enabled in the config. \"]]],[10,11],[1,\"p\",[[0,[0],1,\"What are you guy\'s future plans for development?\"]]],[1,\"p\",[[0,[],0,\"We want to maintain a traditional RSC server but also build a fun server with all sorts of never before seen features that you too can run on your own instance!\"]]]]}', '<p><strong>How often is Open RSC updated?</strong></p><p>The game is updated every Sunday evening during our scheduled change window. We test all code on our dev test world during the week so that it is verified not to be buggy by the time Sunday nights occur. If something truly game-breaking is found, it will be fixed immediately instead of waiting. This avoids the game server from needing to be restarted over and over to fix bugs, which would be disruptive to those actually trying to play the game.</p><br /><p><strong>Is this a replica? What is the experience rate? Some things aren\'t exactly like the original RSC.</strong></p><p>The goal is to be as close to the original game as possible. We have a ways to go and are working hard to reach that goal. Experience rate is set at 1x (just like original RSC) and we do not want to change it on the main game world. Feel free to run your own version and configure which features you would like. We have had to make some executive decisions on which features are worth being kept kosher and which are quality of life improvements that need to be enabled in the main game world. </p><p>Read more here:<br><a href=\"https://openrsc.com/2018/08/09/open-rsc-statement-on-authentic-behaviour/\">https://openrsc.com/2018/08/09/open-rsc-statement-on-authentic-behaviour/</a></p><br /><p><strong>Is a single player version available?</strong></p><p>Yes! Read through the page linked below and after running the setup script named \"Setup_Windows.cmd\", launch \"Run_Single_Player_Game_Windows.cmd\"<br><a href=\"https://github.com/open-rsc/docker-home#open-rsc-docker-home-\">https://github.com/open-rsc/docker-home#open-rsc-docker-home-</a></p><br /><p><strong>How do I run my own Open RSC private server?</strong></p><p>Follow this guide:<br><a href=\"https://github.com/open-rsc/docker-home#vps\">https://github.com/open-rsc/docker-home#vps</a></p><br /><p><strong>May I subscribe, donate, or buy anything? What about cosmetic items?</strong></p><p>No! Open RSC is forever to be a free game. Modern day server hosting costs are akin to pocket change and we have real jobs. We don\'t want to sell you anything. This is our hobby and we don\'t need any money. Just come have fun!</p><br /><p><strong>Who are the Open RSC admins?</strong></p><p>Marwolf and Kenix</p><br /><p><strong>How does the Open RSC government run the game?</strong></p><p>We believe in non-interference. If real life illegal activity is found happening, then we will ban the person.<br><br><em>Swearing, advertising, botting, scamming, hacking, and bullying may be given temporary or permanent mutes if bad behavior persists.</em></p><br /><p><strong>What is Open RSC\'s stance on botting?</strong></p><p>We don\'t approve but know it is futile to play cat and mouse. We may create another game called something like BotScape Classic where only the best bot scripts can defeat the other bots.</p><br /><p><strong>Does Open RSC need any mods?</strong></p><p>Not at the moment. We generally want to leave the in-game players alone.</p><br /><p><strong>How can I help?</strong></p><p>Join the Discord chat and come talk to us! We have many issues created in the GitHub repos.</p><br /><p><strong>How do I run my own copy?</strong></p><p>Visit the <a href=\"https://github.com/Open-RSC/Docker-Home\">Open-RSC Docker-Home</a> repository and follow the instructions. Open RSC is Windows, Mac, and Linux compatible!</p><br /><p><strong>From what period is Open RSC based on traditional RSC?</strong></p><p>We believe the final version of traditional RSC is best to begin with but choose to disable some features added over time that we consider either annoying or pointless. <br><br>For those that want to run their own version of Open RSC, disabled features can be enabled in the config. </p><br /><p><strong>What are you guy\'s future plans for development?</strong></p><p>We want to maintain a traditional RSC server but also build a fun server with all sorts of never before seen features that you too can run on your own instance!</p>', '5b6391758731fa0001fd57c9', 'How often is Open RSC updated?\n\nThe game is updated every Sunday evening during our scheduled change window. We\ntest all code on our dev test world during the week so that it is verified not\nto be buggy by the time Sunday nights occur. If something truly game-breaking is\nfound, it will be fixed immediately instead of waiting. This avoids the game\nserver from needing to be restarted over and over to fix bugs, which would be\ndisruptive to those actually trying to play the game.\n\n\nIs this a replica? What is the experience rate? Some things aren\'t exactly like\nthe original RSC.\n\nThe goal is to be as close to the original game as possible. We have a ways to\ngo and are working hard to reach that goal. Experience rate is set at 1x (just\nlike original RSC) and we do not want to change it on the main game world. Feel\nfree to run your own version and configure which features you would like. We\nhave had to make some executive decisions on which features are worth being kept\nkosher and which are quality of life improvements that need to be enabled in the\nmain game world. \n\nRead more here:\nhttps://openrsc.com/2018/08/09/open-rsc-statement-on-authentic-behaviour/\n\n\nIs a single player version available?\n\nYes! Read through the page linked below and after running the setup script named\n\"Setup_Windows.cmd\", launch \"Run_Single_Player_Game_Windows.cmd\"\nhttps://github.com/open-rsc/docker-home#open-rsc-docker-home-\n\n\nHow do I run my own Open RSC private server?\n\nFollow this guide:\nhttps://github.com/open-rsc/docker-home#vps\n\n\nMay I subscribe, donate, or buy anything? What about cosmetic items?\n\nNo! Open RSC is forever to be a free game. Modern day server hosting costs are\nakin to pocket change and we have real jobs. We don\'t want to sell you anything.\nThis is our hobby and we don\'t need any money. Just come have fun!\n\n\nWho are the Open RSC admins?\n\nMarwolf and Kenix\n\n\nHow does the Open RSC government run the game?\n\nWe believe in non-interference. If real life illegal activity is found\nhappening, then we will ban the person.\n\nSwearing, advertising, botting, scamming, hacking, and bullying may be given\ntemporary or permanent mutes if bad behavior persists.\n\n\nWhat is Open RSC\'s stance on botting?\n\nWe don\'t approve but know it is futile to play cat and mouse. We may create\nanother game called something like BotScape Classic where only the best bot\nscripts can defeat the other bots.\n\n\nDoes Open RSC need any mods?\n\nNot at the moment. We generally want to leave the in-game players alone.\n\n\nHow can I help?\n\nJoin the Discord chat and come talk to us! We have many issues created in the\nGitHub repos.\n\n\nHow do I run my own copy?\n\nVisit the Open-RSC Docker-Home [https://github.com/Open-RSC/Docker-Home] \nrepository and follow the instructions. Open RSC is Windows, Mac, and Linux\ncompatible!\n\n\nFrom what period is Open RSC based on traditional RSC?\n\nWe believe the final version of traditional RSC is best to begin with but choose\nto disable some features added over time that we consider either annoying or\npointless. \n\nFor those that want to run their own version of Open RSC, disabled features can\nbe enabled in the config. \n\n\nWhat are you guy\'s future plans for development?\n\nWe want to maintain a traditional RSC server but also build a fun server with\nall sorts of never before seen features that you too can run on your own\ninstance!', '/blog/content/images/2018/08/96Uk-sa-Y6g4hkPV7d2cLdxuXQAPW6lt3mRSExWm18A.jpg', 0, 1, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-02 23:19:17', '1', '2018-08-18 04:06:11', '1', '2018-08-02 23:23:29', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('5b77988186ea860079567766', 'a8c687b8-148e-4bfb-be7a-331104951767', 'Our Mission', 'our-mission', '{\"version\":\"0.3.1\",\"atoms\":[],\"cards\":[],\"markups\":[[\"a\",[\"href\",\"https://discord.gg/94vVKND\"]]],\"sections\":[[1,\"p\",[[0,[],0,\"Open RSC is a community-wide project using modern tools to build and run an antique game in light of RSC\'s August 2018 permanent closure.\"]]],[1,\"p\",[[0,[],0,\"Pioneered by a team of RSC veterans with security, openness, and non-profit in mind, Open RSC strives to build a Windows, Mac, and Linux compatible game that empowers both players and developers to pass on the torch and keep the abandoned RSC dream alive with fresh vigor.\"]]],[1,\"p\",[[0,[],0,\"Our replica RSC server will remain forever free to play, have minimal in-game governance (nothing illegal), and able to be hosted indefinitely thanks to modern day web hosting costs now being akin to pocket change. All of our code and projects are publicly available to contribute to and use. Customization is important and we want as many game features as possible able to be toggled on or off as desired as well as to provide a base for never before seen game servers, such as the idea of BotScape, where the player must write botting scripts to compete against other botting players or a survival game where player death is permanent.\"]]],[1,\"p\",[[0,[],0,\"We realize that to simply recreate the traditional game is not enough to drive continued interest. A evolution in RSC is the next step - to design another game world using toggle-able features in the existing game code. One code source, two distinct games, and many combinations of feature choices. Think speed PKing with level caps raised to 150 or 300, dragon items, new spells, skills, a global wilderness with save zones, pet monsters to capture, spawn, and have follow you around, ghost cloaks for stealth, team teleport portals, player owned houses, and much more!\"]]],[1,\"p\",[[0,[],0,\"Our project makes use of virtualization, automation, and open source to simplify the building of the game, website, database, and development projects so that anyone can run on their own instance, either publicly with friends or in a single player mode without being foisted upon with difficult PC environment configurations or programming knowledge. We want this to be as simple as possible.\"]]],[1,\"p\",[[0,[],0,\"Thanks to the contributions of the RSC Preservation Project, Open RSC is able to be a lot closer to the original game.\"]]],[1,\"p\",[[0,[],0,\"Come join our \"],[0,[0],1,\"Discord\"],[0,[],0,\" and find out how you can be a part of this!\"]]]]}', '<p>Open RSC is a community-wide project using modern tools to build and run an antique game in light of RSC\'s August 2018 permanent closure.</p><p>Pioneered by a team of RSC veterans with security, openness, and non-profit in mind, Open RSC strives to build a Windows, Mac, and Linux compatible game that empowers both players and developers to pass on the torch and keep the abandoned RSC dream alive with fresh vigor.</p><p>Our replica RSC server will remain forever free to play, have minimal in-game governance (nothing illegal), and able to be hosted indefinitely thanks to modern day web hosting costs now being akin to pocket change. All of our code and projects are publicly available to contribute to and use. Customization is important and we want as many game features as possible able to be toggled on or off as desired as well as to provide a base for never before seen game servers, such as the idea of BotScape, where the player must write botting scripts to compete against other botting players or a survival game where player death is permanent.</p><p>We realize that to simply recreate the traditional game is not enough to drive continued interest. A evolution in RSC is the next step - to design another game world using toggle-able features in the existing game code. One code source, two distinct games, and many combinations of feature choices. Think speed PKing with level caps raised to 150 or 300, dragon items, new spells, skills, a global wilderness with save zones, pet monsters to capture, spawn, and have follow you around, ghost cloaks for stealth, team teleport portals, player owned houses, and much more!</p><p>Our project makes use of virtualization, automation, and open source to simplify the building of the game, website, database, and development projects so that anyone can run on their own instance, either publicly with friends or in a single player mode without being foisted upon with difficult PC environment configurations or programming knowledge. We want this to be as simple as possible.</p><p>Thanks to the contributions of the RSC Preservation Project, Open RSC is able to be a lot closer to the original game.</p><p>Come join our <a href=\"https://discord.gg/94vVKND\">Discord</a> and find out how you can be a part of this!</p>', '5b639cba8731fa0001fd57cb', 'Open RSC is a community-wide project using modern tools to build and run an\nantique game in light of RSC\'s August 2018 permanent closure.\n\nPioneered by a team of RSC veterans with security, openness, and non-profit in\nmind, Open RSC strives to build a Windows, Mac, and Linux compatible game that\nempowers both players and developers to pass on the torch and keep the abandoned\nRSC dream alive with fresh vigor.\n\nOur replica RSC server will remain forever free to play, have minimal in-game\ngovernance (nothing illegal), and able to be hosted indefinitely thanks to\nmodern day web hosting costs now being akin to pocket change. All of our code\nand projects are publicly available to contribute to and use. Customization is\nimportant and we want as many game features as possible able to be toggled on or\noff as desired as well as to provide a base for never before seen game servers,\nsuch as the idea of BotScape, where the player must write botting scripts to\ncompete against other botting players or a survival game where player death is\npermanent.\n\nWe realize that to simply recreate the traditional game is not enough to drive\ncontinued interest. A evolution in RSC is the next step - to design another game\nworld using toggle-able features in the existing game code. One code source, two\ndistinct games, and many combinations of feature choices. Think speed PKing with\nlevel caps raised to 150 or 300, dragon items, new spells, skills, a global\nwilderness with save zones, pet monsters to capture, spawn, and have follow you\naround, ghost cloaks for stealth, team teleport portals, player owned houses,\nand much more!\n\nOur project makes use of virtualization, automation, and open source to simplify\nthe building of the game, website, database, and development projects so that\nanyone can run on their own instance, either publicly with friends or in a\nsingle player mode without being foisted upon with difficult PC environment\nconfigurations or programming knowledge. We want this to be as simple as\npossible.\n\nThanks to the contributions of the RSC Preservation Project, Open RSC is able to\nbe a lot closer to the original game.\n\nCome join our Discord [https://discord.gg/94vVKND]  and find out how you can be\na part of this!', '/blog/content/images/2018/08/68747470733a2f2f692e696d6775722e636f6d2f747a4c674577562e706e67-1.png', 0, 1, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-03 00:07:22', '1', '2018-08-04 23:25:55', '1', '2018-08-03 00:10:02', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('5b77988186ea860079567767', '18432742-9e47-4c24-be68-6c34a312aeb1', 'Automated build testing with Travis Ci', 'getting-ready-for-beta-testing', '{\"version\":\"0.3.1\",\"atoms\":[],\"cards\":[],\"markups\":[],\"sections\":[[1,\"p\",[[0,[],0,\"We now use Travis CI for automated build testing of the Docker-Home repository docker images as well as for the Game repository code compile testing for server and client for Oracle JDK and OpenJDK 8, 9, 10, and  11. Database SQL file imports are also tested for the Game repository. If something breaks in a commit or if a dependency stops functioning, this will help notify and track down as testing is done every 24 hours and after every repository commit.\"]]]]}', '<p>We now use Travis CI for automated build testing of the Docker-Home repository docker images as well as for the Game repository code compile testing for server and client for Oracle JDK and OpenJDK 8, 9, 10, and  11. Database SQL file imports are also tested for the Game repository. If something breaks in a commit or if a dependency stops functioning, this will help notify and track down as testing is done every 24 hours and after every repository commit.</p>', '5b63a81b8731fa0001fd57cd', 'We now use Travis CI for automated build testing of the Docker-Home repository\ndocker images as well as for the Game repository code compile testing for server\nand client for Oracle JDK and OpenJDK 8, 9, 10, and  11. Database SQL file\nimports are also tested for the Game repository. If something breaks in a commit\nor if a dependency stops functioning, this will help notify and track down as\ntesting is done every 24 hours and after every repository commit.', '/blog/content/images/2018/08/travis.png', 0, 0, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-03 00:55:55', '1', '2018-08-03 00:59:43', '1', '2018-08-03 00:56:17', '1', 'We now use Travis CI for automated build testing of the Docker-Home repository docker images as well as for the Game repository code compile testing for server and client for Oracle JDK and OpenJDK 8, 9, 10, and  11. Database SQL file imports are also tested for the Game repository.', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('5b77988186ea860079567768', 'f0cf24c8-3e5d-487a-b7ee-3a39a49c7cdd', 'Future Plans', 'future-plans', '{\"version\":\"0.3.1\",\"atoms\":[],\"cards\":[[\"html\",{\"html\":\"<img src=\\\"https://i.imgur.com/B1Z3etr.png\\\" style=\\\"width: 600px; height: 300px;\\\"/></a>\"}],[\"image\",{\"src\":\"/blog/content/images/2018/08/capes.png\",\"caption\":\"\"}],[\"html\",{\"html\":\"<center>\"}],[\"image\",{\"src\":\"/blog/content/images/2018/08/plcLv.png\",\"cardWidth\":\"\"}],[\"html\",{\"html\":\"</center>\"}],[\"image\",{\"src\":\"/blog/content/images/2018/08/OO6Urwx.png\"}],[\"html\",{\"html\":\"<img src=\\\"https://i.imgur.com/yHti8gT.png\\\" title=\\\"source: imgur.com\\\" style=\\\"width: 800px; height: 300px;\\\"/></a>\"}]],\"markups\":[],\"sections\":[[1,\"p\",[[0,[],0,\"The primary goal of Open RSC is to create a solid base that resembles the  traditional game so that anyone can easily modify the game to fit  whatever ideas they come up with.\"]]],[10,0],[1,\"p\",[[0,[],0,\"For a second iteration of the game world, we plan on:\"]]],[3,\"ul\",[[[0,[],0,\"Players point to point teleportation (game minimap clicks and right click \\\"teleport here\\\")\"]],[[0,[],0,\"Accessible bank window on-demand\"]],[[0,[],0,\"a  WoW-like combat experience rate that requires them to keep moving to  higher level NPCs to keep getting experience as their combat level  increases\"]],[[0,[],0,\"New spells such as cast a teleport pool (for entire parties to escape)  bands of attackers, an inhibit cast spell, an inhibit point to point  teleportation spell * PvP-enabled multi cannons\"]],[[0,[],0,\"Pet NPCs that follow their owner around, spawnable and capturable via item\"]],[[0,[],0,\"World-wide wilderness for +-40? combat levels and various safe zones\"]],[[0,[],0,\"Predefined player build selection screen for ranger, wizard, warrior, monk\"]],[[0,[],0,\"Max skill levels set to 150 instead of 99\"]],[[0,[],0,\"Dragon armour and weaponry\"]],[[0,[],0,\"@ran@ party hats\"]]]],[1,\"p\",[[0,[],0,\"Two game worlds can run with separate player databases, one being traditional and one being...more unique.\"]]],[10,1],[1,\"p\",[[0,[],0,\"I have played longer as an admin in a private server than I have as an  actual RSC and RS2 player. Some people want nostalgia and to be able to  AFK grind for levels and a traditional world is best for them but there  are certain things that for me make the game slow and insufferable as a  regular player. I want to explore the difficulty of speed PKing and have  a more casual experience be possible.\"]]],[10,2],[10,3],[10,4],[1,\"p\",[[0,[],0,\"We are not going to have different code bases to have all of this be  possible. Instead, we will simply allow the server operator to toggle  which features they want enabled in their config.xml file with a section  for non-traditional features.\"]]],[10,5],[1,\"p\",[[0,[],0,\"Have any other interesting ideas that could enhance the fun world that other servers have done / you always wanted to see?\"]]],[10,6]]}', '<p>The primary goal of Open RSC is to create a solid base that resembles the  traditional game so that anyone can easily modify the game to fit  whatever ideas they come up with.</p><img src=\"https://i.imgur.com/B1Z3etr.png\" style=\"width: 600px; height: 300px;\"/></a><p>For a second iteration of the game world, we plan on:</p><ul><li>Players point to point teleportation (game minimap clicks and right click \"teleport here\")</li><li>Accessible bank window on-demand</li><li>a  WoW-like combat experience rate that requires them to keep moving to  higher level NPCs to keep getting experience as their combat level  increases</li><li>New spells such as cast a teleport pool (for entire parties to escape)  bands of attackers, an inhibit cast spell, an inhibit point to point  teleportation spell * PvP-enabled multi cannons</li><li>Pet NPCs that follow their owner around, spawnable and capturable via item</li><li>World-wide wilderness for +-40? combat levels and various safe zones</li><li>Predefined player build selection screen for ranger, wizard, warrior, monk</li><li>Max skill levels set to 150 instead of 99</li><li>Dragon armour and weaponry</li><li>@ran@ party hats</li></ul><p>Two game worlds can run with separate player databases, one being traditional and one being...more unique.</p><figure class=\"kg-image-card\"><img src=\"/blog/content/images/2018/08/capes.png\" class=\"kg-image\"></figure><p>I have played longer as an admin in a private server than I have as an  actual RSC and RS2 player. Some people want nostalgia and to be able to  AFK grind for levels and a traditional world is best for them but there  are certain things that for me make the game slow and insufferable as a  regular player. I want to explore the difficulty of speed PKing and have  a more casual experience be possible.</p><center><figure class=\"kg-image-card\"><img src=\"/blog/content/images/2018/08/plcLv.png\" class=\"kg-image\"></figure></center><p>We are not going to have different code bases to have all of this be  possible. Instead, we will simply allow the server operator to toggle  which features they want enabled in their config.xml file with a section  for non-traditional features.</p><figure class=\"kg-image-card\"><img src=\"/blog/content/images/2018/08/OO6Urwx.png\" class=\"kg-image\"></figure><p>Have any other interesting ideas that could enhance the fun world that other servers have done / you always wanted to see?</p><img src=\"https://i.imgur.com/yHti8gT.png\" title=\"source: imgur.com\" style=\"width: 800px; height: 300px;\"/></a>', '5b63c08e8731fa0001fd57cf', 'The primary goal of Open RSC is to create a solid base that resembles the\n traditional game so that anyone can easily modify the game to fit  whatever\nideas they come up with.\n\nFor a second iteration of the game world, we plan on:\n\n * Players point to point teleportation (game minimap clicks and right click\n   \"teleport here\")\n * Accessible bank window on-demand\n * a  WoW-like combat experience rate that requires them to keep moving to\n    higher level NPCs to keep getting experience as their combat level\n    increases\n * New spells such as cast a teleport pool (for entire parties to escape)  bands\n   of attackers, an inhibit cast spell, an inhibit point to point  teleportation\n   spell * PvP-enabled multi cannons\n * Pet NPCs that follow their owner around, spawnable and capturable via item\n * World-wide wilderness for +-40? combat levels and various safe zones\n * Predefined player build selection screen for ranger, wizard, warrior, monk\n * Max skill levels set to 150 instead of 99\n * Dragon armour and weaponry\n * @ran@ party hats\n\nTwo game worlds can run with separate player databases, one being traditional\nand one being...more unique.\n\nI have played longer as an admin in a private server than I have as an  actual\nRSC and RS2 player. Some people want nostalgia and to be able to  AFK grind for\nlevels and a traditional world is best for them but there  are certain things\nthat for me make the game slow and insufferable as a  regular player. I want to\nexplore the difficulty of speed PKing and have  a more casual experience be\npossible.\n\nWe are not going to have different code bases to have all of this be  possible.\nInstead, we will simply allow the server operator to toggle  which features they\nwant enabled in their config.xml file with a section  for non-traditional\nfeatures.\n\nHave any other interesting ideas that could enhance the fun world that other\nservers have done / you always wanted to see?', '/blog/content/images/2018/08/dragons.png', 0, 1, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-03 02:40:14', '1', '2018-08-09 06:14:31', '1', '2018-08-03 14:42:24', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('5b77988186ea860079567769', 'cce00781-d235-4671-8eb5-96458a003dc8', 'Play Now', 'play-now', '{\"version\":\"0.3.1\",\"atoms\":[[\"soft-return\",\"\",{}],[\"soft-return\",\"\",{}],[\"soft-return\",\"\",{}]],\"cards\":[[\"hr\",{}]],\"markups\":[[\"strong\"],[\"a\",[\"href\",\"https://discordapp.com/invite/94vVKND\"]],[\"a\",[\"href\",\"http://openrsc.com:8080/downloads/Open_RSC_Launcher.jar\"]],[\"a\",[\"href\",\"http://www.oracle.com/technetwork/java/javase/downloads/jre10-downloads-4417026.html\"]]],\"sections\":[[1,\"p\",[[0,[0,1],2,\"-> Join the Discord chat 🔪\"],[1,[],0,0],[0,[0,2],2,\"--> Download the game launcher 🐺\"]]],[1,\"p\",[[0,[0],1,\"New player accounts are registered during first login. \"]]],[1,\"p\",[[0,[0],1,\"Remember to never re-use any of your RS credentials.\"]]],[1,\"p\",[]],[10,0],[1,\"p\",[]],[1,\"p\",[[0,[],0,\"Not able to open the game launcher? \"],[0,[3],1,\"Get the latest Java runtime environment here.\"],[1,[],0,1],[1,[],0,2],[0,[],0,\"If you are using OpenJDK on Linux, run this command first: \\\"\"],[0,[0],1,\"sudo apt install openjfx\"],[0,[],0,\"\\\"\"]]]]}', '<p><strong><a href=\"https://discordapp.com/invite/94vVKND\">-&gt; Join the Discord chat 🔪</a></strong><br><strong><a href=\"http://openrsc.com:8080/downloads/Open_RSC_Launcher.jar\">--&gt; Download the game launcher 🐺</a></strong></p><p><strong>New player accounts are registered during first login. </strong></p><p><strong>Remember to never re-use any of your RS credentials.</strong></p><p></p><hr><p></p><p>Not able to open the game launcher? <a href=\"http://www.oracle.com/technetwork/java/javase/downloads/jre10-downloads-4417026.html\">Get the latest Java runtime environment here.</a><br><br>If you are using OpenJDK on Linux, run this command first: \"<strong>sudo apt install openjfx</strong>\"</p>', '5b65116c40b7b10001185cb5', '-> Join the Discord chat 🔪 [https://discordapp.com/invite/94vVKND]\n--> Download the game launcher 🐺\n[http://openrsc.com:8080/downloads/Open_RSC_Launcher.jar]\n\nNew player accounts are registered during first login. \n\nRemember to never re-use any of your RS credentials.\n\n\n\n\n--------------------------------------------------------------------------------\n\n\n\nNot able to open the game launcher? Get the latest Java runtime environment\nhere.\n[http://www.oracle.com/technetwork/java/javase/downloads/jre10-downloads-4417026.html]\n\nIf you are using OpenJDK on Linux, run this command first: \"sudo apt install\nopenjfx\"', '/blog/content/images/2018/08/n00b.png', 0, 1, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-04 02:37:32', '1', '2018-08-05 17:18:57', '1', '2018-08-04 02:41:17', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('5b77988186ea86007956776a', '2ebeb873-45d2-44d3-924c-3dbebd2054b4', 'Major website update', 'major-website-update', '{\"version\":\"0.3.1\",\"atoms\":[],\"cards\":[],\"markups\":[],\"sections\":[[1,\"p\",[[0,[],0,\"The Open RSC website has been significantly updated. By switching away from antiquated PHP and a PHPBB forum, we recognize that users prefer to communicate over Discord, Reddit, and Twitter.\"]]],[1,\"p\",[]],[1,\"p\",[[0,[],0,\"This website serves as a jumping point for accessing everything and finding out the latest development news.\"]]]]}', '<p>The Open RSC website has been significantly updated. By switching away from antiquated PHP and a PHPBB forum, we recognize that users prefer to communicate over Discord, Reddit, and Twitter.</p><p></p><p>This website serves as a jumping point for accessing everything and finding out the latest development news.</p>', '5b6516e840b7b10001185cb9', 'The Open RSC website has been significantly updated. By switching away from\nantiquated PHP and a PHPBB forum, we recognize that users prefer to communicate\nover Discord, Reddit, and Twitter.\n\n\n\nThis website serves as a jumping point for accessing everything and finding out\nthe latest development news.', '/blog/content/images/2018/08/18274778_280580645735523_4488223525424635644_n.jpg', 0, 0, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-04 03:00:56', '1', '2018-08-04 03:04:23', '1', '2018-08-04 03:04:21', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('5b77988186ea86007956776b', 'e450aacb-a1e3-4941-b8f7-7e7e010ca77c', 'Open RSC to officially open tomorrow!', 'open-rsc-to-official-open-tomorrow', '{\"version\":\"0.3.1\",\"atoms\":[[\"soft-return\",\"\",{}],[\"soft-return\",\"\",{}],[\"soft-return\",\"\",{}]],\"cards\":[[\"image\",{\"src\":\"/content/images/2018/08/image-1-2.png\"}]],\"markups\":[[\"a\",[\"href\",\"https://OpenRSC.com/\"]],[\"a\",[\"href\",\"https://discord.gg/94vVKND\"]]],\"sections\":[[10,0],[1,\"p\",[[1,[],0,0],[1,[],0,1],[0,[],0,\"One candle may have finally flickered out but many torches have been ignited! RSC may now be officially closed but Open RSC will soon be officially open! We will be opening OpenRSC official server on August 5th, 2018 at 1200 EST.\"]]],[1,\"p\",[[0,[],0,\"As always, we continue to show commitment to our mission of openness, accuracy to the official game, and minimal in game governance.\"]]],[1,\"p\",[[0,[],0,\"We are continuing development and invite everyone who is interested to help us contribute! Finishing unimplemented quests and world definition differences are two of our next big pushes.\"]]],[1,\"p\",[[0,[],0,\"We are going to now disable the client download link and turn off the game server until 12:00pm EST tomorrow when the game officially opens so that we can get some last minute bugs fixed.\"]]],[1,\"p\",[[0,[],0,\"Don\'t \"],[0,[0],1,\"f\"],[0,[],0,\"orget to join us on Discord\"],[1,[],0,2],[0,[1],1,\"https://discord.gg/94vVKND\"]]]]}', '<figure class=\"kg-image-card\"><img src=\"/content/images/2018/08/image-1-2.png\" class=\"kg-image\"></figure><p><br><br>One candle may have finally flickered out but many torches have been ignited! RSC may now be officially closed but Open RSC will soon be officially open! We will be opening OpenRSC official server on August 5th, 2018 at 1200 EST.</p><p>As always, we continue to show commitment to our mission of openness, accuracy to the official game, and minimal in game governance.</p><p>We are continuing development and invite everyone who is interested to help us contribute! Finishing unimplemented quests and world definition differences are two of our next big pushes.</p><p>We are going to now disable the client download link and turn off the game server until 12:00pm EST tomorrow when the game officially opens so that we can get some last minute bugs fixed.</p><p>Don\'t <a href=\"https://OpenRSC.com/\">f</a>orget to join us on Discord<br><a href=\"https://discord.gg/94vVKND\">https://discord.gg/94vVKND</a></p>', '5b662b9ba827e5000126b939', 'One candle may have finally flickered out but many torches have been ignited!\nRSC may now be officially closed but Open RSC will soon be officially open! We\nwill be opening OpenRSC official server on August 5th, 2018 at 1200 EST.\n\nAs always, we continue to show commitment to our mission of openness, accuracy\nto the official game, and minimal in game governance.\n\nWe are continuing development and invite everyone who is interested to help us\ncontribute! Finishing unimplemented quests and world definition differences are\ntwo of our next big pushes.\n\nWe are going to now disable the client download link and turn off the game\nserver until 12:00pm EST tomorrow when the game officially opens so that we can\nget some last minute bugs fixed.\n\nDon\'t f [https://OpenRSC.com/]orget to join us on Discord\nhttps://discord.gg/94vVKND', NULL, 0, 0, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-04 22:41:31', '1', '2018-08-04 23:30:47', '1', '2018-08-04 22:48:12', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('5b77988186ea86007956776c', '67204ccd-d63f-43b0-97e1-cc01ae76e63f', 'Open RSC is now open!', 'open-rsc-is-now-open', NULL, '<p>Chickens have invaded Lumbridge! They plan to appear every hour, all day today. Download the game launcher and join the battle! I hear that one of them holds a prize.</p><p>Those darn chickens think they own the place. I don\'t know about you all, but I love eating deep fried chicken wings.</p><p><strong><a href=\"https://discordapp.com/invite/94vVKND\">-&gt; Join the Discord chat 🔪</a></strong><br><strong><a href=\"http://openrsc.com:8080/downloads/Open_RSC_Launcher.jar\">--&gt; Download the game launcher 🐺</a></strong></p><p><strong>New player accounts are registered during first login. </strong></p><p><strong>Remember to never re-use any of your RS credentials.</strong></p>', '5b670f66a827e5000126b93c', 'Chickens have invaded Lumbridge! They plan to appear every hour, all day today.\nDownload the game launcher and join the battle! I hear that one of them holds a\nprize.\n\nThose darn chickens think they own the place. I don\'t know about you all, but I\nlove eating deep fried chicken wings.\n\n-> Join the Discord chat 🔪 [https://discordapp.com/invite/94vVKND]\n--> Download the game launcher 🐺\n[http://openrsc.com:8080/downloads/Open_RSC_Launcher.jar]\n\nNew player accounts are registered during first login. \n\nRemember to never re-use any of your RS credentials.', '/blog/content/images/2018/08/homework.jpg', 0, 0, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-05 14:53:26', '1', '2018-08-05 17:19:11', '1', '2018-08-05 16:02:00', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('5b77988186ea86007956776d', '2607ead8-3fa8-4dce-a289-820c01887f3f', 'Planned upcoming features', 'planned-upcoming-features', '{\"version\":\"0.3.1\",\"atoms\":[],\"cards\":[],\"markups\":[],\"sections\":[[3,\"ul\",[[[0,[],0,\"A website designed from scratch using Sprintboot and Angular JS that is ran on Apache Tomcat\"]]]],[1,\"p\",[]],[3,\"ul\",[[[0,[],0,\"Player Highscores\"]]]],[1,\"p\",[]],[3,\"ul\",[[[0,[],0,\"A \\\"Fun\\\" game world that is not connected to the main traditional-style game world\"]]]],[1,\"p\",[]],[3,\"ul\",[[[0,[],0,\"Statistics pulled from the game database giving all players full transparency for Open RSC\"]]]],[1,\"p\",[]],[3,\"ul\",[[[0,[],0,\"Show the total sum of items in game, inventory/bank items, game chat records, full audit logs for admin commands\"]]]],[1,\"p\",[]],[3,\"ul\",[[[0,[],0,\"Show current number of players online, average in past 24h, 7d, 30d, 6mo, 1y\"]]]],[1,\"p\",[]],[3,\"ul\",[[[0,[],0,\"Show total number of registered players\"]]]],[1,\"p\",[]],[3,\"ul\",[[[0,[],0,\"Show total number of registered players with unique IP addresses\"]]]],[1,\"p\",[]],[3,\"ul\",[[[0,[],0,\"Offer a forked version of the RSC Preservation Wiki with Open RSC articles added\"]]]],[1,\"p\",[]],[3,\"ul\",[[[0,[],0,\"List enabled features per game world from the config.xml file\"]]]]]}', '<ul><li>A website designed from scratch using Sprintboot and Angular JS that is ran on Apache Tomcat</li></ul><p></p><ul><li>Player Highscores</li></ul><p></p><ul><li>A \"Fun\" game world that is not connected to the main traditional-style game world</li></ul><p></p><ul><li>Statistics pulled from the game database giving all players full transparency for Open RSC</li></ul><p></p><ul><li>Show the total sum of items in game, inventory/bank items, game chat records, full audit logs for admin commands</li></ul><p></p><ul><li>Show current number of players online, average in past 24h, 7d, 30d, 6mo, 1y</li></ul><p></p><ul><li>Show total number of registered players</li></ul><p></p><ul><li>Show total number of registered players with unique IP addresses</li></ul><p></p><ul><li>Offer a forked version of the RSC Preservation Wiki with Open RSC articles added</li></ul><p></p><ul><li>List enabled features per game world from the config.xml file</li></ul>', '5b699062a877c70001fc9db0', '* A website designed from scratch using Sprintboot and Angular JS that is ran\n   on Apache Tomcat\n\n\n\n * Player Highscores\n\n\n\n * A \"Fun\" game world that is not connected to the main traditional-style game\n   world\n\n\n\n * Statistics pulled from the game database giving all players full transparency\n   for Open RSC\n\n\n\n * Show the total sum of items in game, inventory/bank items, game chat records,\n   full audit logs for admin commands\n\n\n\n * Show current number of players online, average in past 24h, 7d, 30d, 6mo, 1y\n\n\n\n * Show total number of registered players\n\n\n\n * Show total number of registered players with unique IP addresses\n\n\n\n * Offer a forked version of the RSC Preservation Wiki with Open RSC articles\n   added\n\n\n\n * List enabled features per game world from the config.xml file', '/blog/content/images/2018/08/cat.jpg', 0, 0, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-07 12:28:18', '1', '2018-08-07 13:34:52', '1', '2018-08-07 12:36:33', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('5b77988186ea86007956776e', '5d8d05f8-2a4f-4dc6-92c1-038b045ebfb9', 'Development Test World', 'development-test-world', '{\"version\":\"0.3.1\",\"atoms\":[],\"cards\":[],\"markups\":[[\"strong\"],[\"a\",[\"href\",\"http://openrsc.com:8080/downloads/Open_RSC_Launcher.jar\"]]],\"sections\":[[1,\"p\",[[0,[],0,\"We are operating a second game world that is independent of the production game world. (Database is not linked)\"]]],[1,\"p\",[[0,[],0,\"The dev server runs the latest bleeding edge code for testing. Server restarts are frequent to implement the latest code pushes.\"]]],[1,\"p\",[[0,[],0,\"All players are automatically set as administrators. You can use a command to downgrade your role for testing purposes.\"]]],[1,\"p\",[[0,[],0,\"Please do not abuse the dev test server.\"]]],[1,\"p\",[[0,[0,1],2,\"--> Download the game launcher 🐺\"]]]]}', '<p>We are operating a second game world that is independent of the production game world. (Database is not linked)</p><p>The dev server runs the latest bleeding edge code for testing. Server restarts are frequent to implement the latest code pushes.</p><p>All players are automatically set as administrators. You can use a command to downgrade your role for testing purposes.</p><p>Please do not abuse the dev test server.</p><p><strong><a href=\"http://openrsc.com:8080/downloads/Open_RSC_Launcher.jar\">--&gt; Download the game launcher 🐺</a></strong></p>', '5b6af1f8a877c70001fc9dbb', 'We are operating a second game world that is independent of the production game\nworld. (Database is not linked)\n\nThe dev server runs the latest bleeding edge code for testing. Server restarts\nare frequent to implement the latest code pushes.\n\nAll players are automatically set as administrators. You can use a command to\ndowngrade your role for testing purposes.\n\nPlease do not abuse the dev test server.\n\n--> Download the game launcher 🐺\n[http://openrsc.com:8080/downloads/Open_RSC_Launcher.jar]', '/blog/content/images/2018/08/lol.png', 0, 0, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-08 13:36:56', '1', '2018-08-09 22:10:31', '1', '2018-08-08 13:40:58', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('5b77988186ea86007956776f', '422462d9-7145-4b7d-94e1-9c867f4558d9', 'Game launcher now offers main world and dev test world', 'game-launcher-update', '{\"version\":\"0.3.1\",\"atoms\":[[\"soft-return\",\"\",{}]],\"cards\":[],\"markups\":[[\"strong\"],[\"a\",[\"href\",\"http://openrsc.com:8080/downloads/Open_RSC_Launcher.jar\"]]],\"sections\":[[1,\"p\",[[0,[],0,\"The game launcher has been updated so that you can now access the main game world and the dev game world from the same app.\"]]],[1,\"p\",[[0,[],0,\"Get the latest version here:\"],[1,[],0,0],[0,[0,1],2,\"--> Download the game launcher 🐺\"]]],[1,\"p\",[]]]}', '<p>The game launcher has been updated so that you can now access the main game world and the dev game world from the same app.</p><p>Get the latest version here:<br><strong><a href=\"http://openrsc.com:8080/downloads/Open_RSC_Launcher.jar\">--&gt; Download the game launcher 🐺</a></strong></p>', '5b6bd57d8516e50001a444f2', 'The game launcher has been updated so that you can now access the main game\nworld and the dev game world from the same app.\n\nGet the latest version here:\n--> Download the game launcher 🐺\n[http://openrsc.com:8080/downloads/Open_RSC_Launcher.jar]', '/blog/content/images/2018/08/2-2.png', 0, 0, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-09 05:47:41', '1', '2018-08-09 14:18:47', '1', '2018-08-09 06:17:40', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('5b77988186ea860079567770', '2b2f50d9-eee9-402c-a849-745dce7fab06', 'Game Issue Prioritization Page', 'issue-prioritization-display-page', '{\"version\":\"0.3.1\",\"atoms\":[],\"cards\":[],\"markups\":[[\"a\",[\"href\",\"https://github.com/orgs/Open-RSC/projects/1\"]]],\"sections\":[[1,\"p\",[[0,[],0,\"We now have a publicly accessible page that shows the prioritization of issues that we are all working on. Check it out:\"]]],[1,\"p\",[[0,[0],1,\"https://github.com/orgs/Open-RSC/projects/1\"]]],[1,\"p\",[]]]}', '<p>We now have a publicly accessible page that shows the prioritization of issues that we are all working on. Check it out:</p><p><a href=\"https://github.com/orgs/Open-RSC/projects/1\">https://github.com/orgs/Open-RSC/projects/1</a></p>', '5b6c4ca88516e50001a444f5', 'We now have a publicly accessible page that shows the prioritization of issues\nthat we are all working on. Check it out:\n\nhttps://github.com/orgs/Open-RSC/projects/1', '/blog/content/images/2018/08/project-1.png', 0, 0, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-09 14:16:08', '1', '2018-08-09 14:19:51', '1', '2018-08-09 14:19:51', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `posts` (`id`, `uuid`, `title`, `slug`, `mobiledoc`, `html`, `amp`, `plaintext`, `feature_image`, `featured`, `page`, `status`, `locale`, `visibility`, `meta_title`, `meta_description`, `author_id`, `created_at`, `created_by`, `updated_at`, `updated_by`, `published_at`, `published_by`, `custom_excerpt`, `codeinjection_head`, `codeinjection_foot`, `og_image`, `og_title`, `og_description`, `twitter_image`, `twitter_title`, `twitter_description`, `custom_template`) VALUES
('5b77988186ea860079567771', 'e16810fc-b726-4e1b-9ea0-b9919980cd16', 'Open RSC Statement on \"Authentic\" Behaviour', 'open-rsc-statement-on-authentic-behaviour', '{\"version\":\"0.3.1\",\"atoms\":[[\"soft-return\",\"\",{}],[\"soft-return\",\"\",{}]],\"cards\":[[\"image\",{\"src\":\"/content/images/2018/08/runescape-classic-screenshot-3.jpg\"}]],\"markups\":[],\"sections\":[[10,0],[1,\"p\",[[0,[],0,\"We realize there\'s been a lot of debate in the RSC community recently on what an \\\"authentic\\\" replica actually means. We\'re going to first start by stating the obvious: A 100% accurate authentic replication is impossible. We don\'t have data for every game behaviour in order to do so. The RSC Preservation Project did a lot of great work, but it never could have fully documented the entire game.\"],[1,[],0,0],[1,[],0,1],[0,[],0,\"We must then start asking questions on where we will deviate. For example, how will we handle something like holiday drops? One presented solution is to drop them each year on the holiday. This diminishes the \\\"rare\\\" effect greatly, as the Gower brothers originally intended. This is a completely valid interpretation of \\\"authentic\\\" because it follows from the Gower brothers\' original design. On the other hand, a suggestion has been put forth to follow the actual Jagex time frame for drops. This will replicate the official game as it evolved over the years. This is also a perfectly valid interpretation of \\\"authentic.\\\"\"]]],[1,\"p\",[[0,[],0,\"For our purposes, we define \\\"authentic\\\" to mean the behaviour of the game around close. From there, we analyze features that were added over the years like fatigue to see if they make sense in a modern game. We have removed sleep words on fatigue because it is an antiquated anti bot feature that only caused problems for legitimate users. Further, we have decided that the occasional Quality of Life update can find it\'s way into the game, such as \\\"Drop All\\\" in inventory. We have also decided to add Bank Notes because 1) They were added shortly after RSC left active development in RS2 showing that this is how the Gower brothers\' would have handled it had they not moved to RS2, 2) Huge Quality of Life improvement to not have to talk to certers for hours.\"]]],[1,\"p\",[[0,[],0,\"Our plan is to eventually allow any and all additions like Notes, Drop All, etc to be configurable by settings.\"]]],[1,\"p\",[[0,[],0,\"We recognize that everyone has a different definition for what it means to be \\\"authentic.\\\" This is one of the reasons we keep our commitment to open source software. If you don\'t like a decision we made, we encourage you to open up your own copy of Open RSC and configure it as you desire.\"]]]]}', '<figure class=\"kg-image-card\"><img src=\"/content/images/2018/08/runescape-classic-screenshot-3.jpg\" class=\"kg-image\"></figure><p>We realize there\'s been a lot of debate in the RSC community recently on what an \"authentic\" replica actually means. We\'re going to first start by stating the obvious: A 100% accurate authentic replication is impossible. We don\'t have data for every game behaviour in order to do so. The RSC Preservation Project did a lot of great work, but it never could have fully documented the entire game.<br><br>We must then start asking questions on where we will deviate. For example, how will we handle something like holiday drops? One presented solution is to drop them each year on the holiday. This diminishes the \"rare\" effect greatly, as the Gower brothers originally intended. This is a completely valid interpretation of \"authentic\" because it follows from the Gower brothers\' original design. On the other hand, a suggestion has been put forth to follow the actual Jagex time frame for drops. This will replicate the official game as it evolved over the years. This is also a perfectly valid interpretation of \"authentic.\"</p><p>For our purposes, we define \"authentic\" to mean the behaviour of the game around close. From there, we analyze features that were added over the years like fatigue to see if they make sense in a modern game. We have removed sleep words on fatigue because it is an antiquated anti bot feature that only caused problems for legitimate users. Further, we have decided that the occasional Quality of Life update can find it\'s way into the game, such as \"Drop All\" in inventory. We have also decided to add Bank Notes because 1) They were added shortly after RSC left active development in RS2 showing that this is how the Gower brothers\' would have handled it had they not moved to RS2, 2) Huge Quality of Life improvement to not have to talk to certers for hours.</p><p>Our plan is to eventually allow any and all additions like Notes, Drop All, etc to be configurable by settings.</p><p>We recognize that everyone has a different definition for what it means to be \"authentic.\" This is one of the reasons we keep our commitment to open source software. If you don\'t like a decision we made, we encourage you to open up your own copy of Open RSC and configure it as you desire.</p>', '5b6c63ab8516e50001a444f9', 'We realize there\'s been a lot of debate in the RSC community recently on what an\n\"authentic\" replica actually means. We\'re going to first start by stating the\nobvious: A 100% accurate authentic replication is impossible. We don\'t have data\nfor every game behaviour in order to do so. The RSC Preservation Project did a\nlot of great work, but it never could have fully documented the entire game.\n\nWe must then start asking questions on where we will deviate. For example, how\nwill we handle something like holiday drops? One presented solution is to drop\nthem each year on the holiday. This diminishes the \"rare\" effect greatly, as the\nGower brothers originally intended. This is a completely valid interpretation of\n\"authentic\" because it follows from the Gower brothers\' original design. On the\nother hand, a suggestion has been put forth to follow the actual Jagex time\nframe for drops. This will replicate the official game as it evolved over the\nyears. This is also a perfectly valid interpretation of \"authentic.\"\n\nFor our purposes, we define \"authentic\" to mean the behaviour of the game around\nclose. From there, we analyze features that were added over the years like\nfatigue to see if they make sense in a modern game. We have removed sleep words\non fatigue because it is an antiquated anti bot feature that only caused\nproblems for legitimate users. Further, we have decided that the occasional\nQuality of Life update can find it\'s way into the game, such as \"Drop All\" in\ninventory. We have also decided to add Bank Notes because 1) They were added\nshortly after RSC left active development in RS2 showing that this is how the\nGower brothers\' would have handled it had they not moved to RS2, 2) Huge Quality\nof Life improvement to not have to talk to certers for hours.\n\nOur plan is to eventually allow any and all additions like Notes, Drop All, etc\nto be configurable by settings.\n\nWe recognize that everyone has a different definition for what it means to be\n\"authentic.\" This is one of the reasons we keep our commitment to open source\nsoftware. If you don\'t like a decision we made, we encourage you to open up your\nown copy of Open RSC and configure it as you desire.', NULL, 0, 0, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-09 15:54:19', '1', '2018-08-09 15:57:29', '1', '2018-08-09 15:57:29', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('5b77988186ea860079567772', '24643b0d-34f2-4ee9-879b-896678eeee25', 'Current World Map', 'current-world-map', '{\"version\":\"0.3.1\",\"atoms\":[],\"cards\":[],\"markups\":[[\"a\",[\"href\",\"https://openrsc.com/content/images/2018/08/map.png\"]]],\"sections\":[[1,\"p\",[[0,[],0,\"Link to the full size world map:\"]]],[1,\"p\",[[0,[0],1,\"https://openrsc.com/content/images/2018/08/map.png\"]]],[1,\"p\",[]]]}', '<p>Link to the full size world map:</p><p><a href=\"https://openrsc.com/content/images/2018/08/map.png\">https://openrsc.com/content/images/2018/08/map.png</a></p>', '5b6c9db38516e50001a444fb', 'Link to the full size world map:\n\nhttps://openrsc.com/content/images/2018/08/map.png', '/blog/content/images/2018/08/map.png', 0, 0, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-09 20:01:55', '1', '2018-08-09 20:03:59', '1', '2018-08-09 20:03:59', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('5b77988186ea860079567773', '88626a98-57a6-4523-839d-ae2ca154a1a9', 'Edgeville now matches the traditional version', 'edgeville-now-matches-the-traditional-rsc', '{\"version\":\"0.3.1\",\"atoms\":[],\"cards\":[],\"markups\":[[\"strong\"],[\"a\",[\"href\",\"https://github.com/Christofosho\"]]],\"sections\":[[1,\"p\",[[0,[],0,\"Special thanks to developer \"],[0,[0,1],1,\"christofosho\"],[0,[],1,\" \"],[0,[],0,\"for manually removing all of the non RSC-kosher things that were in Edgeville!\"]]],[1,\"p\",[[0,[],0,\"The changes are live in the development test server at present if you would like to check them out. The Sunday change window will be when they go live in the official game world.\"]]]]}', '<p>Special thanks to developer <strong><a href=\"https://github.com/Christofosho\">christofosho</a> </strong>for manually removing all of the non RSC-kosher things that were in Edgeville!</p><p>The changes are live in the development test server at present if you would like to check them out. The Sunday change window will be when they go live in the official game world.</p>', '5b6ce19e8516e50001a444fd', 'Special thanks to developer christofosho [https://github.com/Christofosho]  for\nmanually removing all of the non RSC-kosher things that were in Edgeville!\n\nThe changes are live in the development test server at present if you would like\nto check them out. The Sunday change window will be when they go live in the\nofficial game world.', '/blog/content/images/2018/08/Screen-Shot-2018-08-09-at-20.48.55.png', 0, 0, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-10 00:51:42', '1', '2018-08-10 00:55:20', '1', '2018-08-10 00:55:20', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('5b77988186ea860079567774', '8dc3b211-03a1-4e8e-8983-a4a3f6a95e58', 'Bug Report Submission Made Easy', 'bug-report-submission-made-easy', '{\"version\":\"0.3.1\",\"atoms\":[],\"cards\":[],\"markups\":[[\"a\",[\"href\",\"https://goo.gl/forms/nnhSln7S81l4I26t2\"]]],\"sections\":[[1,\"p\",[[0,[],0,\"We now have a Google Form that you can fill out with simple bug reports.\"]]],[1,\"p\",[[0,[0],1,\"https://goo.gl/forms/nnhSln7S81l4I26t2\"]]]]}', '<p>We now have a Google Form that you can fill out with simple bug reports.</p><p><a href=\"https://goo.gl/forms/nnhSln7S81l4I26t2\">https://goo.gl/forms/nnhSln7S81l4I26t2</a></p>', '5b6cfcea8516e50001a444ff', 'We now have a Google Form that you can fill out with simple bug reports.\n\nhttps://goo.gl/forms/nnhSln7S81l4I26t2', '/blog/content/images/2018/08/Screen-Shot-2018-08-09-at-22.41.24.png', 0, 0, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-10 02:48:10', '1', '2018-08-10 02:49:26', '1', '2018-08-10 02:49:26', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('5b77988186ea860079567775', '06b01956-3955-44bc-b650-c854c4bd1a57', 'Bug Reports', 'bug-reports', '{\"version\":\"0.3.1\",\"atoms\":[[\"soft-return\",\"\",{}],[\"soft-return\",\"\",{}]],\"cards\":[],\"markups\":[[\"a\",[\"href\",\"https://goo.gl/forms/nnhSln7S81l4I26t2\"]],[\"a\",[\"href\",\"https://github.com/open-rsc/game/issues/\"]]],\"sections\":[[1,\"p\",[[0,[],0,\"Please fill out this Google Form to submit bug reports:\"],[1,[],0,0],[0,[0],1,\"https://goo.gl/forms/nnhSln7S81l4I26t2\"]]],[1,\"p\",[[0,[],0,\"You can track the progression of your bug report here:\"],[1,[],0,1],[0,[1],1,\"https://github.com/open-rsc/game/issues/\"]]],[1,\"p\",[]]]}', '<p>Please fill out this Google Form to submit bug reports:<br><a href=\"https://goo.gl/forms/nnhSln7S81l4I26t2\">https://goo.gl/forms/nnhSln7S81l4I26t2</a></p><p>You can track the progression of your bug report here:<br><a href=\"https://github.com/open-rsc/game/issues/\">https://github.com/open-rsc/game/issues/</a></p>', '5b6cfdc88516e50001a44501', 'Please fill out this Google Form to submit bug reports:\nhttps://goo.gl/forms/nnhSln7S81l4I26t2\n\nYou can track the progression of your bug report here:\nhttps://github.com/open-rsc/game/issues/', '/blog/content/images/2018/08/Screen-Shot-2018-08-09-at-22.41.24-1.png', 0, 1, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-10 02:51:52', '1', '2018-08-10 02:57:18', '1', '2018-08-10 02:52:43', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('5b77988186ea860079567776', '2933d26c-3562-4d9f-91bc-302923b1eb11', 'East Falador now matches the traditional version', 'east-falador-now-matches-the-traditional-version', '{\"version\":\"0.3.1\",\"atoms\":[],\"cards\":[],\"markups\":[[\"strong\"],[\"a\",[\"href\",\"https://github.com/Christofosho\"]]],\"sections\":[[1,\"p\",[[0,[],0,\"Special thanks to developer \"],[0,[0,1],1,\"christofosho\"],[0,[],1,\" \"],[0,[],0,\"for manually removing all of the non RSC-kosher things that were in East Falador!\"]]],[1,\"p\",[[0,[],0,\"The changes are live in the development test server at present if you would like to check them out. The Sunday change window will be when they go live in the official game world.\"]]]]}', '<p>Special thanks to developer <strong><a href=\"https://github.com/Christofosho\">christofosho</a> </strong>for manually removing all of the non RSC-kosher things that were in East Falador!</p><p>The changes are live in the development test server at present if you would like to check them out. The Sunday change window will be when they go live in the official game world.</p>', '5b6d16e28516e50001a44503', 'Special thanks to developer christofosho [https://github.com/Christofosho]  for\nmanually removing all of the non RSC-kosher things that were in East Falador!\n\nThe changes are live in the development test server at present if you would like\nto check them out. The Sunday change window will be when they go live in the\nofficial game world.', '/blog/content/images/2018/08/Screen-Shot-2018-08-10-at-00.31.24.png', 0, 0, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-10 04:38:58', '1', '2018-08-10 04:39:31', '1', '2018-08-10 04:39:31', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('5b77988186ea860079567777', 'de342819-f0e3-47a3-8ef6-cb74b6f874c5', 'Game Update v1.0.1', 'first-week-success', '{\"version\":\"0.3.1\",\"atoms\":[],\"cards\":[],\"markups\":[[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/releases/tag/v1.0.1\"]],[\"strong\"],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/149\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/150\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/151\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/153\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/155\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/156\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/159\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/161\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/162\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/163\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/166\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/168\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/170\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/171\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/187\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/203\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/205\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/217\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/236\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/218\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/219\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/221\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/240\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/243\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/275\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/278\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/283\"]]],\"sections\":[[1,\"p\",[[0,[],0,\"Our first week has been wildly successful. We now have over 203 RSC veterans on our Discord server!\"]]],[1,\"p\",[[0,[],0,\"A big thank you to everyone who has been involved in testing, bug reporting, and submitting pull requests for fixes. The official server has been updated to the most current code and is ready to be logged in to!\"]]],[1,\"p\",[[0,[0],1,\"https://github.com/Open-RSC/Game/releases/tag/v1.0.1\"]]],[1,\"p\",[[0,[1],1,\"Issues Resolved:\"]]],[3,\"ul\",[[[0,[],0,\"Death on Tutorial Island causing -6 HP \"],[0,[2],1,\"#149\"]],[[0,[],0,\"Kill command not working \"],[0,[3],1,\"#150\"]],[[0,[],0,\"Able to pick up items more than 1 tile away \"],[0,[4],1,\"#151\"]],[[0,[],0,\"::stat command not working \"],[0,[5],1,\"#153\"]],[[0,[],0,\"Varrock mine iron rock becomes tin rock \"],[0,[6],1,\"#155\"]],[[0,[],0,\"Unable to smelt iron bars \"],[0,[7],1,\"#156\"]],[[0,[],0,\"\\\"You just advanced 1 mining levelnull” \"],[0,[8],1,\"#159\"]],[[0,[],0,\"Rats drop rat tails outside of quest \"],[0,[9],1,\"#161\"]],[[0,[],0,\"Unable to pick up stackable items when inventory is full \"],[0,[10],1,\"#162\"]],[[0,[],0,\"Smelt iron 100% of time instead of 50% \"],[0,[11],1,\"#163\"]],[[0,[],0,\"Pirate Treasure quest reward gives incorrect ring \"],[0,[12],1,\"#166\"]],[[0,[],0,\"Magic experience rate not correct \"],[0,[13],1,\"#168\"]],[[0,[],0,\"Right click player names yellow instead of white \"],[0,[14],1,\"#170\"]],[[0,[],0,\"Bears do not drop bear meat and missing bears \"],[0,[15],1,\"#171\"]],[[0,[],0,\"Zeke’s Scimitar Shop prices for steel and mithril are incorrect \"],[0,[16],1,\"#187\"]],[[0,[],0,\"No general store in Arhein \"],[0,[17],1,\"#203\"]],[[0,[],0,\"Muddy guam is able to be cleaned at level 1 \"],[0,[18],1,\"#205\"]],[[0,[],0,\"Edgeville has custom landscape, objects, npcs, and items \"],[0,[19],1,\"#217\"]],[[0,[],0,\"East Falador has custom landscape, objects, npc, and items \"],[0,[20],1,\"#236\"]],[[0,[],0,\"Firemaking burning logs gives incorrect experience \"],[0,[21],1,\"#218\"]],[[0,[],0,\"Cannot tell difference between official and dev server \"],[0,[22],1,\"#219\"]],[[0,[],0,\"Players get stuck on second floor of Morgan’s house \"],[0,[23],1,\"#221\"]],[[0,[],0,\"Master Crafter dialog is not correct \"],[0,[24],1,\"#240\"]],[[0,[],0,\"Nurmof does not sell rune pickaxes \"],[0,[25],1,\"#243\"]],[[0,[],0,\"Betty’s Magic Shop contains the wrong items \"],[0,[26],1,\"#275\"]],[[0,[],0,\"Able to use Cook’s Range before completing Cook’s Assistant quest \"],[0,[27],1,\"#278\"]],[[0,[],0,\"Edgeville has a prayer alter \"],[0,[28],1,\"#283\"]]]]]}', '<p>Our first week has been wildly successful. We now have over 203 RSC veterans on our Discord server!</p><p>A big thank you to everyone who has been involved in testing, bug reporting, and submitting pull requests for fixes. The official server has been updated to the most current code and is ready to be logged in to!</p><p><a href=\"https://github.com/Open-RSC/Game/releases/tag/v1.0.1\">https://github.com/Open-RSC/Game/releases/tag/v1.0.1</a></p><p><strong>Issues Resolved:</strong></p><ul><li>Death on Tutorial Island causing -6 HP <a href=\"https://github.com/Open-RSC/Game/issues/149\">#149</a></li><li>Kill command not working <a href=\"https://github.com/Open-RSC/Game/issues/150\">#150</a></li><li>Able to pick up items more than 1 tile away <a href=\"https://github.com/Open-RSC/Game/issues/151\">#151</a></li><li>::stat command not working <a href=\"https://github.com/Open-RSC/Game/issues/153\">#153</a></li><li>Varrock mine iron rock becomes tin rock <a href=\"https://github.com/Open-RSC/Game/issues/155\">#155</a></li><li>Unable to smelt iron bars <a href=\"https://github.com/Open-RSC/Game/issues/156\">#156</a></li><li>\"You just advanced 1 mining levelnull” <a href=\"https://github.com/Open-RSC/Game/issues/159\">#159</a></li><li>Rats drop rat tails outside of quest <a href=\"https://github.com/Open-RSC/Game/issues/161\">#161</a></li><li>Unable to pick up stackable items when inventory is full <a href=\"https://github.com/Open-RSC/Game/issues/162\">#162</a></li><li>Smelt iron 100% of time instead of 50% <a href=\"https://github.com/Open-RSC/Game/issues/163\">#163</a></li><li>Pirate Treasure quest reward gives incorrect ring <a href=\"https://github.com/Open-RSC/Game/issues/166\">#166</a></li><li>Magic experience rate not correct <a href=\"https://github.com/Open-RSC/Game/issues/168\">#168</a></li><li>Right click player names yellow instead of white <a href=\"https://github.com/Open-RSC/Game/issues/170\">#170</a></li><li>Bears do not drop bear meat and missing bears <a href=\"https://github.com/Open-RSC/Game/issues/171\">#171</a></li><li>Zeke’s Scimitar Shop prices for steel and mithril are incorrect <a href=\"https://github.com/Open-RSC/Game/issues/187\">#187</a></li><li>No general store in Arhein <a href=\"https://github.com/Open-RSC/Game/issues/203\">#203</a></li><li>Muddy guam is able to be cleaned at level 1 <a href=\"https://github.com/Open-RSC/Game/issues/205\">#205</a></li><li>Edgeville has custom landscape, objects, npcs, and items <a href=\"https://github.com/Open-RSC/Game/issues/217\">#217</a></li><li>East Falador has custom landscape, objects, npc, and items <a href=\"https://github.com/Open-RSC/Game/issues/236\">#236</a></li><li>Firemaking burning logs gives incorrect experience <a href=\"https://github.com/Open-RSC/Game/issues/218\">#218</a></li><li>Cannot tell difference between official and dev server <a href=\"https://github.com/Open-RSC/Game/issues/219\">#219</a></li><li>Players get stuck on second floor of Morgan’s house <a href=\"https://github.com/Open-RSC/Game/issues/221\">#221</a></li><li>Master Crafter dialog is not correct <a href=\"https://github.com/Open-RSC/Game/issues/240\">#240</a></li><li>Nurmof does not sell rune pickaxes <a href=\"https://github.com/Open-RSC/Game/issues/243\">#243</a></li><li>Betty’s Magic Shop contains the wrong items <a href=\"https://github.com/Open-RSC/Game/issues/275\">#275</a></li><li>Able to use Cook’s Range before completing Cook’s Assistant quest <a href=\"https://github.com/Open-RSC/Game/issues/278\">#278</a></li><li>Edgeville has a prayer alter <a href=\"https://github.com/Open-RSC/Game/issues/283\">#283</a></li></ul>', '5b6faf1c62df1b00018b0da2', 'Our first week has been wildly successful. We now have over 203 RSC veterans on\nour Discord server!\n\nA big thank you to everyone who has been involved in testing, bug reporting, and\nsubmitting pull requests for fixes. The official server has been updated to the\nmost current code and is ready to be logged in to!\n\nhttps://github.com/Open-RSC/Game/releases/tag/v1.0.1\n\nIssues Resolved:\n\n * Death on Tutorial Island causing -6 HP #149\n   [https://github.com/Open-RSC/Game/issues/149]\n * Kill command not working #150 [https://github.com/Open-RSC/Game/issues/150]\n * Able to pick up items more than 1 tile away #151\n   [https://github.com/Open-RSC/Game/issues/151]\n * ::stat command not working #153 [https://github.com/Open-RSC/Game/issues/153]\n * Varrock mine iron rock becomes tin rock #155\n   [https://github.com/Open-RSC/Game/issues/155]\n * Unable to smelt iron bars #156 [https://github.com/Open-RSC/Game/issues/156]\n * \"You just advanced 1 mining levelnull” #159\n   [https://github.com/Open-RSC/Game/issues/159]\n * Rats drop rat tails outside of quest #161\n   [https://github.com/Open-RSC/Game/issues/161]\n * Unable to pick up stackable items when inventory is full #162\n   [https://github.com/Open-RSC/Game/issues/162]\n * Smelt iron 100% of time instead of 50% #163\n   [https://github.com/Open-RSC/Game/issues/163]\n * Pirate Treasure quest reward gives incorrect ring #166\n   [https://github.com/Open-RSC/Game/issues/166]\n * Magic experience rate not correct #168\n   [https://github.com/Open-RSC/Game/issues/168]\n * Right click player names yellow instead of white #170\n   [https://github.com/Open-RSC/Game/issues/170]\n * Bears do not drop bear meat and missing bears #171\n   [https://github.com/Open-RSC/Game/issues/171]\n * Zeke’s Scimitar Shop prices for steel and mithril are incorrect #187\n   [https://github.com/Open-RSC/Game/issues/187]\n * No general store in Arhein #203 [https://github.com/Open-RSC/Game/issues/203]\n * Muddy guam is able to be cleaned at level 1 #205\n   [https://github.com/Open-RSC/Game/issues/205]\n * Edgeville has custom landscape, objects, npcs, and items #217\n   [https://github.com/Open-RSC/Game/issues/217]\n * East Falador has custom landscape, objects, npc, and items #236\n   [https://github.com/Open-RSC/Game/issues/236]\n * Firemaking burning logs gives incorrect experience #218\n   [https://github.com/Open-RSC/Game/issues/218]\n * Cannot tell difference between official and dev server #219\n   [https://github.com/Open-RSC/Game/issues/219]\n * Players get stuck on second floor of Morgan’s house #221\n   [https://github.com/Open-RSC/Game/issues/221]\n * Master Crafter dialog is not correct #240\n   [https://github.com/Open-RSC/Game/issues/240]\n * Nurmof does not sell rune pickaxes #243\n   [https://github.com/Open-RSC/Game/issues/243]\n * Betty’s Magic Shop contains the wrong items #275\n   [https://github.com/Open-RSC/Game/issues/275]\n * Able to use Cook’s Range before completing Cook’s Assistant quest #278\n   [https://github.com/Open-RSC/Game/issues/278]\n * Edgeville has a prayer alter #283\n   [https://github.com/Open-RSC/Game/issues/283]', '/blog/content/images/2018/08/Screen-Shot-2018-08-09-at-22.16.42.png', 0, 0, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-12 03:53:00', '1', '2018-08-16 19:46:58', '1', '2018-08-12 04:00:03', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('5b77988186ea860079567778', 'e8f4924f-fddb-482b-91b9-5ca7f7a1ee10', 'How-To Demonstration Videos For Single Player Open RSC', 'video-demonstrations-of-single-player-open-rsc', '{\"version\":\"0.3.1\",\"atoms\":[],\"cards\":[[\"html\",{\"html\":\"<center>\"}],[\"html\",{\"html\":\"<iframe width=\\\"560\\\" height=\\\"315\\\" src=\\\"https://www.youtube.com/embed/GKuRMiYO1pI?rel=0\\\" frameborder=\\\"0\\\" allow=\\\"autoplay; encrypted-media\\\" allowfullscreen></iframe>\"}],[\"html\",{\"html\":\"<iframe width=\\\"560\\\" height=\\\"315\\\" src=\\\"https://www.youtube.com/embed/idePY0rGvvE?rel=0\\\" frameborder=\\\"0\\\" allow=\\\"autoplay; encrypted-media\\\" allowfullscreen></iframe>\"}],[\"html\",{\"html\":\"<iframe width=\\\"560\\\" height=\\\"315\\\" src=\\\"https://www.youtube.com/embed/viSHtlC1hEc?rel=0\\\" frameborder=\\\"0\\\" allow=\\\"autoplay; encrypted-media\\\" allowfullscreen></iframe>\"}],[\"html\",{\"html\":\"</center>\"}]],\"markups\":[],\"sections\":[[10,0],[10,1],[10,2],[10,3],[10,4],[1,\"p\",[]]]}', '<center><iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/GKuRMiYO1pI?rel=0\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe><iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/idePY0rGvvE?rel=0\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe><iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/viSHtlC1hEc?rel=0\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe></center>', '5b70d98d62df1b00018b0da6', '', NULL, 0, 0, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-13 01:06:21', '1', '2018-08-13 12:11:28', '1', '2018-08-13 12:11:28', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('5b77988186ea860079567779', 'dc8eb56e-0f2e-4e46-b577-dab5cfb0743a', 'Game Update v1.0.2', 'update', '{\"version\":\"0.3.1\",\"atoms\":[],\"cards\":[],\"markups\":[[\"strong\"],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/244\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/249\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/255\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/270\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/279\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/283\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/289\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/301\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/306\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/317\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/330\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/333\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/334\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/339\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/340\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/342\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/347\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/349\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/360\"]],[\"a\",[\"href\",\"https://github.com/Open-RSC/Game/issues/287\"]]],\"sections\":[[1,\"p\",[[0,[0],1,\"Issues Resolved:\"]]],[3,\"ul\",[[[0,[],0,\"Mithril pickaxe only mines rocks 2 times instead of correct 6 attempts - \"],[0,[1],1,\"#244\"]],[[0,[],0,\"Incorrect level requirement for smithing iron short sword - \"],[0,[2],1,\"#249\"]],[[0,[],0,\"Iron smelting has a 100% success rate - \"],[0,[3],1,\"#255\"]],[[0,[],0,\"Inventory is full, item drops to ground message is not kosher - \"],[0,[4],1,\"#270\"]],[[0,[],0,\"Fletching items are created in stacks of 10 instead of 1 - \"],[0,[5],1,\"#279\"]],[[0,[],0,\"Edgeville dungeon has a prayer alter - \"],[0,[6],1,\"#283\"]],[[0,[],0,\"Unable to do herblaw, Druidic Ritual quest broken - \"],[0,[7],1,\"#289\"]],[[0,[],0,\"Unable to do correct Draynor manor lever puzzle - \"],[0,[8],1,\"#301\"]],[[0,[],0,\"Earth warriors missing in Edgeville dungeon - \"],[0,[9],1,\"#306\"]],[[0,[],0,\"Valaine’s Shop of Champions has incorrect prices - \"],[0,[10],1,\"#317\"]],[[0,[],0,\"Adamantite swords missing from Varrock Swords shop - \"],[0,[11],1,\"#330\"]],[[0,[],0,\"Wayne’s Chains in Flavor missing adamantine chain mail - \"],[0,[12],1,\"#333\"]],[[0,[],0,\"Edgeville shop sells PK gear - \"],[0,[13],1,\"#334\"]],[[0,[],0,\"Unable to access second floor of Taverly herblaw shop - \"],[0,[14],1,\"#339\"]],[[0,[],0,\"Cannot teleport while standing in wilderness - \"],[0,[15],1,\"#340\"]],[[0,[],0,\"Large number of rats spawning in Black Knight’s castle - \"],[0,[16],1,\"#342\"]],[[0,[],0,\"Custom Legend’s guild floors\"]],[[0,[],0,\"Shilo Village/Tai Bwo Wannai shop items incorrect\"]],[[0,[],0,\"Yanille missing a bartender - \"],[0,[17],1,\"#347\"]],[[0,[],0,\"Teleport to Lost City spell is not kosher - \"],[0,[18],1,\"#349\"]],[[0,[],0,\"Able to smith 5 bars into arrow heads at a time - \"],[0,[19],1,\"#360\"]],[[0,[],0,\"Batched skills now set in config to original 1 click, 1 attempt\"]],[[0,[],0,\"Added Shanty Pass bank - \"],[0,[20],1,\"#287\"]]]]]}', '<p><strong>Issues Resolved:</strong></p><ul><li>Mithril pickaxe only mines rocks 2 times instead of correct 6 attempts - <a href=\"https://github.com/Open-RSC/Game/issues/244\">#244</a></li><li>Incorrect level requirement for smithing iron short sword - <a href=\"https://github.com/Open-RSC/Game/issues/249\">#249</a></li><li>Iron smelting has a 100% success rate - <a href=\"https://github.com/Open-RSC/Game/issues/255\">#255</a></li><li>Inventory is full, item drops to ground message is not kosher - <a href=\"https://github.com/Open-RSC/Game/issues/270\">#270</a></li><li>Fletching items are created in stacks of 10 instead of 1 - <a href=\"https://github.com/Open-RSC/Game/issues/279\">#279</a></li><li>Edgeville dungeon has a prayer alter - <a href=\"https://github.com/Open-RSC/Game/issues/283\">#283</a></li><li>Unable to do herblaw, Druidic Ritual quest broken - <a href=\"https://github.com/Open-RSC/Game/issues/289\">#289</a></li><li>Unable to do correct Draynor manor lever puzzle - <a href=\"https://github.com/Open-RSC/Game/issues/301\">#301</a></li><li>Earth warriors missing in Edgeville dungeon - <a href=\"https://github.com/Open-RSC/Game/issues/306\">#306</a></li><li>Valaine’s Shop of Champions has incorrect prices - <a href=\"https://github.com/Open-RSC/Game/issues/317\">#317</a></li><li>Adamantite swords missing from Varrock Swords shop - <a href=\"https://github.com/Open-RSC/Game/issues/330\">#330</a></li><li>Wayne’s Chains in Flavor missing adamantine chain mail - <a href=\"https://github.com/Open-RSC/Game/issues/333\">#333</a></li><li>Edgeville shop sells PK gear - <a href=\"https://github.com/Open-RSC/Game/issues/334\">#334</a></li><li>Unable to access second floor of Taverly herblaw shop - <a href=\"https://github.com/Open-RSC/Game/issues/339\">#339</a></li><li>Cannot teleport while standing in wilderness - <a href=\"https://github.com/Open-RSC/Game/issues/340\">#340</a></li><li>Large number of rats spawning in Black Knight’s castle - <a href=\"https://github.com/Open-RSC/Game/issues/342\">#342</a></li><li>Custom Legend’s guild floors</li><li>Shilo Village/Tai Bwo Wannai shop items incorrect</li><li>Yanille missing a bartender - <a href=\"https://github.com/Open-RSC/Game/issues/347\">#347</a></li><li>Teleport to Lost City spell is not kosher - <a href=\"https://github.com/Open-RSC/Game/issues/349\">#349</a></li><li>Able to smith 5 bars into arrow heads at a time - <a href=\"https://github.com/Open-RSC/Game/issues/360\">#360</a></li><li>Batched skills now set in config to original 1 click, 1 attempt</li><li>Added Shanty Pass bank - <a href=\"https://github.com/Open-RSC/Game/issues/287\">#287</a></li></ul>', '5b75d3d462df1b00018b0daa', 'Issues Resolved:\n\n * Mithril pickaxe only mines rocks 2 times instead of correct 6 attempts - #244\n   [https://github.com/Open-RSC/Game/issues/244]\n * Incorrect level requirement for smithing iron short sword - #249\n   [https://github.com/Open-RSC/Game/issues/249]\n * Iron smelting has a 100% success rate - #255\n   [https://github.com/Open-RSC/Game/issues/255]\n * Inventory is full, item drops to ground message is not kosher - #270\n   [https://github.com/Open-RSC/Game/issues/270]\n * Fletching items are created in stacks of 10 instead of 1 - #279\n   [https://github.com/Open-RSC/Game/issues/279]\n * Edgeville dungeon has a prayer alter - #283\n   [https://github.com/Open-RSC/Game/issues/283]\n * Unable to do herblaw, Druidic Ritual quest broken - #289\n   [https://github.com/Open-RSC/Game/issues/289]\n * Unable to do correct Draynor manor lever puzzle - #301\n   [https://github.com/Open-RSC/Game/issues/301]\n * Earth warriors missing in Edgeville dungeon - #306\n   [https://github.com/Open-RSC/Game/issues/306]\n * Valaine’s Shop of Champions has incorrect prices - #317\n   [https://github.com/Open-RSC/Game/issues/317]\n * Adamantite swords missing from Varrock Swords shop - #330\n   [https://github.com/Open-RSC/Game/issues/330]\n * Wayne’s Chains in Flavor missing adamantine chain mail - #333\n   [https://github.com/Open-RSC/Game/issues/333]\n * Edgeville shop sells PK gear - #334\n   [https://github.com/Open-RSC/Game/issues/334]\n * Unable to access second floor of Taverly herblaw shop - #339\n   [https://github.com/Open-RSC/Game/issues/339]\n * Cannot teleport while standing in wilderness - #340\n   [https://github.com/Open-RSC/Game/issues/340]\n * Large number of rats spawning in Black Knight’s castle - #342\n   [https://github.com/Open-RSC/Game/issues/342]\n * Custom Legend’s guild floors\n * Shilo Village/Tai Bwo Wannai shop items incorrect\n * Yanille missing a bartender - #347\n   [https://github.com/Open-RSC/Game/issues/347]\n * Teleport to Lost City spell is not kosher - #349\n   [https://github.com/Open-RSC/Game/issues/349]\n * Able to smith 5 bars into arrow heads at a time - #360\n   [https://github.com/Open-RSC/Game/issues/360]\n * Batched skills now set in config to original 1 click, 1 attempt\n * Added Shanty Pass bank - #287 [https://github.com/Open-RSC/Game/issues/287]', '/blog/content/images/2018/08/Screen-Shot-2018-08-16-at-15.48.28.png', 0, 0, 'published', NULL, 'public', NULL, NULL, '1', '2018-08-16 19:43:16', '1', '2018-08-18 04:07:29', '1', '2018-08-16 20:19:39', '1', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `posts_authors`
--

DROP TABLE IF EXISTS `posts_authors`;
CREATE TABLE IF NOT EXISTS `posts_authors` (
  `id` varchar(24) NOT NULL,
  `post_id` varchar(24) NOT NULL,
  `author_id` varchar(24) NOT NULL,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `posts_authors_post_id_foreign` (`post_id`),
  KEY `posts_authors_author_id_foreign` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts_authors`
--

INSERT INTO `posts_authors` (`id`, `post_id`, `author_id`, `sort_order`) VALUES
('5b77988186ea86007956777a', '5b77988186ea860079567765', '1', 0),
('5b77988186ea86007956777b', '5b77988186ea860079567766', '1', 0),
('5b77988286ea86007956777c', '5b77988186ea860079567767', '1', 0),
('5b77988286ea86007956777d', '5b77988186ea860079567768', '1', 0),
('5b77988286ea86007956777e', '5b77988186ea860079567769', '1', 0),
('5b77988286ea86007956777f', '5b77988186ea86007956776a', '1', 0),
('5b77988286ea860079567780', '5b77988186ea86007956776b', '1', 0),
('5b77988286ea860079567781', '5b77988186ea86007956776c', '1', 0),
('5b77988286ea860079567782', '5b77988186ea86007956776d', '1', 0),
('5b77988286ea860079567783', '5b77988186ea86007956776e', '1', 0),
('5b77988286ea860079567784', '5b77988186ea86007956776f', '1', 0),
('5b77988286ea860079567785', '5b77988186ea860079567770', '1', 0),
('5b77988286ea860079567786', '5b77988186ea860079567771', '1', 0),
('5b77988286ea860079567787', '5b77988186ea860079567772', '1', 0),
('5b77988286ea860079567788', '5b77988186ea860079567773', '1', 0),
('5b77988286ea860079567789', '5b77988186ea860079567774', '1', 0),
('5b77988286ea86007956778a', '5b77988186ea860079567775', '1', 0),
('5b77988286ea86007956778b', '5b77988186ea860079567776', '1', 0),
('5b77988286ea86007956778c', '5b77988186ea860079567777', '1', 0),
('5b77988286ea86007956778d', '5b77988186ea860079567778', '1', 0),
('5b77988286ea86007956778e', '5b77988186ea860079567779', '1', 0);

-- --------------------------------------------------------

--
-- Table structure for table `posts_tags`
--

DROP TABLE IF EXISTS `posts_tags`;
CREATE TABLE IF NOT EXISTS `posts_tags` (
  `id` varchar(24) NOT NULL,
  `post_id` varchar(24) NOT NULL,
  `tag_id` varchar(24) NOT NULL,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `posts_tags_post_id_foreign` (`post_id`),
  KEY `posts_tags_tag_id_foreign` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `refreshtokens`
--

DROP TABLE IF EXISTS `refreshtokens`;
CREATE TABLE IF NOT EXISTS `refreshtokens` (
  `id` varchar(24) NOT NULL,
  `token` varchar(191) NOT NULL,
  `user_id` varchar(24) NOT NULL,
  `client_id` varchar(24) NOT NULL,
  `expires` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `refreshtokens_token_unique` (`token`),
  KEY `refreshtokens_user_id_foreign` (`user_id`),
  KEY `refreshtokens_client_id_foreign` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `refreshtokens`
--

INSERT INTO `refreshtokens` (`id`, `token`, `user_id`, `client_id`, `expires`) VALUES
('5b77987386ea860079567759', 'xcwMQgRqNfepleMUQJGBxZZApx3qE4yJYfO60WOdJaI7ds0eSrOguCxksrxYGkAMat3ryWoQF0onhbC5JfHtHBG7a4NTy1ynbK5SqwLdn2Ao5FRiX1LNECG8NfeFCtg6uS4kzc1jEfBSelfnx1TZRkftJb0PbMsY7Zs18mQNwOMdAHvFGeC8WJLLTDClbIl', '1', '5b77982bc10214003b07bf24', 1550332467659);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` varchar(24) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
('5b77982bc10214003b07bf28', 'Administrator', 'Administrators', '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf29', 'Editor', 'Editors', '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf2a', 'Author', 'Authors', '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf2b', 'Contributor', 'Contributors', '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1'),
('5b77982bc10214003b07bf2c', 'Owner', 'Blog Owner', '2018-08-18 03:53:15', '1', '2018-08-18 03:53:15', '1');

-- --------------------------------------------------------

--
-- Table structure for table `roles_users`
--

DROP TABLE IF EXISTS `roles_users`;
CREATE TABLE IF NOT EXISTS `roles_users` (
  `id` varchar(24) NOT NULL,
  `role_id` varchar(24) NOT NULL,
  `user_id` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `roles_users`
--

INSERT INTO `roles_users` (`id`, `role_id`, `user_id`) VALUES
('5b77982bc10214003b07bf62', '5b77982bc10214003b07bf2a', '5951f5fca366002ebd5dbef7'),
('5b77982cc10214003b07bff4', '5b77982bc10214003b07bf2c', '1'),
('5b77988186ea86007956775d', '5b77982bc10214003b07bf28', '1'),
('5b77988186ea86007956775e', '5b77982bc10214003b07bf28', '1');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
CREATE TABLE IF NOT EXISTS `settings` (
  `id` varchar(24) NOT NULL,
  `key` varchar(50) NOT NULL,
  `value` text,
  `type` varchar(50) NOT NULL DEFAULT 'core',
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`, `type`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
('5b77985f86ea86007956773e', 'db_hash', '514731cf-27bf-4c41-a614-32c1d75d7c16', 'core', '2018-08-18 03:54:07', '1', '2018-08-18 03:54:07', '1'),
('5b77985f86ea86007956773f', 'next_update_check', '1534650850', 'core', '2018-08-18 03:54:07', '1', '2018-08-18 03:54:10', '1'),
('5b77985f86ea860079567740', 'notifications', '[]', 'core', '2018-08-18 03:54:07', '1', '2018-08-18 03:54:07', '1'),
('5b77985f86ea860079567741', 'title', 'Open RSC', 'blog', '2018-08-02 22:25:37', '1', '2018-08-02 22:49:51', '1'),
('5b77985f86ea860079567742', 'description', 'Striving for a replica RSC game and more', 'blog', '2018-08-02 22:25:37', '1', '2018-08-03 01:47:55', '1'),
('5b77985f86ea860079567743', 'logo', '/blog/content/images/2018/08/68747470733a2f2f692e696d6775722e636f6d2f747a4c674577562e706e67-1-1.png', 'blog', '2018-08-02 22:25:37', '1', '2018-08-18 04:20:50', '1'),
('5b77985f86ea860079567744', 'cover_image', '/blog/content/images/2018/08/wod-1.png', 'blog', '2018-08-02 22:25:37', '1', '2018-08-18 04:20:50', '1'),
('5b77985f86ea860079567745', 'icon', '/blog/content/images/2018/08/41124845-1-1.png', 'blog', '2018-08-02 22:25:37', '1', '2018-08-18 04:21:11', '1'),
('5b77985f86ea860079567746', 'default_locale', 'en', 'blog', '2018-08-02 22:25:37', '1', '2018-08-02 22:25:37', '1'),
('5b77985f86ea860079567747', 'active_timezone', 'America/New_York', 'blog', '2018-08-02 22:25:37', '1', '2018-08-02 22:46:20', '1'),
('5b77985f86ea860079567748', 'force_i18n', 'true', 'blog', '2018-08-02 22:25:37', '1', '2018-08-02 22:25:37', '1'),
('5b77985f86ea860079567749', 'permalinks', '/:year/:month/:day/:slug/', 'blog', '2018-08-02 22:25:37', '1', '2018-08-02 22:46:39', '1'),
('5b77985f86ea86007956774a', 'amp', 'false', 'blog', '2018-08-02 22:25:37', '1', '2018-08-18 03:59:22', '1'),
('5b77985f86ea86007956774b', 'ghost_head', '<script>\nvar disqus_shortname = \'hiddenwolf-net\';\n</script>', 'blog', '2018-08-02 22:25:37', '1', '2018-08-06 13:04:42', '1'),
('5b77985f86ea86007956774c', 'ghost_foot', '<!--<script type=\"text/javascript\" src=\"https://code.jquery.com/jquery-1.11.3.min.js\"></script>-->', 'blog', '2018-08-02 22:25:37', '1', '2018-08-18 04:31:49', '1'),
('5b77985f86ea86007956774d', 'facebook', '', 'blog', '2018-08-02 22:25:37', '1', '2018-08-02 22:25:37', '1'),
('5b77985f86ea86007956774e', 'twitter', '@openrsc', 'blog', '2018-08-02 22:25:37', '1', '2018-08-02 22:46:39', '1'),
('5b77985f86ea86007956774f', 'labs', '{\"publicAPI\":false,\"koenigEditor\":true,\"subscribers\":false}', 'blog', '2018-08-02 22:25:37', '1', '2018-08-18 04:32:48', '1'),
('5b77985f86ea860079567750', 'navigation', '[{\"label\":\"Home\",\"url\":\"http://localhost/blog\"},{\"label\":\"Play Now\",\"url\":\"http://localhost/blog/play-now/\"},{\"label\":\"Bug Reports\",\"url\":\"http://localhost/blog/bug-reports/\"},{\"label\":\"FAQ\",\"url\":\"http://localhost/blog/faq/\"},{\"label\":\"Our Mission\",\"url\":\"http://localhost/blog/our-mission/\"},{\"label\":\"Future Plans\",\"url\":\"http://localhost/blog/future-plans/\"}]', 'blog', '2018-08-02 22:25:37', '1', '2018-08-18 03:56:12', '1'),
('5b77985f86ea860079567751', 'slack', '[]', 'blog', '2018-08-02 22:25:37', '1', '2018-08-18 03:55:41', '1'),
('5b77985f86ea860079567752', 'unsplash', '{\"isActive\":false}', 'blog', '2018-08-02 22:25:37', '1', '2018-08-04 15:04:26', '1'),
('5b77985f86ea860079567753', 'active_theme', 'newcasper', 'theme', '2018-08-18 03:54:07', '1', '2018-08-18 04:32:14', '1'),
('5b77985f86ea860079567754', 'active_apps', '[]', 'app', '2018-08-02 22:25:37', '1', '2018-08-02 22:25:37', '1'),
('5b77985f86ea860079567755', 'installed_apps', '[]', 'app', '2018-08-02 22:25:37', '1', '2018-08-02 22:25:37', '1'),
('5b77985f86ea860079567756', 'is_private', 'false', 'private', '2018-08-02 22:25:37', '1', '2018-08-02 22:25:37', '1'),
('5b77985f86ea860079567757', 'password', '', 'private', '2018-08-02 22:25:37', '1', '2018-08-02 22:25:37', '1'),
('5b77985f86ea860079567758', 'public_hash', 'c2060bdf3dc3512f68aa29407cf2c7', 'private', '2018-08-02 22:25:37', '1', '2018-08-02 22:25:37', '1');

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

DROP TABLE IF EXISTS `subscribers`;
CREATE TABLE IF NOT EXISTS `subscribers` (
  `id` varchar(24) NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `email` varchar(191) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'pending',
  `post_id` varchar(24) DEFAULT NULL,
  `subscribed_url` varchar(2000) DEFAULT NULL,
  `subscribed_referrer` varchar(2000) DEFAULT NULL,
  `unsubscribed_url` varchar(2000) DEFAULT NULL,
  `unsubscribed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscribers_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
CREATE TABLE IF NOT EXISTS `tags` (
  `id` varchar(24) NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `description` text,
  `feature_image` varchar(2000) DEFAULT NULL,
  `parent_id` varchar(191) DEFAULT NULL,
  `visibility` varchar(50) NOT NULL DEFAULT 'public',
  `meta_title` varchar(2000) DEFAULT NULL,
  `meta_description` varchar(2000) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tags_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` varchar(24) NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `ghost_auth_access_token` varchar(32) DEFAULT NULL,
  `ghost_auth_id` varchar(24) DEFAULT NULL,
  `password` varchar(60) NOT NULL,
  `email` varchar(191) NOT NULL,
  `profile_image` varchar(2000) DEFAULT NULL,
  `cover_image` varchar(2000) DEFAULT NULL,
  `bio` text,
  `website` varchar(2000) DEFAULT NULL,
  `location` text,
  `facebook` varchar(2000) DEFAULT NULL,
  `twitter` varchar(2000) DEFAULT NULL,
  `accessibility` text,
  `status` varchar(50) NOT NULL DEFAULT 'active',
  `locale` varchar(6) DEFAULT NULL,
  `visibility` varchar(50) NOT NULL DEFAULT 'public',
  `meta_title` varchar(2000) DEFAULT NULL,
  `meta_description` varchar(2000) DEFAULT NULL,
  `tour` text,
  `last_seen` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_slug_unique` (`slug`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `slug`, `ghost_auth_access_token`, `ghost_auth_id`, `password`, `email`, `profile_image`, `cover_image`, `bio`, `website`, `location`, `facebook`, `twitter`, `accessibility`, `status`, `locale`, `visibility`, `meta_title`, `meta_description`, `tour`, `last_seen`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
('1', 'Admin', 'admin-user', NULL, NULL, '$2a$10$Key907b5qM5giBRH5mcGIOaeWzCblcdDSBTmgiWfc1lIdhn5gDDTe', 'admin@openrsc.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"nightShift\":true}', 'active', NULL, 'public', NULL, NULL, '[\"getting-started\",\"using-the-editor\",\"static-post\",\"featured-post\",\"upload-a-theme\"]', '2018-08-18 03:54:27', '2018-08-18 03:53:15', '1', '2018-08-18 03:55:48', '1');

-- --------------------------------------------------------

--
-- Table structure for table `webhooks`
--

DROP TABLE IF EXISTS `webhooks`;
CREATE TABLE IF NOT EXISTS `webhooks` (
  `id` varchar(24) NOT NULL,
  `event` varchar(50) NOT NULL,
  `target_url` varchar(2000) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accesstokens`
--
ALTER TABLE `accesstokens`
  ADD CONSTRAINT `accesstokens_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `accesstokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `app_fields`
--
ALTER TABLE `app_fields`
  ADD CONSTRAINT `app_fields_app_id_foreign` FOREIGN KEY (`app_id`) REFERENCES `apps` (`id`);

--
-- Constraints for table `app_settings`
--
ALTER TABLE `app_settings`
  ADD CONSTRAINT `app_settings_app_id_foreign` FOREIGN KEY (`app_id`) REFERENCES `apps` (`id`);

--
-- Constraints for table `client_trusted_domains`
--
ALTER TABLE `client_trusted_domains`
  ADD CONSTRAINT `client_trusted_domains_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`);

--
-- Constraints for table `posts_authors`
--
ALTER TABLE `posts_authors`
  ADD CONSTRAINT `posts_authors_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `posts_authors_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`);

--
-- Constraints for table `posts_tags`
--
ALTER TABLE `posts_tags`
  ADD CONSTRAINT `posts_tags_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  ADD CONSTRAINT `posts_tags_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`);

--
-- Constraints for table `refreshtokens`
--
ALTER TABLE `refreshtokens`
  ADD CONSTRAINT `refreshtokens_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `refreshtokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
