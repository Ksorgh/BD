-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: cs2_server
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin_sessions`
--

DROP TABLE IF EXISTS `admin_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_sessions` (
  `admin_session_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL,
  `server_ip` varchar(15) NOT NULL,
  `connect_time` datetime DEFAULT current_timestamp(),
  `disconnect_time` datetime DEFAULT NULL,
  `duration_minutes` int(11) DEFAULT NULL,
  `actions_count` int(11) DEFAULT 0,
  PRIMARY KEY (`admin_session_id`),
  KEY `admin_id` (`admin_id`),
  CONSTRAINT `admin_sessions_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_sessions`
--

LOCK TABLES `admin_sessions` WRITE;
/*!40000 ALTER TABLE `admin_sessions` DISABLE KEYS */;
INSERT INTO `admin_sessions` VALUES (1,1,'192.168.1.200','2025-11-05 18:00:00','2025-11-05 22:00:00',240,5),(2,2,'192.168.1.201','2025-11-06 19:30:00','2025-11-06 23:30:00',240,3),(3,3,'192.168.1.200','2025-11-07 20:00:00','2025-11-08 00:00:00',240,2),(4,1,'192.168.1.202','2025-11-10 10:00:00',NULL,NULL,1),(5,2,'192.168.1.200','2025-11-10 11:00:00',NULL,NULL,0);
/*!40000 ALTER TABLE `admin_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `admin_flags` varchar(32) DEFAULT 'z',
  `immunity_level` tinyint(4) DEFAULT 1,
  `granted_by` int(11) DEFAULT NULL,
  `grant_date` datetime DEFAULT current_timestamp(),
  `expire_date` datetime DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`admin_id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`player_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,1,'abcdefghijklmnopqrstu',100,NULL,'2025-01-20 09:00:00','2025-11-10 09:00:00',1),(2,2,'abcdef',50,1,'2025-01-25 10:00:00','2025-11-10 10:00:00',1),(3,3,'abc',25,1,'2025-02-01 11:00:00','2025-11-10 11:00:00',1),(4,4,'z',10,2,'2025-02-10 12:00:00','2025-11-10 12:00:00',0);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ban_types`
--

DROP TABLE IF EXISTS `ban_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ban_types` (
  `ban_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`ban_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ban_types`
--

LOCK TABLES `ban_types` WRITE;
/*!40000 ALTER TABLE `ban_types` DISABLE KEYS */;
INSERT INTO `ban_types` VALUES (1,'Mute','Chat ban'),(2,'Gag','Voice chat ban'),(3,'Temp Ban','Temporary game ban'),(4,'Perm Ban','Permanent game ban');
/*!40000 ALTER TABLE `ban_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bans`
--

DROP TABLE IF EXISTS `bans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bans` (
  `ban_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `ban_type_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `ban_date` datetime DEFAULT current_timestamp(),
  `unban_date` datetime DEFAULT NULL,
  `duration_minutes` int(11) NOT NULL,
  `is_active` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`ban_id`),
  KEY `player_id` (`player_id`),
  KEY `admin_id` (`admin_id`),
  KEY `ban_type_id` (`ban_type_id`),
  CONSTRAINT `bans_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`player_id`),
  CONSTRAINT `bans_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`admin_id`),
  CONSTRAINT `bans_ibfk_3` FOREIGN KEY (`ban_type_id`) REFERENCES `ban_types` (`ban_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bans`
--

LOCK TABLES `bans` WRITE;
/*!40000 ALTER TABLE `bans` DISABLE KEYS */;
INSERT INTO `bans` VALUES (1,4,1,1,'Оскорбления в чате','2025-11-05 20:30:00','2025-11-06 20:30:00',1440,0),(2,5,2,2,'Использование звуковых спамов','2025-11-06 21:15:00','2025-11-07 21:15:00',1440,0),(3,6,1,3,'Читерство','2025-11-07 22:00:00','2025-11-10 22:00:00',4320,1),(4,7,3,4,'Множественные нарушения','2025-11-08 23:45:00',NULL,525600,1),(5,8,2,1,'Спам в чате','2025-11-09 19:20:00','2025-11-10 07:20:00',720,0);
/*!40000 ALTER TABLE `bans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_privileges`
--

DROP TABLE IF EXISTS `player_privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_privileges` (
  `player_privilege_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `privilege_id` int(11) NOT NULL,
  `purchase_date` datetime DEFAULT current_timestamp(),
  `expire_date` datetime NOT NULL,
  `is_active` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`player_privilege_id`),
  KEY `player_id` (`player_id`),
  KEY `privilege_id` (`privilege_id`),
  CONSTRAINT `player_privileges_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`player_id`),
  CONSTRAINT `player_privileges_ibfk_2` FOREIGN KEY (`privilege_id`) REFERENCES `privileges` (`privilege_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_privileges`
--

LOCK TABLES `player_privileges` WRITE;
/*!40000 ALTER TABLE `player_privileges` DISABLE KEYS */;
INSERT INTO `player_privileges` VALUES (1,2,1,'2025-11-01 14:30:00','2025-12-01 14:30:00',1),(2,3,2,'2025-11-05 15:45:00','2025-12-05 15:45:00',1),(3,4,3,'2025-11-10 16:20:00','2025-12-10 16:20:00',1),(4,5,1,'2025-10-15 17:10:00','2025-11-15 17:10:00',0),(5,6,2,'2025-11-08 18:30:00','2025-12-08 18:30:00',1),(6,7,1,'2025-11-09 19:45:00','2025-12-09 19:45:00',1);
/*!40000 ALTER TABLE `player_privileges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_sessions`
--

DROP TABLE IF EXISTS `player_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_sessions` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `server_ip` varchar(15) NOT NULL,
  `connect_time` datetime DEFAULT current_timestamp(),
  `disconnect_time` datetime DEFAULT NULL,
  `duration_minutes` int(11) DEFAULT NULL,
  PRIMARY KEY (`session_id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `player_sessions_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`player_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_sessions`
--

LOCK TABLES `player_sessions` WRITE;
/*!40000 ALTER TABLE `player_sessions` DISABLE KEYS */;
INSERT INTO `player_sessions` VALUES (1,1,'192.168.1.200','2025-11-05 18:00:00','2025-11-05 20:30:00',150),(2,2,'192.168.1.200','2025-11-06 19:15:00','2025-11-06 22:45:00',210),(3,3,'192.168.1.201','2025-11-07 20:00:00','2025-11-07 23:30:00',210),(4,4,'192.168.1.201','2025-11-08 21:30:00','2025-11-09 00:15:00',165),(5,5,'192.168.1.200','2025-11-09 22:00:00','2025-11-10 01:00:00',180),(6,1,'192.168.1.202','2025-11-10 10:00:00','2025-11-10 12:30:00',150),(7,2,'192.168.1.202','2025-11-10 11:00:00',NULL,NULL),(8,3,'192.168.1.200','2025-11-10 12:00:00',NULL,NULL);
/*!40000 ALTER TABLE `player_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `players` (
  `player_id` int(11) NOT NULL AUTO_INCREMENT,
  `steam_id` varchar(20) NOT NULL,
  `player_name` varchar(64) NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `balance` decimal(10,2) DEFAULT 0.00,
  `registration_date` datetime DEFAULT current_timestamp(),
  `last_seen` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`player_id`),
  UNIQUE KEY `steam_id` (`steam_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` VALUES (1,'76561198010000001','PlayerOne','192.168.1.101',50.00,'2025-01-15 10:30:00','2025-11-05 18:45:00'),(2,'76561198010000002','ProGamer','192.168.1.102',25.50,'2025-01-16 11:20:00','2025-11-06 19:30:00'),(3,'76561198010000003','SniperKing','192.168.1.103',100.00,'2025-01-17 12:15:00','2025-11-07 20:15:00'),(4,'76561198010000004','RushB','192.168.1.104',10.00,'2025-01-18 13:40:00','2025-11-08 21:00:00'),(5,'76561198010000005','Tactical','192.168.1.105',75.25,'2025-01-19 14:50:00','2025-11-09 22:30:00'),(6,'76561198010000006','AWP_God','192.168.1.106',30.00,'2025-01-20 15:25:00','2025-11-10 23:15:00'),(7,'76561198010000007','Ninja','192.168.1.107',5.00,'2025-01-21 16:35:00','2025-11-03 10:20:00'),(8,'76561198010000008','CyberWolf','192.168.1.108',150.75,'2025-01-22 17:45:00','2025-11-04 11:30:00'),(9,'76561198010000009','HeadHunter','192.168.1.109',45.50,'2025-01-23 18:55:00','2025-11-05 12:45:00'),(10,'76561198010000010','SilentKiller','192.168.1.110',80.00,'2025-01-24 19:05:00','2025-11-06 13:20:00');
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privilege_purchases`
--

DROP TABLE IF EXISTS `privilege_purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `privilege_purchases` (
  `purchase_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `privilege_id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `purchase_date` datetime DEFAULT current_timestamp(),
  `price` decimal(8,2) NOT NULL,
  `duration_days` int(11) NOT NULL,
  PRIMARY KEY (`purchase_id`),
  KEY `player_id` (`player_id`),
  KEY `privilege_id` (`privilege_id`),
  KEY `transaction_id` (`transaction_id`),
  CONSTRAINT `privilege_purchases_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`player_id`),
  CONSTRAINT `privilege_purchases_ibfk_2` FOREIGN KEY (`privilege_id`) REFERENCES `privileges` (`privilege_id`),
  CONSTRAINT `privilege_purchases_ibfk_3` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privilege_purchases`
--

LOCK TABLES `privilege_purchases` WRITE;
/*!40000 ALTER TABLE `privilege_purchases` DISABLE KEYS */;
INSERT INTO `privilege_purchases` VALUES (1,2,1,4,'2025-11-01 14:30:00',5.00,30),(2,3,2,5,'2025-11-05 15:45:00',10.00,30),(3,4,3,6,'2025-11-10 16:20:00',20.00,30),(4,5,1,7,'2025-10-15 17:10:00',5.00,30),(5,6,2,8,'2025-11-08 18:30:00',10.00,30),(6,7,1,9,'2025-11-09 19:45:00',5.00,30);
/*!40000 ALTER TABLE `privilege_purchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privileges`
--

DROP TABLE IF EXISTS `privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `privileges` (
  `privilege_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` text DEFAULT NULL,
  `flags` varchar(32) NOT NULL,
  `price` decimal(8,2) DEFAULT 0.00,
  `duration_days` int(11) DEFAULT 30,
  `is_active` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`privilege_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privileges`
--

LOCK TABLES `privileges` WRITE;
/*!40000 ALTER TABLE `privileges` DISABLE KEYS */;
INSERT INTO `privileges` VALUES (1,'VIP','Basic VIP privileges','abc',5.00,30,1),(2,'Premium','Premium privileges with extra features','abcdef',10.00,30,1),(3,'Ultimate','All privileges available','abcdefghij',20.00,30,1);
/*!40000 ALTER TABLE `privileges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `amount` decimal(8,2) NOT NULL,
  `transaction_type` enum('deposit','withdrawal','purchase') NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `transaction_date` datetime DEFAULT current_timestamp(),
  `related_privilege_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `player_id` (`player_id`),
  KEY `related_privilege_id` (`related_privilege_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`player_id`),
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`related_privilege_id`) REFERENCES `privileges` (`privilege_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,2,50.00,'deposit','Пополнение через Qiwi','2025-10-28 14:20:00',NULL),(2,3,25.00,'deposit','Пополнение через WebMoney','2025-11-01 15:30:00',NULL),(3,4,100.00,'deposit','Пополнение через PayPal','2025-11-05 16:45:00',NULL),(4,2,-5.00,'purchase','Покупка привилегии VIP','2025-11-01 14:30:00',1),(5,3,-10.00,'purchase','Покупка привилегии Premium','2025-11-05 15:45:00',2),(6,4,-20.00,'purchase','Покупка привилегии Ultimate','2025-11-10 16:20:00',3),(7,5,-5.00,'purchase','Покупка привилегии VIP','2025-10-15 17:10:00',1),(8,6,-10.00,'purchase','Покупка привилегии Premium','2025-11-08 18:30:00',2),(9,7,-5.00,'purchase','Покупка привилегии VIP','2025-11-09 19:45:00',1),(10,1,-15.00,'withdrawal','Вывод средств','2025-11-08 20:15:00',NULL);
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-15  1:20:44
