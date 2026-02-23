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
-- Table structure for table `rawmaterials`
--

DROP TABLE IF EXISTS `rawmaterials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rawmaterials` (
  `id` int NOT NULL AUTO_INCREMENT,
  `material_type_id` int NOT NULL,
  `quantity_kg` decimal(10,3) NOT NULL,
  `received_date` date NOT NULL,
  `supplier_id` int DEFAULT NULL,
  `quality_grade` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `batch_number` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `price_total` decimal(12,2) DEFAULT NULL COMMENT 'Общая стоимость партии, руб',
  PRIMARY KEY (`id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `idx_rawmaterials_received_date` (`received_date`),
  KEY `idx_rawmaterials_type` (`material_type_id`),
  CONSTRAINT `rawmaterials_ibfk_1` FOREIGN KEY (`material_type_id`) REFERENCES `rawmaterialtypes` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `rawmaterials_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rawmaterials`
--

LOCK TABLES `rawmaterials` WRITE;
/*!40000 ALTER TABLE `rawmaterials` DISABLE KEYS */;
INSERT INTO `rawmaterials` VALUES (1,1,10.000,'2025-12-01',1,'Premium','PLA-20251201-A','2025-12-08 18:15:39',12500.00),(2,1,25.000,'2025-08-08',2,'Premium','PLA-BLK-080825','2025-12-08 18:15:39',31250.00),(3,2,15.000,'2025-08-07',3,'Standard+','PETG-RED-070825','2025-12-08 18:15:39',18750.00),(4,4,8.500,'2025-08-06',4,'Flex','TPU-CLR-060825','2025-12-08 18:15:39',10625.00),(5,1,20.000,'2025-09-01',1,'A','PLA-01','2025-12-16 12:10:35',NULL),(6,1,25.000,'2025-09-05',2,'A','PLA-02','2025-12-16 12:10:35',NULL),(7,2,15.000,'2025-09-07',3,'B','PETG-01','2025-12-16 12:10:35',NULL),(8,3,18.000,'2025-09-10',4,'A','ABS-01','2025-12-16 12:10:35',NULL),(9,4,10.000,'2025-09-12',5,'A','TPU-01','2025-12-16 12:10:35',NULL),(10,5,22.000,'2025-09-15',6,'A','ASA-01','2025-12-16 12:10:35',NULL),(11,6,30.000,'2025-09-18',7,'A','PC-01','2025-12-16 12:10:35',NULL),(12,7,12.000,'2025-09-20',8,'B','PA-01','2025-12-16 12:10:35',NULL),(13,8,14.000,'2025-09-22',9,'B','HIPS-01','2025-12-16 12:10:35',NULL),(14,9,8.000,'2025-09-25',10,'A','PVA-01','2025-12-16 12:10:35',NULL),(15,10,16.000,'2025-09-27',1,'A','CFPLA-01','2025-12-16 12:10:35',NULL),(16,2,19.000,'2025-09-28',2,'A','PETG-02','2025-12-16 12:10:35',NULL),(17,3,21.000,'2025-09-29',3,'B','ABS-02','2025-12-16 12:10:35',NULL),(18,4,9.000,'2025-09-30',4,'A','TPU-02','2025-12-16 12:10:35',NULL),(19,1,27.000,'2025-10-01',5,'A','PLA-03','2025-12-16 12:10:35',NULL);
/*!40000 ALTER TABLE `rawmaterials` ENABLE KEYS */;
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

-- Dump completed on 2025-12-19 20:33:56
