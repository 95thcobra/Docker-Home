-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Aug 24, 2018 at 12:29 PM
-- Server version: 10.1.35-MariaDB
-- PHP Version: 7.2.8

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
CREATE DATABASE IF NOT EXISTS `ghost` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
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
('5b7ff8eee9ede900013f66de', 'vRlkbKfN57PabkvlIXpIWiPKeQpROs4oO5QokXhkWTw3suyNgIG95rStVAMdlvZu5xOtDH2wMnNqCAJQzhsJvEv8idXHQqOiRoAmVScKGsjPGvhOL2QekRWIjhJnqJ6CHEFbTkRRHOzTfUswWJzMb35wX61K3rN2ySqvEfLykC9mi7Fjr1RQD5PlOkDChwI', '1', '5b7f69148369200001905025', '5b7ff8eee9ede900013f66dd', 1537741454356);

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
('G0arx5JsbDot5HTW16WpUNZUdDhjdivWBGKM/k4ruAM=', 1535113454211, 1535113454211, 1535117054220, 1);

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
('5b7f69148369200001905025', '34b561f2-9247-4315-9604-6526d04e7698', 'Ghost Admin', 'ghost-admin', '58fcd1747c72', NULL, NULL, NULL, NULL, 'enabled', 'ua', NULL, '2018-08-24 02:10:28', '1', '2018-08-24 02:10:28', '1'),
('5b7f69148369200001905026', 'e8da3417-aebb-4dac-b2d0-6b468dcba66a', 'Ghost Frontend', 'ghost-frontend', 'a099cb8d5f63', NULL, NULL, NULL, NULL, 'enabled', 'ua', NULL, '2018-08-24 02:10:28', '1', '2018-08-24 02:10:28', '1'),
('5b7f69148369200001905027', 'a71f7ef1-e54f-43e4-897f-de54de01812a', 'Ghost Scheduler', 'ghost-scheduler', 'fe096d56c07e', NULL, NULL, NULL, NULL, 'enabled', 'web', NULL, '2018-08-24 02:10:28', '1', '2018-08-24 02:10:28', '1'),
('5b7f69148369200001905028', 'be3dd5a5-d49e-4a0c-adc4-4982e92779bf', 'Ghost Backup', 'ghost-backup', '197d76166c88', NULL, NULL, NULL, NULL, 'enabled', 'web', NULL, '2018-08-24 02:10:28', '1', '2018-08-24 02:10:28', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `name`, `version`, `currentVersion`) VALUES
(1, '1-create-tables.js', 'init', '2.0'),
(2, '2-create-fixtures.js', 'init', '2.0'),
(3, '1-post-excerpt.js', '1.3', '2.0'),
(4, '1-codeinjection-post.js', '1.4', '2.0'),
(5, '1-og-twitter-post.js', '1.5', '2.0'),
(6, '1-add-backup-client.js', '1.7', '2.0'),
(7, '1-add-permissions-redirect.js', '1.9', '2.0'),
(8, '1-custom-template-post.js', '1.13', '2.0'),
(9, '2-theme-permissions.js', '1.13', '2.0'),
(10, '1-add-webhooks-table.js', '1.18', '2.0'),
(11, '1-webhook-permissions.js', '1.19', '2.0'),
(12, '1-remove-settings-keys.js', '1.20', '2.0'),
(13, '1-add-contributor-role.js', '1.21', '2.0'),
(14, '1-multiple-authors-DDL.js', '1.22', '2.0'),
(15, '1-multiple-authors-DML.js', '1.22', '2.0'),
(16, '1-update-koenig-beta-html.js', '1.25', '2.0'),
(17, '2-demo-post.js', '1.25', '2.0'),
(18, '1-rename-amp-column.js', '2.0', '2.0'),
(19, '2-update-posts.js', '2.0', '2.0'),
(20, '3-remove-koenig-labs.js', '2.0', '2.0'),
(21, '4-permalink-setting.js', '2.0', '2.0'),
(22, '5-remove-demo-post.js', '2.0', '2.0'),
(23, '6-replace-fixture-posts.js', '2.0', '2.0');

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
('km01', 0, '2018-08-24 12:22:26', '2018-08-24 12:22:29');

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
('5b7ff88482102400017f319e', 'Export database', 'db', 'exportContent', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f319f', 'Import database', 'db', 'importContent', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31a0', 'Delete all content', 'db', 'deleteAllContent', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31a1', 'Send mail', 'mail', 'send', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31a2', 'Browse notifications', 'notification', 'browse', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31a3', 'Add notifications', 'notification', 'add', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31a4', 'Delete notifications', 'notification', 'destroy', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31a5', 'Browse posts', 'post', 'browse', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31a6', 'Read posts', 'post', 'read', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31a7', 'Edit posts', 'post', 'edit', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31a8', 'Add posts', 'post', 'add', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31a9', 'Delete posts', 'post', 'destroy', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31aa', 'Browse settings', 'setting', 'browse', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31ab', 'Read settings', 'setting', 'read', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31ac', 'Edit settings', 'setting', 'edit', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31ad', 'Generate slugs', 'slug', 'generate', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31ae', 'Browse tags', 'tag', 'browse', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31af', 'Read tags', 'tag', 'read', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31b0', 'Edit tags', 'tag', 'edit', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31b1', 'Add tags', 'tag', 'add', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31b2', 'Delete tags', 'tag', 'destroy', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31b3', 'Browse themes', 'theme', 'browse', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31b4', 'Edit themes', 'theme', 'edit', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31b5', 'Activate themes', 'theme', 'activate', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31b6', 'Upload themes', 'theme', 'add', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31b7', 'Download themes', 'theme', 'read', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31b8', 'Delete themes', 'theme', 'destroy', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31b9', 'Browse users', 'user', 'browse', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31ba', 'Read users', 'user', 'read', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31bb', 'Edit users', 'user', 'edit', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31bc', 'Add users', 'user', 'add', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31bd', 'Delete users', 'user', 'destroy', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31be', 'Assign a role', 'role', 'assign', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31bf', 'Browse roles', 'role', 'browse', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31c0', 'Browse clients', 'client', 'browse', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31c1', 'Read clients', 'client', 'read', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31c2', 'Edit clients', 'client', 'edit', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31c3', 'Add clients', 'client', 'add', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31c4', 'Delete clients', 'client', 'destroy', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31c5', 'Browse subscribers', 'subscriber', 'browse', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31c6', 'Read subscribers', 'subscriber', 'read', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31c7', 'Edit subscribers', 'subscriber', 'edit', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31c8', 'Add subscribers', 'subscriber', 'add', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31c9', 'Delete subscribers', 'subscriber', 'destroy', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31ca', 'Browse invites', 'invite', 'browse', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31cb', 'Read invites', 'invite', 'read', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31cc', 'Edit invites', 'invite', 'edit', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31cd', 'Add invites', 'invite', 'add', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31ce', 'Delete invites', 'invite', 'destroy', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31cf', 'Download redirects', 'redirect', 'download', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31d0', 'Upload redirects', 'redirect', 'upload', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31d1', 'Add webhooks', 'webhook', 'add', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f31d2', 'Delete webhooks', 'webhook', 'destroy', NULL, '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1');

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
('5b7ff88582102400017f31d4', '5b7ff88482102400017f3199', '5b7ff88482102400017f319e'),
('5b7ff88582102400017f31d5', '5b7ff88482102400017f3199', '5b7ff88482102400017f319f'),
('5b7ff88582102400017f31d6', '5b7ff88482102400017f3199', '5b7ff88482102400017f31a0'),
('5b7ff88582102400017f31d7', '5b7ff88482102400017f3199', '5b7ff88482102400017f31a1'),
('5b7ff88582102400017f31d8', '5b7ff88482102400017f3199', '5b7ff88482102400017f31a2'),
('5b7ff88582102400017f31d9', '5b7ff88482102400017f3199', '5b7ff88482102400017f31a3'),
('5b7ff88582102400017f31da', '5b7ff88482102400017f3199', '5b7ff88482102400017f31a4'),
('5b7ff88582102400017f31db', '5b7ff88482102400017f3199', '5b7ff88482102400017f31a5'),
('5b7ff88582102400017f31dc', '5b7ff88482102400017f3199', '5b7ff88482102400017f31a6'),
('5b7ff88582102400017f31dd', '5b7ff88482102400017f3199', '5b7ff88482102400017f31a7'),
('5b7ff88582102400017f31de', '5b7ff88482102400017f3199', '5b7ff88482102400017f31a8'),
('5b7ff88582102400017f31df', '5b7ff88482102400017f3199', '5b7ff88482102400017f31a9'),
('5b7ff88582102400017f31e0', '5b7ff88482102400017f3199', '5b7ff88482102400017f31aa'),
('5b7ff88582102400017f31e1', '5b7ff88482102400017f3199', '5b7ff88482102400017f31ab'),
('5b7ff88582102400017f31e2', '5b7ff88482102400017f3199', '5b7ff88482102400017f31ac'),
('5b7ff88582102400017f31e3', '5b7ff88482102400017f3199', '5b7ff88482102400017f31ad'),
('5b7ff88582102400017f31e4', '5b7ff88482102400017f3199', '5b7ff88482102400017f31ae'),
('5b7ff88582102400017f31e5', '5b7ff88482102400017f3199', '5b7ff88482102400017f31af'),
('5b7ff88582102400017f31e6', '5b7ff88482102400017f3199', '5b7ff88482102400017f31b0'),
('5b7ff88582102400017f31e7', '5b7ff88482102400017f3199', '5b7ff88482102400017f31b1'),
('5b7ff88582102400017f31e8', '5b7ff88482102400017f3199', '5b7ff88482102400017f31b2'),
('5b7ff88582102400017f31e9', '5b7ff88482102400017f3199', '5b7ff88482102400017f31b3'),
('5b7ff88582102400017f31ea', '5b7ff88482102400017f3199', '5b7ff88482102400017f31b4'),
('5b7ff88582102400017f31eb', '5b7ff88482102400017f3199', '5b7ff88482102400017f31b5'),
('5b7ff88582102400017f31ec', '5b7ff88482102400017f3199', '5b7ff88482102400017f31b6'),
('5b7ff88582102400017f31ed', '5b7ff88482102400017f3199', '5b7ff88482102400017f31b7'),
('5b7ff88582102400017f31ee', '5b7ff88482102400017f3199', '5b7ff88482102400017f31b8'),
('5b7ff88582102400017f31ef', '5b7ff88482102400017f3199', '5b7ff88482102400017f31b9'),
('5b7ff88582102400017f31f0', '5b7ff88482102400017f3199', '5b7ff88482102400017f31ba'),
('5b7ff88582102400017f31f1', '5b7ff88482102400017f3199', '5b7ff88482102400017f31bb'),
('5b7ff88582102400017f31f2', '5b7ff88482102400017f3199', '5b7ff88482102400017f31bc'),
('5b7ff88582102400017f31f3', '5b7ff88482102400017f3199', '5b7ff88482102400017f31bd'),
('5b7ff88582102400017f31f4', '5b7ff88482102400017f3199', '5b7ff88482102400017f31be'),
('5b7ff88582102400017f31f5', '5b7ff88482102400017f3199', '5b7ff88482102400017f31bf'),
('5b7ff88582102400017f31f6', '5b7ff88482102400017f3199', '5b7ff88482102400017f31c0'),
('5b7ff88582102400017f31f7', '5b7ff88482102400017f3199', '5b7ff88482102400017f31c1'),
('5b7ff88582102400017f31f8', '5b7ff88482102400017f3199', '5b7ff88482102400017f31c2'),
('5b7ff88582102400017f31f9', '5b7ff88482102400017f3199', '5b7ff88482102400017f31c3'),
('5b7ff88582102400017f31fa', '5b7ff88482102400017f3199', '5b7ff88482102400017f31c4'),
('5b7ff88582102400017f31fb', '5b7ff88482102400017f3199', '5b7ff88482102400017f31c5'),
('5b7ff88582102400017f31fc', '5b7ff88482102400017f3199', '5b7ff88482102400017f31c6'),
('5b7ff88582102400017f31fd', '5b7ff88482102400017f3199', '5b7ff88482102400017f31c7'),
('5b7ff88582102400017f31fe', '5b7ff88482102400017f3199', '5b7ff88482102400017f31c8'),
('5b7ff88582102400017f31ff', '5b7ff88482102400017f3199', '5b7ff88482102400017f31c9'),
('5b7ff88582102400017f3200', '5b7ff88482102400017f3199', '5b7ff88482102400017f31ca'),
('5b7ff88582102400017f3201', '5b7ff88482102400017f3199', '5b7ff88482102400017f31cb'),
('5b7ff88582102400017f3202', '5b7ff88482102400017f3199', '5b7ff88482102400017f31cc'),
('5b7ff88582102400017f3203', '5b7ff88482102400017f3199', '5b7ff88482102400017f31cd'),
('5b7ff88582102400017f3204', '5b7ff88482102400017f3199', '5b7ff88482102400017f31ce'),
('5b7ff88582102400017f3205', '5b7ff88482102400017f3199', '5b7ff88482102400017f31cf'),
('5b7ff88582102400017f3206', '5b7ff88482102400017f3199', '5b7ff88482102400017f31d0'),
('5b7ff88582102400017f3207', '5b7ff88482102400017f3199', '5b7ff88482102400017f31d1'),
('5b7ff88582102400017f3208', '5b7ff88482102400017f3199', '5b7ff88482102400017f31d2'),
('5b7ff88582102400017f3209', '5b7ff88482102400017f319a', '5b7ff88482102400017f31a5'),
('5b7ff88582102400017f320a', '5b7ff88482102400017f319a', '5b7ff88482102400017f31a6'),
('5b7ff88582102400017f320b', '5b7ff88482102400017f319a', '5b7ff88482102400017f31a7'),
('5b7ff88582102400017f320c', '5b7ff88482102400017f319a', '5b7ff88482102400017f31a8'),
('5b7ff88582102400017f320d', '5b7ff88482102400017f319a', '5b7ff88482102400017f31a9'),
('5b7ff88582102400017f320e', '5b7ff88482102400017f319a', '5b7ff88482102400017f31aa'),
('5b7ff88582102400017f320f', '5b7ff88482102400017f319a', '5b7ff88482102400017f31ab'),
('5b7ff88582102400017f3210', '5b7ff88482102400017f319a', '5b7ff88482102400017f31ad'),
('5b7ff88582102400017f3211', '5b7ff88482102400017f319a', '5b7ff88482102400017f31ae'),
('5b7ff88582102400017f3212', '5b7ff88482102400017f319a', '5b7ff88482102400017f31af'),
('5b7ff88582102400017f3213', '5b7ff88482102400017f319a', '5b7ff88482102400017f31b0'),
('5b7ff88582102400017f3214', '5b7ff88482102400017f319a', '5b7ff88482102400017f31b1'),
('5b7ff88582102400017f3215', '5b7ff88482102400017f319a', '5b7ff88482102400017f31b2'),
('5b7ff88582102400017f3216', '5b7ff88482102400017f319a', '5b7ff88482102400017f31b9'),
('5b7ff88582102400017f3217', '5b7ff88482102400017f319a', '5b7ff88482102400017f31ba'),
('5b7ff88582102400017f3218', '5b7ff88482102400017f319a', '5b7ff88482102400017f31bb'),
('5b7ff88582102400017f3219', '5b7ff88482102400017f319a', '5b7ff88482102400017f31bc'),
('5b7ff88582102400017f321a', '5b7ff88482102400017f319a', '5b7ff88482102400017f31bd'),
('5b7ff88582102400017f321b', '5b7ff88482102400017f319a', '5b7ff88482102400017f31be'),
('5b7ff88582102400017f321c', '5b7ff88482102400017f319a', '5b7ff88482102400017f31bf'),
('5b7ff88582102400017f321d', '5b7ff88482102400017f319a', '5b7ff88482102400017f31c0'),
('5b7ff88582102400017f321e', '5b7ff88482102400017f319a', '5b7ff88482102400017f31c1'),
('5b7ff88582102400017f321f', '5b7ff88482102400017f319a', '5b7ff88482102400017f31c2'),
('5b7ff88582102400017f3220', '5b7ff88482102400017f319a', '5b7ff88482102400017f31c3'),
('5b7ff88582102400017f3221', '5b7ff88482102400017f319a', '5b7ff88482102400017f31c4'),
('5b7ff88582102400017f3222', '5b7ff88482102400017f319a', '5b7ff88482102400017f31c8'),
('5b7ff88582102400017f3223', '5b7ff88482102400017f319a', '5b7ff88482102400017f31ca'),
('5b7ff88582102400017f3224', '5b7ff88482102400017f319a', '5b7ff88482102400017f31cb'),
('5b7ff88582102400017f3225', '5b7ff88482102400017f319a', '5b7ff88482102400017f31cc'),
('5b7ff88582102400017f3226', '5b7ff88482102400017f319a', '5b7ff88482102400017f31cd'),
('5b7ff88582102400017f3227', '5b7ff88482102400017f319a', '5b7ff88482102400017f31ce'),
('5b7ff88582102400017f3228', '5b7ff88482102400017f319a', '5b7ff88482102400017f31b3'),
('5b7ff88582102400017f3229', '5b7ff88482102400017f319b', '5b7ff88482102400017f31a5'),
('5b7ff88582102400017f322a', '5b7ff88482102400017f319b', '5b7ff88482102400017f31a6'),
('5b7ff88582102400017f322b', '5b7ff88482102400017f319b', '5b7ff88482102400017f31a8'),
('5b7ff88582102400017f322c', '5b7ff88482102400017f319b', '5b7ff88482102400017f31aa'),
('5b7ff88582102400017f322d', '5b7ff88482102400017f319b', '5b7ff88482102400017f31ab'),
('5b7ff88582102400017f322e', '5b7ff88482102400017f319b', '5b7ff88482102400017f31ad'),
('5b7ff88582102400017f322f', '5b7ff88482102400017f319b', '5b7ff88482102400017f31ae'),
('5b7ff88582102400017f3230', '5b7ff88482102400017f319b', '5b7ff88482102400017f31af'),
('5b7ff88582102400017f3231', '5b7ff88482102400017f319b', '5b7ff88482102400017f31b1'),
('5b7ff88582102400017f3232', '5b7ff88482102400017f319b', '5b7ff88482102400017f31b9'),
('5b7ff88582102400017f3233', '5b7ff88482102400017f319b', '5b7ff88482102400017f31ba'),
('5b7ff88582102400017f3234', '5b7ff88482102400017f319b', '5b7ff88482102400017f31bf'),
('5b7ff88582102400017f3235', '5b7ff88482102400017f319b', '5b7ff88482102400017f31c0'),
('5b7ff88582102400017f3236', '5b7ff88482102400017f319b', '5b7ff88482102400017f31c1'),
('5b7ff88582102400017f3237', '5b7ff88482102400017f319b', '5b7ff88482102400017f31c2'),
('5b7ff88582102400017f3238', '5b7ff88482102400017f319b', '5b7ff88482102400017f31c3'),
('5b7ff88582102400017f3239', '5b7ff88482102400017f319b', '5b7ff88482102400017f31c4'),
('5b7ff88582102400017f323a', '5b7ff88482102400017f319b', '5b7ff88482102400017f31c8'),
('5b7ff88582102400017f323b', '5b7ff88482102400017f319b', '5b7ff88482102400017f31b3'),
('5b7ff88582102400017f323c', '5b7ff88482102400017f319c', '5b7ff88482102400017f31a5'),
('5b7ff88582102400017f323d', '5b7ff88482102400017f319c', '5b7ff88482102400017f31a6'),
('5b7ff88582102400017f323e', '5b7ff88482102400017f319c', '5b7ff88482102400017f31a8'),
('5b7ff88582102400017f323f', '5b7ff88482102400017f319c', '5b7ff88482102400017f31aa'),
('5b7ff88582102400017f3240', '5b7ff88482102400017f319c', '5b7ff88482102400017f31ab'),
('5b7ff88582102400017f3241', '5b7ff88482102400017f319c', '5b7ff88482102400017f31ad'),
('5b7ff88582102400017f3242', '5b7ff88482102400017f319c', '5b7ff88482102400017f31ae'),
('5b7ff88582102400017f3243', '5b7ff88482102400017f319c', '5b7ff88482102400017f31af'),
('5b7ff88582102400017f3244', '5b7ff88482102400017f319c', '5b7ff88482102400017f31b9'),
('5b7ff88582102400017f3245', '5b7ff88482102400017f319c', '5b7ff88482102400017f31ba'),
('5b7ff88582102400017f3246', '5b7ff88482102400017f319c', '5b7ff88482102400017f31bf'),
('5b7ff88582102400017f3247', '5b7ff88482102400017f319c', '5b7ff88482102400017f31c0'),
('5b7ff88582102400017f3248', '5b7ff88482102400017f319c', '5b7ff88482102400017f31c1'),
('5b7ff88582102400017f3249', '5b7ff88482102400017f319c', '5b7ff88482102400017f31c2'),
('5b7ff88582102400017f324a', '5b7ff88482102400017f319c', '5b7ff88482102400017f31c3'),
('5b7ff88582102400017f324b', '5b7ff88482102400017f319c', '5b7ff88482102400017f31c4'),
('5b7ff88582102400017f324c', '5b7ff88482102400017f319c', '5b7ff88482102400017f31c8'),
('5b7ff88582102400017f324d', '5b7ff88482102400017f319c', '5b7ff88482102400017f31b3');

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
  `comment_id` varchar(50) DEFAULT NULL,
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
('5b7ff8eee9ede900013f66dd', 'HTXwTd1hqbhpsnkGErsv94xkJf7h2voxKOLzFulbtQBn5RObQdkYkXrl29eULQFDApNarjA00TcwFUnJQwfxR4rSatTIE8onRdb5MwwUDwRJlue8zIfmFEw0PhUhBq124Y706R22XYwyC5XO6l6rlQKPllYdu3s3Jrf5oHXaNOsOyXk4r6l9APY627lQizY', '1', '5b7f69148369200001905025', 1550881454356);

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
('5b7ff88482102400017f3199', 'Administrator', 'Administrators', '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f319a', 'Editor', 'Editors', '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f319b', 'Author', 'Authors', '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f319c', 'Contributor', 'Contributors', '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1'),
('5b7ff88482102400017f319d', 'Owner', 'Blog Owner', '2018-08-24 12:22:28', '1', '2018-08-24 12:22:28', '1');

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
('5b7ff88482102400017f31d3', '5b7ff88482102400017f319b', '5951f5fca366002ebd5dbef7'),
('5b7ff88582102400017f3255', '5b7ff88482102400017f319d', '1');

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
('5b7ff88582102400017f3256', 'db_hash', 'a255e5f6-4c09-48b8-ab76-bf4fa8a7f28e', 'core', '2018-08-24 12:22:29', '1', '2018-08-24 12:22:29', '1'),
('5b7ff88582102400017f3257', 'next_update_check', '1535199832', 'core', '2018-08-24 12:22:29', '1', '2018-08-24 12:23:51', '1'),
('5b7ff88582102400017f3258', 'notifications', '[]', 'core', '2018-08-24 12:22:29', '1', '2018-08-24 12:22:29', '1'),
('5b7ff88582102400017f3259', 'title', 'Open RSC', 'blog', '2018-08-24 12:22:29', '1', '2018-08-24 12:24:14', '1'),
('5b7ff88582102400017f325a', 'description', 'Striving for a replica RSC game and more', 'blog', '2018-08-24 12:22:29', '1', '2018-08-24 12:25:10', '1'),
('5b7ff88582102400017f325b', 'logo', '', 'blog', '2018-08-24 12:22:29', '1', '2018-08-24 12:25:10', '1'),
('5b7ff88582102400017f325c', 'cover_image', '/blog/content/images/2018/08/wod.png', 'blog', '2018-08-24 12:22:29', '1', '2018-08-24 12:26:37', '1'),
('5b7ff88582102400017f325d', 'icon', '', 'blog', '2018-08-24 12:22:29', '1', '2018-08-24 12:22:29', '1'),
('5b7ff88582102400017f325e', 'default_locale', 'en', 'blog', '2018-08-24 12:22:29', '1', '2018-08-24 12:22:29', '1'),
('5b7ff88582102400017f325f', 'active_timezone', 'America/New_York', 'blog', '2018-08-24 12:22:29', '1', '2018-08-24 12:25:10', '1'),
('5b7ff88582102400017f3260', 'force_i18n', 'true', 'blog', '2018-08-24 12:22:29', '1', '2018-08-24 12:22:29', '1'),
('5b7ff88582102400017f3261', 'permalinks', '/:slug/', 'blog', '2018-08-24 12:22:29', '1', '2018-08-24 12:22:29', '1'),
('5b7ff88582102400017f3262', 'amp', 'true', 'blog', '2018-08-24 12:22:29', '1', '2018-08-24 12:22:29', '1'),
('5b7ff88582102400017f3263', 'ghost_head', '', 'blog', '2018-08-24 12:22:29', '1', '2018-08-24 12:22:29', '1'),
('5b7ff88582102400017f3264', 'ghost_foot', '', 'blog', '2018-08-24 12:22:29', '1', '2018-08-24 12:22:29', '1'),
('5b7ff88582102400017f3265', 'facebook', '', 'blog', '2018-08-24 12:22:29', '1', '2018-08-24 12:27:50', '1'),
('5b7ff88582102400017f3266', 'twitter', '', 'blog', '2018-08-24 12:22:29', '1', '2018-08-24 12:27:47', '1'),
('5b7ff88582102400017f3267', 'labs', '{\"publicAPI\":false}', 'blog', '2018-08-24 12:22:29', '1', '2018-08-24 12:24:32', '1'),
('5b7ff88582102400017f3268', 'navigation', '[{\"label\":\"Home\",\"url\":\"/\"}]', 'blog', '2018-08-24 12:22:29', '1', '2018-08-24 12:27:30', '1'),
('5b7ff88582102400017f3269', 'slack', '[]', 'blog', '2018-08-24 12:22:29', '1', '2018-08-24 12:24:32', '1'),
('5b7ff88582102400017f326a', 'unsplash', '{\"isActive\":true}', 'blog', '2018-08-24 12:22:29', '1', '2018-08-24 12:24:32', '1'),
('5b7ff88582102400017f326b', 'active_theme', 'casper', 'theme', '2018-08-24 12:22:29', '1', '2018-08-24 12:22:29', '1'),
('5b7ff88582102400017f326c', 'active_apps', '[]', 'app', '2018-08-24 12:22:29', '1', '2018-08-24 12:22:29', '1'),
('5b7ff88582102400017f326d', 'installed_apps', '[]', 'app', '2018-08-24 12:22:29', '1', '2018-08-24 12:22:29', '1'),
('5b7ff88582102400017f326e', 'is_private', 'false', 'private', '2018-08-24 12:22:29', '1', '2018-08-24 12:22:29', '1'),
('5b7ff88582102400017f326f', 'password', '', 'private', '2018-08-24 12:22:29', '1', '2018-08-24 12:22:29', '1'),
('5b7ff88582102400017f3270', 'public_hash', 'f662411aebcb86a664253258fab22d', 'private', '2018-08-24 12:22:29', '1', '2018-08-24 12:22:29', '1');

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
('1', 'Administrator', 'administrator', NULL, NULL, '$2a$10$SDrySMQvotIzZVTNW3k4A.01n5DaOb7vmFGuilu4VCVElK0DtP9Qu', 'admin@openrsc.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"nightShift\":true}', 'active', NULL, 'public', NULL, NULL, '[\"getting-started\",\"using-the-editor\",\"static-post\",\"featured-post\",\"upload-a-theme\"]', '2018-08-24 12:24:14', '2018-08-24 12:22:28', '1', '2018-08-24 12:24:58', '1');

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
