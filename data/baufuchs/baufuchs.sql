-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server Version:               10.4.14-MariaDB - mariadb.org binary distribution
-- Server Betriebssystem:        Win64
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Exportiere Struktur von Tabelle sql7361613.address
CREATE TABLE IF NOT EXISTS `address` (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `street` varchar(50) DEFAULT NULL,
  `house_number` int(11) DEFAULT NULL,
  `post_code` int(11) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `deletion_date` date DEFAULT NULL,
  PRIMARY KEY (`address_id`),
  KEY `FK__user` (`user_id`),
  CONSTRAINT `FK__user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Daten Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle sql7361613.category
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Daten Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle sql7361613.currency
CREATE TABLE IF NOT EXISTS `currency` (
  `currency_id` int(11) NOT NULL AUTO_INCREMENT,
  `exchange_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Daten Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle sql7361613.item
CREATE TABLE IF NOT EXISTS `item` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `value_stock` int(11) NOT NULL DEFAULT 0,
  `price` double NOT NULL DEFAULT 0,
  `picture` varchar(50) DEFAULT NULL,
  `color` varchar(50) NOT NULL,
  `creation_date` date NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `material` varchar(50) DEFAULT NULL,
  `manufactorer_id` int(11) DEFAULT NULL,
  `technical_details` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`item_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Daten Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle sql7361613.item2category
CREATE TABLE IF NOT EXISTS `item2category` (
  `item2category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL DEFAULT 0,
  `item_id` int(11) NOT NULL DEFAULT 0,
  `category_parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`item2category_id`) USING BTREE,
  KEY `FK_ittoct_category` (`category_id`),
  KEY `FK_ittoct_items` (`item_id`),
  CONSTRAINT `FK_item2category_item` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Daten Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle sql7361613.language
CREATE TABLE IF NOT EXISTS `language` (
  `language_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Daten Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle sql7361613.manufactorer
CREATE TABLE IF NOT EXISTS `manufactorer` (
  `manufactorer_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`manufactorer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Daten Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle sql7361613.order
CREATE TABLE IF NOT EXISTS `order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `booking_date` date DEFAULT NULL,
  `deletion_date` date DEFAULT NULL,
  `creation_date` date DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`) USING BTREE,
  KEY `FK_order_user` (`user_id`),
  KEY `FK_order_currency` (`currency_id`),
  CONSTRAINT `FK_order_currency` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Daten Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle sql7361613.order_details
CREATE TABLE IF NOT EXISTS `order_details` (
  `order_details_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `deletion_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_details_id`) USING BTREE,
  KEY `FK_rder_details_order` (`order_id`),
  KEY `FK_order_details_items` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Daten Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle sql7361613.payment
CREATE TABLE IF NOT EXISTS `payment` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Daten Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle sql7361613.rating
CREATE TABLE IF NOT EXISTS `rating` (
  `rating_id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(50) NOT NULL DEFAULT '0',
  `rating_value` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`rating_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Daten Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle sql7361613.rating2item
CREATE TABLE IF NOT EXISTS `rating2item` (
  `rating2item_id` int(11) NOT NULL AUTO_INCREMENT,
  `rating_id` int(11) NOT NULL DEFAULT 0,
  `item_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`rating2item_id`) USING BTREE,
  KEY `FK_ra_ratings` (`rating_id`),
  KEY `FK_ra_items` (`item_id`),
  KEY `FK_ratoit_user` (`user_id`),
  CONSTRAINT `FK_ra2it_rating` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Daten Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle sql7361613.user
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `surname` varchar(50) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  KEY `FK_user_language` (`language_id`),
  KEY `FK_user_payment` (`payment_id`),
  CONSTRAINT `FK_user_language` FOREIGN KEY (`language_id`) REFERENCES `language` (`language_id`),
  CONSTRAINT `FK_user_payment` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Daten Export vom Benutzer nicht ausgewählt

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
