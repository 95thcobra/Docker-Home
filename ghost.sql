-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Aug 24, 2018 at 02:05 AM
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
DROP DATABASE IF EXISTS `ghost`;
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
('5b77987386ea86007956775a', 'G6eOQOcgj1ym2KT3wVQrEuR9UvVbgYXRnDyveLuthJWPfMy4G2M0DHHrfvuS7BhbtyUwJQGY6yTkqAWMAGVKfbc08MVM8QWeFMiumWbTie839bs9sq7858pra5agyK2uBIKOTJA7YEaiblDudpSv9haENqs9ZnE2DTcY5blX84sS8I0KrCZNGQtHjRGFur6', '1', '5b77982bc10214003b07bf24', '5b77987386ea860079567759', 1537192467659),
('5b79a6e114de8f0077ebe29c', 'AzDxkYs4M6PHBeNSEkxb10bGTltjuTCdCz0C6Ar46O7wqAl7vwjLd71C84ULdZB6K8luyYYrRw5W1CQJTlUgy2GKAGOOyinactLVYdND4lXq6m4oo8Vit9Um1TBqXY7XK2k5LQmV2X97nVDanJY17xZSrmsHbJVYDUu0RahCRkj1UpKLw5t0LeGHzjcb9P3', '1', '5b77982bc10214003b07bf24', '5b79a6e114de8f0077ebe29b', 1537327233217),
('5b79a7b814de8f0077ebe2d8', 'NeeLPGPqrP0goOZcVPwQNqIuO9n96bBFsgpL2fJc3B3cQp1zGPtclog9SU9Q8ljTwD7sIEwtjYoaa1siQ2Vw4Ualg7NZ7osr8kImau5dZgKPXjqvF1UG4lSZPUcI19XeQqDiEaTLSgLbebZSan4eMnAPBjjb3KaY2dxcETY89H0u4MQ4tNxZhtlSvbiMW2M', '1', '5b77982bc10214003b07bf24', '5b79a7b814de8f0077ebe2d7', 1537327448627),
('5b79a85d14de8f0077ebe2da', 'mGm6kmObORILT4D2iDObItr7IzgJo3AckNTCuwUkX7OwYrWUjwFH74eDWbUZ5FF5I7SlJYSqU4rl7VMnE9ufTDYMTf83e9XM7rqXKAx4s5nwEImyfd77LccSLDKUmMkgNpZJYTg6qbZjSidAoAN3SsleB8vipqwu585PMG7CrdFojOTns7MM09uAwM860Q3', '1', '5b77982bc10214003b07bf24', '5b79a85d14de8f0077ebe2d9', 1537327613251),
('5b7f67bb3d221e0001d968b8', 'jDGwox0n4ACN3goRXJukJiTqW7eawqjbzv8KYXlkoY22uiJnqRgfGbP5js69JKbdm7rmPtT1JadJUwHvXMQ9WYBQGcQmCIhjAqSr7m1m9OqfheYjxMO9hvoYMzlWQk1k5fQI39pbslh5rbURVopdjX2ye5Vm5btcbOcbtgKXMKmLuszfb8givdeiWd1Hd9m', '1', '5b77982bc10214003b07bf24', '5b7f67bb3d221e0001d968b7', 1537704283466);

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
('yoWo8EAybS3oyQ3u4PcuPeRWry0PNHufwQHVFedZ8W0=', 1535074181157, 1535074734219, 1535078334222, 6),
('wU+FjBVnYVPBZJ/guCSWLeGxQxQCynfR+6AnRS6rRGQ=', 1535076283304, 1535076283304, 1535079883307, 1);

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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;

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
(17, '2-demo-post.js', '1.25', '1.25'),
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
('km01', 0, '2018-08-24 01:24:08', '2018-08-24 01:24:10');

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
  `comment_id` longtext,
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
('5b77987386ea860079567759', 'xcwMQgRqNfepleMUQJGBxZZApx3qE4yJYfO60WOdJaI7ds0eSrOguCxksrxYGkAMat3ryWoQF0onhbC5JfHtHBG7a4NTy1ynbK5SqwLdn2Ao5FRiX1LNECG8NfeFCtg6uS4kzc1jEfBSelfnx1TZRkftJb0PbMsY7Zs18mQNwOMdAHvFGeC8WJLLTDClbIl', '1', '5b77982bc10214003b07bf24', 1550332467659),
('5b79a6e114de8f0077ebe29b', 'OUQPbAoIlzdvphLM2katzGJQTAbVCavVOKYjqCURhTkvkgJrYd89H8nJDfYRcm6oyVOD6fAF16NAIFyzLuemIPpLU6siPgYub1IfcuHvBwBWV9WLvpbqmP1olUlUeyFXbf0tv7wZUM18lZ2QDYR2ejz0ngnzZbtaF7gZsAugLdmdfpzzeqIvq25fHWwWqNo', '1', '5b77982bc10214003b07bf24', 1550467233217),
('5b79a7b814de8f0077ebe2d7', 'aQkFMP7tYGbm8lJ7a66Qhic5lKuFogYV1A2hzv0pIW8HpSjxPoHFnjFL1i3L9K69XWtNJCXfStC2Cm23nXP9GmX7at8fIixwuT7uULATGo9jfOSZObIlEOx0cAvcUPUQpPn8bLIqgJWUFGJSSujsz6aO8RK3LegGAHblbWJfCIFlZaoLuq7vTQYEotST8hT', '1', '5b77982bc10214003b07bf24', 1550467448627),
('5b79a85d14de8f0077ebe2d9', '4XVAgLoD2k0LYJyHWluuOGNKGRwnvKqp2U80L3K8bTNKNM8kD6jRWSwRNnsp4fSDBm1iakXJXSuX9Mc8DLhu8TDD7u6gS989cJjKeqwUoXwtJEV4lL11jNfbqjPaPWopfWlp9kaDdC7U6UJDVDEz4UHKblkuKUlQsmkmS2kCkOQaGHNXmZ02rAe5RGPvJWO', '1', '5b77982bc10214003b07bf24', 1550467613251),
('5b7f67bb3d221e0001d968b7', 'xJUNqMYLUlYXC7ebMi09YG5MpqORXdOPwGCS2HF9NMfGMEqeMd6E6WURDOzXz19kJq4d58XeeHAJ5NJKdDMZlrxgykzYpmMNbcqxMAiWiENPHutKV4NUwgHz5RslTu69XTMWvHRAyxpmOhXYAoKnEkrzOjGBcXNmR7uw08PWOZyKTw0m1OvKYDCYAfMjD0p', '1', '5b77982bc10214003b07bf24', 1550844283466);

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
('5b77988186ea86007956775e', '5b77982bc10214003b07bf28', '1'),
('5b79a6ee14de8f0077ebe29f', '5b77982bc10214003b07bf28', '5b79a6ee14de8f0077ebe29d'),
('5b79a6ee14de8f0077ebe2a0', '5b77982bc10214003b07bf28', '5b79a6ee14de8f0077ebe29e');

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
('5b77985f86ea86007956773f', 'next_update_check', '1535154805', 'core', '2018-08-18 03:54:07', '1', '2018-08-23 23:53:25', '1'),
('5b77985f86ea860079567740', 'notifications', '[{\"dismissible\":true,\"location\":\"bottom\",\"status\":\"alert\",\"id\":\"045f7e0c-5305-44bf-8b32-6f955d461234\",\"custom\":true,\"createdAt\":\"2018-08-21T19:07:32.000Z\",\"type\":\"info\",\"top\":true,\"message\":\"<strong>Ghost 2.0 is now available</strong> You are currently using an old version of Ghost which means you don\'t have access to the latest features. <a href=\\\"https://blog.ghost.org/2-0/\\\" target=\\\"_blank\\\" rel=\\\"noopener\\\">Read more!</a>\",\"seen\":true,\"addedAt\":\"2018-08-23T23:53:25.499Z\"}]', 'core', '2018-08-18 03:54:07', '1', '2018-08-23 23:53:40', '1'),
('5b77985f86ea860079567741', 'title', 'Open RSC', 'blog', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-19 17:20:46', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea860079567742', 'description', 'Striving for a replica RSC game and more', 'blog', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-19 17:20:46', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea860079567743', 'logo', '', 'blog', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-20 03:04:45', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea860079567744', 'cover_image', '/blog/content/images/2018/08/wod.png', 'blog', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-24 01:35:46', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea860079567745', 'icon', '', 'blog', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-20 03:05:03', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea860079567746', 'default_locale', 'en', 'blog', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-19 17:20:46', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea860079567747', 'active_timezone', 'America/New_York', 'blog', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-19 17:20:46', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea860079567748', 'force_i18n', 'true', 'blog', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-19 17:20:46', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea860079567749', 'permalinks', '/:year/:month/:day/:slug/', 'blog', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-19 17:20:46', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea86007956774a', 'amp', 'true', 'blog', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea86007956774b', 'ghost_head', '', 'blog', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-20 03:12:09', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea86007956774c', 'ghost_foot', '', 'blog', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-20 03:12:09', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea86007956774d', 'facebook', '', 'blog', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-19 17:20:46', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea86007956774e', 'twitter', '@openrsc', 'blog', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-19 17:20:46', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea86007956774f', 'labs', '{\"publicAPI\":true,\"subscribers\":false}', 'blog', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-24 01:24:10', '1'),
('5b77985f86ea860079567750', 'navigation', '[{\"label\":\"Home\",\"url\":\"/\"},{\"label\":\"Play Now\",\"url\":\"/play-now/\"},{\"label\":\"Bug Reports\",\"url\":\"https://goo.gl/forms/nnhSln7S81l4I26t2\"},{\"label\":\"Discord\",\"url\":\"https://discord.gg/94vVKND\"},{\"label\":\"Reddit\",\"url\":\"https://www.reddit.com/r/openrsc/\"},{\"label\":\"GitHub\",\"url\":\"https://github.com/Open-RSC/Game\"},{\"label\":\"FAQ\",\"url\":\"/faq/\"},{\"label\":\"Our Mission\",\"url\":\"/our-mission/\"},{\"label\":\"Constitution\",\"url\":\"/2018/08/20/open-rsc-constitution/\"},{\"label\":\"Future Plans\",\"url\":\"/future-plans/\"}]', 'blog', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-20 17:35:37', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea860079567751', 'slack', '[]', 'blog', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-19 17:47:32', '1'),
('5b77985f86ea860079567752', 'unsplash', '{\"isActive\":false}', 'blog', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-19 17:20:46', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea860079567753', 'active_theme', 'casper', 'theme', '2018-08-18 03:54:07', '1', '2018-08-18 04:32:14', '1'),
('5b77985f86ea860079567754', 'active_apps', '[]', 'app', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-19 17:20:46', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea860079567755', 'installed_apps', '[]', 'app', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-19 17:20:46', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea860079567756', 'is_private', 'false', 'private', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-19 17:20:46', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea860079567757', 'password', '', 'private', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-19 17:20:46', '5b79a6ee14de8f0077ebe29d'),
('5b77985f86ea860079567758', 'public_hash', 'c2060bdf3dc3512f68aa29407cf2c7', 'private', '2018-08-02 22:25:37', '5b79a6ee14de8f0077ebe29d', '2018-08-19 17:20:46', '5b79a6ee14de8f0077ebe29d');

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
('1', 'Admin', 'admin-user', NULL, NULL, '$2a$10$fI.I8LGUCYOm7G565KSAaOLvOD9qNsWqEn.jYw7ApgAYCnP0L8dOK', 'admin@openrsc.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"nightShift\":true}', 'active', NULL, 'public', NULL, NULL, '[\"getting-started\",\"using-the-editor\",\"static-post\",\"featured-post\",\"upload-a-theme\"]', '2018-08-24 02:04:43', '2018-08-18 03:53:15', '1', '2018-08-24 02:04:43', '1');

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
