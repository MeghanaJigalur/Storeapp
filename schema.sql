-- ===================================================
-- STORE RATING APPLICATION (Storeapp)
-- Database Schema Definition
-- Database: store_rating_db
-- ===================================================

CREATE DATABASE IF NOT EXISTS `store_rating_db` 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `store_rating_db`;

-- ---------------------------------------------------
-- 1. USERS TABLE
-- ---------------------------------------------------
-- Stores system administrators, store owners, and normal users.
-- Name length: 20 - 60 chars
-- Address length: max 400 chars
-- Passwords stored as bcrypt hashes
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(60) NOT NULL,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `address` VARCHAR(400) NOT NULL,
  `role` ENUM('admin', 'user', 'store_owner') NOT NULL DEFAULT 'user',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_users_role` (`role`),
  INDEX `idx_users_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------
-- 2. STORES TABLE
-- ---------------------------------------------------
-- Stores store information and optional association with a store owner.
-- Name length: 20 - 60 chars
-- Address length: max 400 chars
CREATE TABLE IF NOT EXISTS `stores` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(60) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `address` VARCHAR(400) NOT NULL,
  `owner_id` INT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT `fk_stores_owner` FOREIGN KEY (`owner_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE SET NULL 
    ON UPDATE CASCADE,
  INDEX `idx_stores_owner` (`owner_id`),
  INDEX `idx_stores_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------
-- 3. RATINGS TABLE
-- ---------------------------------------------------
-- Stores ratings submitted by normal users for stores.
-- Rating must be between 1 and 5.
-- UNIQUE constraint on (user_id, store_id) ensures one rating per user per store.
CREATE TABLE IF NOT EXISTS `ratings` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `store_id` INT NOT NULL,
  `rating` TINYINT NOT NULL CHECK (`rating` >= 1 AND `rating` <= 5),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_ratings_user` FOREIGN KEY (`user_id`) 
    REFERENCES `users` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ratings_store` FOREIGN KEY (`store_id`) 
    REFERENCES `stores` (`id`) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT `unique_user_store_rating` UNIQUE (`user_id`, `store_id`),
  INDEX `idx_ratings_store` (`store_id`),
  INDEX `idx_ratings_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
