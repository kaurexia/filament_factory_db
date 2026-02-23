-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: filament_factory
-- ------------------------------------------------------
-- Server version	9.5.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '4783e40a-c40a-11f0-9006-0a0027000004:1-335';

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color_id` int NOT NULL,
  `diameter_id` int NOT NULL,
  `quantity_kg` decimal(10,3) NOT NULL,
  `production_date` date NOT NULL,
  `process_id` int DEFAULT NULL,
  `batch_number` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `color_id` (`color_id`),
  KEY `diameter_id` (`diameter_id`),
  KEY `process_id` (`process_id`),
  KEY `idx_products_production_date` (`production_date`),
  KEY `idx_products_type_color_diameter` (`product_type`,`color_id`,`diameter_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`color_id`) REFERENCES `productcolors` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`diameter_id`) REFERENCES `filamentdiameters` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `products_ibfk_3` FOREIGN KEY (`process_id`) REFERENCES `productionprocesses` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'PLA',1,1,9.200,'2025-12-01',1,'PLA-WHT-011225'),(2,'PLA',1,1,2.500,'2025-12-14',1,'PLA-WHT-DEMO'),(3,'PLA',1,1,2.500,'2025-12-16',1,'PLA-WHT-DEMO'),(4,'PLA',1,1,2.500,'2025-12-16',2,'PLA-WHT-DEMO'),(5,'PLA',1,1,9.000,'2025-10-01',1,'P-001'),(6,'PLA',2,1,10.000,'2025-10-02',2,'P-002'),(7,'PETG',3,1,8.000,'2025-10-03',3,'P-003'),(8,'ABS',7,1,7.000,'2025-10-04',4,'P-004'),(9,'TPU',9,1,6.000,'2025-10-05',5,'P-005'),(10,'ASA',1,1,9.000,'2025-10-06',6,'P-006'),(11,'PC',2,1,8.000,'2025-10-07',7,'P-007'),(12,'PA',9,1,6.000,'2025-10-08',8,'P-008'),(13,'HIPS',1,1,7.000,'2025-10-09',9,'P-009'),(14,'PLA',3,1,10.000,'2025-10-10',10,'P-010'),(15,'PLA',1,1,2.000,'2025-12-16',1,'PLA-WHT-TEST'),(16,'PLA',1,1,2.000,'2025-12-17',1,'PLA-WHT-TEST'),(17,'PLA',1,1,2.000,'2025-12-17',2,'PLA-WHT-TEST');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-19 20:33:53
