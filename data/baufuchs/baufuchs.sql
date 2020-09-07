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

-- Exportiere Struktur von Tabelle baufuchs.address
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
  KEY `FK_address_country` (`country_id`),
  CONSTRAINT `FK__user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FK_address_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Exportiere Daten aus Tabelle baufuchs.address: ~0 rows (ungefähr)
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` (`address_id`, `user_id`, `street`, `house_number`, `post_code`, `city`, `country_id`, `deletion_date`) VALUES
	(1, 1, 'Hauptstraße', 5, 22087, 'Hamburg', 1, NULL),
  (2, 2, 'Hamburger Straße', 19, 22043, 'Hamburg', 1, NULL);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle baufuchs.category
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `category_parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle baufuchs.category: ~5 rows (ungefähr)
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`category_id`, `name`, `category_parent_id`) VALUES
	(1, 'Handwerkzeug', NULL),
	(2, 'Maschienen', NULL),
	(3, 'Messwerkzeuge', NULL),
	(4, 'Maschienenzubeör', NULL),
	(5, 'Eisenwaren', NULL);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle baufuchs.country
CREATE TABLE IF NOT EXISTS `country` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_name` int(11) DEFAULT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Exportiere Daten aus Tabelle baufuchs.country: ~0 rows (ungefähr)
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` (`country_id`, `country_name`) VALUES
	(1, 0);
/*!40000 ALTER TABLE `country` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle baufuchs.item
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
  `average_rating` double DEFAULT 0,
  PRIMARY KEY (`item_id`) USING BTREE,
  KEY `FK_item_currency` (`currency_id`),
  KEY `FK_item_manufactorer` (`manufactorer_id`),
  CONSTRAINT `FK_item_manufactorer` FOREIGN KEY (`manufactorer_id`) REFERENCES `manufactorer` (`manufactorer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle baufuchs.item: ~5 rows (ungefähr)
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` (`item_id`, `name`, `description`, `value_stock`, `price`, `picture`, `color`, `creation_date`, `currency_id`, `weight`, `count`, `material`, `manufactorer_id`, `technical_details`, `average_rating`) VALUES
	(1, 'Hammer', 'Der Gummihammer von Wisent ist das ideale Werkzeug', 5, 8.29, 'hammer.jpg', 'braun', '2020-09-02', NULL, 1074, 1, 'Holz', 1, NULL, 0),
	(2, 'Schraubendreher-Set', 'Das Schraubendreher-Set 810SPC/6 von Hazet besteht', 15, 14.57, 'screwdriver.jpg', 'schwarz', '2020-09-02', NULL, 520, 6, 'Kunststoff Griff', 2, 'Set bestehend aus 4 Schlitz- und 2 Kreuzschlitzsch', 0),
	(3, 'Nägel-Set', NULL, 4, 0, NULL, '', '2020-09-02', NULL, NULL, NULL, NULL, NULL, NULL, 0),
	(4, 'Bügelsäge', NULL, 3, 21.35, NULL, 'silber', '2020-09-02', NULL, 870, 1, 'Kunststoff/Stahl', 3, NULL, 0),
	(5, 'Bolzenschneider', 'Der Bolzenschneider von Wisent eignet sich ideal z', 10, 40.45, NULL, 'orange/schwarz', '2020-09-02', NULL, 2400, 1, 'Kunststoff überzogen', 1, 'Länge: 600 mm', 0);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle baufuchs.item2category
CREATE TABLE IF NOT EXISTS `item2category` (
  `item2category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL DEFAULT 0,
  `item_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`item2category_id`) USING BTREE,
  KEY `FK_ittoct_category` (`category_id`),
  KEY `FK_ittoct_items` (`item_id`),
  CONSTRAINT `FK_item2category_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`),
  CONSTRAINT `FK_item2category_item` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle baufuchs.item2category: ~5 rows (ungefähr)
/*!40000 ALTER TABLE `item2category` DISABLE KEYS */;
INSERT INTO `item2category` (`item2category_id`, `category_id`, `item_id`) VALUES
	(1, 1, 1),
	(2, 1, 2),
	(3, 5, 3),
	(4, 1, 5),
	(5, 1, 4);
/*!40000 ALTER TABLE `item2category` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle baufuchs.language
CREATE TABLE IF NOT EXISTS `language` (
  `language_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportiere Daten aus Tabelle baufuchs.language: ~0 rows (ungefähr)
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
INSERT INTO `language` (`language_id`, `name`) VALUES
	(1, 'deutsch');
