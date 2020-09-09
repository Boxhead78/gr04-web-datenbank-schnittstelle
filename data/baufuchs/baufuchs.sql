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
  `street` varchar(50) DEFAULT NULL,
  `house_number` int(11) DEFAULT NULL,
  `post_code` int(11) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `deletion_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`address_id`),
  KEY `FK_address_country` (`country_id`),
  CONSTRAINT `FK_address_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Exportiere Daten aus Tabelle baufuchs.address: ~2 rows (ungefähr)
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` (`address_id`, `street`, `house_number`, `post_code`, `city`, `country_id`, `deletion_date`) VALUES
	(1, 'Hauptstraße', 5, 22087, 'Hamburg', 1, NULL),
	(2, 'Hamburger Straße', 19, 22043, 'Hamburg', 1, NULL);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle baufuchs.category
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `category_parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle baufuchs.category: ~12 rows (ungefähr)
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`category_id`, `name`, `category_parent_id`) VALUES
	(1, 'Handwerkzeug', 12),
	(2, 'Maschinen', 5),
	(3, 'Messwerkzeuge', 12),
	(4, 'Maschinenzubehör', 5),
	(5, 'Eisenwaren', NULL),
	(6, 'Blöcke', 10),
	(7, 'Kreaturen', 10),
	(8, 'Gegenstände', 10),
	(9, 'Spielzeugwaren', 11),
	(10, 'Minecraft', NULL),
	(11, 'Kinderwelt', NULL),
	(12, 'Werkzeuge', NULL);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle baufuchs.country