/*!40000 ALTER TABLE `language` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle baufuchs.manufactorer
CREATE TABLE IF NOT EXISTS `manufactorer` (
  `manufactorer_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`manufactorer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Exportiere Daten aus Tabelle baufuchs.manufactorer: ~3 rows (ungefähr)
/*!40000 ALTER TABLE `manufactorer` DISABLE KEYS */;
INSERT INTO `manufactorer` (`manufactorer_id`, `name`) VALUES
	(1, 'Wisent'),
	(2, 'Hazet'),
	(3, 'Gardena'),
  (4, 'Mojang');
/*!40000 ALTER TABLE `manufactorer` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle baufuchs.order
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

-- Exportiere Daten aus Tabelle baufuchs.order: ~0 rows (ungefähr)
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle baufuchs.order_details
CREATE TABLE IF NOT EXISTS `order_details` (
  `order_details_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `deletion_date` date DEFAULT NULL,
  PRIMARY KEY (`order_details_id`) USING BTREE,
  KEY `FK_rder_details_order` (`order_id`),
  KEY `FK_order_details_items` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportiere Daten aus Tabelle baufuchs.order_details: ~0 rows (ungefähr)
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle baufuchs.payment
CREATE TABLE IF NOT EXISTS `payment` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Exportiere Daten aus Tabelle baufuchs.payment: ~3 rows (ungefähr)
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` (`payment_id`, `name`) VALUES
	(1, 'PayPal'),
	(2, 'Rechnung'),
	(3, 'Lastschrift');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle baufuchs.rating
CREATE TABLE IF NOT EXISTS `rating` (
  `rating_id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(50) NOT NULL DEFAULT '0',
  `rating_value` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`rating_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle baufuchs.rating: ~5 rows (ungefähr)
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
INSERT INTO `rating` (`rating_id`, `description`, `rating_value`) VALUES
	(1, '0', 4),
	(2, '0', 2),
	(3, '0', 3),
	(4, '0', 1),
	(5, '0', 5);
/*!40000 ALTER TABLE `rating` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle baufuchs.rating2item
CREATE TABLE IF NOT EXISTS `rating2item` (
  `rating2item_id` int(11) NOT NULL AUTO_INCREMENT,
  `rating_id` int(11) NOT NULL DEFAULT 0,
  `item_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`rating2item_id`) USING BTREE,
  KEY `FK_ra_ratings` (`rating_id`),
  KEY `FK_ra_items` (`item_id`),
  KEY `FK_ratoit_user` (`user_id`),
  CONSTRAINT `FK_ra2it_rating` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`),
  CONSTRAINT `FK_rating2item_item` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
  CONSTRAINT `FK_rating2item_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- Exportiere Daten aus Tabelle baufuchs.rating2item: ~5 rows (ungefähr)
/*!40000 ALTER TABLE `rating2item` DISABLE KEYS */;
INSERT INTO `rating2item` (`rating2item_id`, `rating_id`, `item_id`, `user_id`) VALUES
	(1, 1, 3, 1),
	(2, 3, 4, 1),
	(3, 4, 5, 0),
	(4, 2, 2, 1),
	(5, 5, 1, 1);
/*!40000 ALTER TABLE `rating2item` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle baufuchs.user
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle baufuchs.user: ~0 rows (ungefähr)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `first_name`, `gender`, `surname`, `birthday`, `session_id`, `password`, `language_id`, `payment_id`) VALUES
	(1, 'Fabian', 'Männlich', 'Hennemann', '1999-12-28', 1, '', 1, 1),
  (2, 'Maik', 'Männlich', 'Baumann', '1996-08-19', 2, '', 1, 3);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