CREATE TABLE IF NOT EXISTS `country` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Exportiere Daten aus Tabelle baufuchs.country: ~0 rows (ungefähr)
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` (`country_id`, `country_name`) VALUES
	(1, 'Deutschland');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle baufuchs.item
CREATE TABLE IF NOT EXISTS `item` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `value_stock` int(11) NOT NULL DEFAULT 0,
  `price` double NOT NULL DEFAULT 0,
  `picture` varchar(50) DEFAULT NULL,
  `color` varchar(50) NOT NULL,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `weight` double DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `material` varchar(50) DEFAULT NULL,
  `manufactorer_id` int(11) DEFAULT NULL,
  `technical_details` varchar(50) DEFAULT NULL,
  `average_rating` double DEFAULT 0,
  `rating_count` int(11) DEFAULT 0,
  PRIMARY KEY (`item_id`) USING BTREE,
  KEY `FK_item_manufactorer` (`manufactorer_id`),
  CONSTRAINT `FK_item_manufactorer` FOREIGN KEY (`manufactorer_id`) REFERENCES `manufactorer` (`manufactorer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle baufuchs.item: ~19 rows (ungefähr)
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` (`item_id`, `name`, `description`, `value_stock`, `price`, `picture`, `color`, `creation_date`, `weight`, `count`, `material`, `manufactorer_id`, `technical_details`, `average_rating`, `rating_count`) VALUES
	(1, 'Hammer', 'Der Gummihammer von Wisent ist das ideale Werkzeug', 5, 8.29, 'hammer.jpg', 'Braun', '2020-09-09 12:41:48', 1074, 1, 'Holz', 1, NULL, 0, 0),
	(2, 'Schraubendreher-Set', 'Das Schraubendreher-Set 810SPC/6 von Hazet', 15, 14.57, 'screwdriver.jpg', 'Schwarz', '2020-09-09 12:41:49', 520, 6, 'Kunststoff Griff', 2, 'Set bestehend aus 4 Schlitz- und 2 Kreuzschlitzsch', 0, 0),
	(3, 'Bügelsäge', 'Die Handbügelsäge von Gardena', 3, 21.35, NULL, 'Weiß', '2020-09-09 12:41:50', 870, 1, 'Kunststoff/Stahl', 3, NULL, 0, 0),
	(4, 'Bolzenschneider', 'Der Bolzenschneider von Wisent eignet sich ideal zum Zerteilen von Metall', 10, 40.45, NULL, 'Schwarz', '2020-09-09 12:41:51', 2400, 1, 'Kunststoff überzogen', 1, 'Länge: 600 mm', 0, 0),
	(5, 'Hammer "Bob-der-Baumeister"', 'Der neueste Hammer aus der "Bob-der-Baumeister" Sammlung', 5, 74.99, 'hammer02.jpg', 'Grün', '2020-09-09 12:41:53', 2400, 1, 'Kunststoff', 9, 'XL Variante', 0, 0),
	(6, 'Erde', 'Ein Würfel Erde aus Minecraft-Kollektion', 5000, 0.99, 'mc_erde.jpg', 'Braun', '2020-09-09 12:41:54', 1000, 1, 'Dreck', 4, NULL, 0, 0),
	(7, 'Stein', 'Ein Würfel Stein aus Minecraft-Kollektion', 2500, 1.49, 'mc_stein.jpg', 'Grau', '2020-09-09 12:41:57', 3000, 1, 'Stein', 4, NULL, 0, 0),
	(8, 'Eisen', 'Ein Würfel Eisen aus Minecraft-Kollektion', 128, 3.49, 'mc_eisen.jpg', 'Schwarz', '2020-09-09 12:41:55', 3500, 1, 'Eisen', 4, NULL, 0, 0),
	(9, 'Huhn', 'Ein Huhn aus unserer Minecraft-Kollektion', 200, 5, 'mc_huhn.jpg', 'Weiß', '2020-09-09 12:41:58', 500, 1, 'Organisch', 4, NULL, 0, 0),
	(10, 'Kabeljau', 'Ein Kabeljau aus unserer Minecraft-Kollektion', 125, 2.49, 'mc_kabeljau.jpg', 'Braun', '2020-09-09 12:41:59', 100, 1, 'Organisch', 4, NULL, 0, 0),
	(11, 'Wolf', 'Ein Wolf aus unserer Minecraft-Kollektion (nicht gezähmt!)', 25, 10, 'mc_wolf.jpg', 'Weiß', '2020-09-09 12:42:00', 2500, 1, 'Organisch', 4, NULL, 0, 0),
	(12, 'Lavaeimer', 'Ein frischer Lavaeimer aus unserer Minecraft-Kollektion', 10, 49.99, 'mc_lava.jpg', 'Weiß', '2020-09-09 12:42:01', 1000, 1, 'Eisen, Lava', 4, NULL, 0, 0),
	(13, 'Lore', 'Eine Lore aus unserer Minecraft-Kollektion', 3, 49.99, 'mc_minecart.jpg', 'Grau', '2020-09-09 12:42:02', 6000, 1, 'Eisen', 4, NULL, 0, 0),
	(14, 'Keks', 'Ein Keks aus unserer Minecraft-Kollektion', 85, 0.49, 'mc_keks.jpg', 'Braun', '2020-09-09 12:42:03', 75, 1, 'Weizen, Kakao', 4, NULL, 0, 0),
	(15, 'Knochen', 'Ein Knochen aus unserer Minecraft-Kollektion', 1500, 3.29, 'mc_knochen.jpg', 'Weiß', '2020-09-09 12:42:04', 125, 1, 'Knochen', 4, NULL, 0, 0),
	(16, 'Gummiball', 'Der neue sprunghafte Gummiball', 50, 0.29, 'gummiball.jpg', 'Blau', '2020-09-09 12:42:05', 50, 1, 'Gummi', 1, 'Durchmesser: 25cm', 0, 0),
	(17, 'Big Fun Chemistry', 'Big Fun Chemistry Chemiebaukasten', 7, 30.49, 'chemistry.jpg', 'Grün', '2020-09-09 12:42:06', 2000, 1, 'Kunststoff', 1, 'Mit Pipette, Messbecher & Co', 0, 0),
	(18, 'Fußball', 'Dies ist der ideale Fußball', 25, 14.99, 'fußball.jpg', 'Weiß', '2020-09-09 12:42:07', 400, 1, 'Leder', 3, 'Ultralange lebensdauer', 0, 0),
	(19, 'Diamant', 'Ein Diamant aus unserer Minecraft-Kollektion', 3, 79.99, 'mc_diamant.jpg', 'Blau', '2020-09-09 12:42:09', 700, 1, 'Diamant', 4, 'Unglaublich hohe Zähigkeit', 0, 0);
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle baufuchs.item2category: ~19 rows (ungefähr)
/*!40000 ALTER TABLE `item2category` DISABLE KEYS */;
INSERT INTO `item2category` (`item2category_id`, `category_id`, `item_id`) VALUES
	(1, 1, 1),
	(2, 1, 2),
	(3, 1, 4),
	(4, 1, 3),
	(5, 1, 9),
	(6, 6, 6),
	(7, 6, 7),
	(8, 6, 8),
	(9, 7, 9),
	(10, 7, 10),
	(11, 7, 11),
	(12, 8, 12),
	(13, 8, 13),
	(14, 8, 14),
	(15, 8, 15),
	(16, 9, 16),
	(17, 9, 17),
	(18, 9, 18),
	(19, 8, 19);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Exportiere Daten aus Tabelle baufuchs.manufactorer: ~4 rows (ungefähr)
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
  `booking_date` timestamp NULL DEFAULT NULL,
  `deletion_date` timestamp NULL DEFAULT NULL,
  `creation_date` timestamp NULL DEFAULT NULL,
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
  `deletion_date` timestamp NULL DEFAULT NULL,
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
	(3, 'Lastschrift'),
	(4, 'Kreditkarte');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle baufuchs.rating
CREATE TABLE IF NOT EXISTS `rating` (
  `rating_id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(50) NOT NULL DEFAULT '0',
  `rating_value` double NOT NULL DEFAULT 0,
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
  `address_id` int(11) DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE KEY `email_address` (`email_address`),
  KEY `FK_user_language` (`language_id`),
  KEY `FK_user_payment` (`payment_id`),
  KEY `FK_user_address` (`address_id`),
  CONSTRAINT `FK_user_address` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`),
  CONSTRAINT `FK_user_language` FOREIGN KEY (`language_id`) REFERENCES `language` (`language_id`),
  CONSTRAINT `FK_user_payment` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle baufuchs.user: ~2 rows (ungefähr)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `first_name`, `gender`, `surname`, `birthday`, `session_id`, `password`, `language_id`, `payment_id`, `address_id`, `email_address`) VALUES
	(1, 'Fabian', 'Männlich', 'Hennemann', '1999-12-28', 1, '', 1, 1, NULL, 'fabian.hennemann@baufuchs.de'),
	(2, 'Maik', 'Männlich', 'Baumann', '1996-08-19', 2, '', 1, 3, NULL, 'maik.baumann@baufuchs.de');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
