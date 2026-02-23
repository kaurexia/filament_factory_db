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
-- Table structure for table `productionprocesses`
--

DROP TABLE IF EXISTS `productionprocesses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productionprocesses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_time` timestamp NOT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `equipment_id` int DEFAULT NULL,
  `responsible_employee_id` int DEFAULT NULL,
  `raw_material_id` int DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `equipment_id` (`equipment_id`),
  KEY `responsible_employee_id` (`responsible_employee_id`),
  KEY `raw_material_id` (`raw_material_id`),
  KEY `idx_processes_start` (`start_time`),
  CONSTRAINT `productionprocesses_ibfk_1` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`) ON DELETE SET NULL,
  CONSTRAINT `productionprocesses_ibfk_2` FOREIGN KEY (`responsible_employee_id`) REFERENCES `employees` (`id`) ON DELETE SET NULL,
  CONSTRAINT `productionprocesses_ibfk_3` FOREIGN KEY (`raw_material_id`) REFERENCES `rawmaterials` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productionprocesses`
--

LOCK TABLES `productionprocesses` WRITE;
/*!40000 ALTER TABLE `productionprocesses` DISABLE KEYS */;
INSERT INTO `productionprocesses` VALUES (1,'Производство PLA Белый 1.75','2025-12-01 06:00:00','2025-12-17 12:27:20','Завершён',1,1,1,'Тестовое обновление без завершения процесса'),(2,'Производство PLA','2025-12-16 10:24:36','2025-12-17 12:28:47','Завершён',1,1,1,'Тестовое обновление без завершения процесса'),(3,'PLA Белый','2025-10-01 05:00:00',NULL,'Завершён',1,1,1,NULL),(4,'PLA Чёрный','2025-10-02 05:00:00',NULL,'Завершён',2,2,2,NULL),(5,'PETG Красный','2025-10-03 05:00:00',NULL,'Завершён',3,5,3,NULL),(6,'ABS Серый','2025-10-04 05:00:00',NULL,'Завершён',4,8,4,NULL),(7,'TPU Прозрачный','2025-10-05 05:00:00',NULL,'Завершён',5,6,5,NULL),(8,'ASA Белый','2025-10-06 05:00:00',NULL,'Завершён',6,1,6,NULL),(9,'PC Чёрный','2025-10-07 05:00:00',NULL,'Завершён',7,2,7,NULL),(10,'PA Натуральный','2025-10-08 05:00:00',NULL,'Завершён',8,5,8,NULL),(11,'HIPS Белый','2025-10-09 05:00:00',NULL,'Завершён',9,6,9,NULL),(12,'PLA Красный','2025-10-10 05:00:00',NULL,'Завершён',10,1,10,NULL);
/*!40000 ALTER TABLE `productionprocesses` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_auto_consume_rawmaterial` AFTER UPDATE ON `productionprocesses` FOR EACH ROW BEGIN
    -- Срабатывает только когда процесс переводится в статус «Завершён»
    IF OLD.status != 'Завершён' AND NEW.status = 'Завершён' AND NEW.raw_material_id IS NOT NULL THEN
        
        UPDATE RawMaterials rm
        SET rm.quantity_kg = rm.quantity_kg - (
            SELECT COALESCE(SUM(p.quantity_kg), 0)
            FROM Products p
            WHERE p.process_id = NEW.id
        )
        WHERE rm.id = NEW.raw_material_id
          AND rm.quantity_kg >= (SELECT COALESCE(SUM(p.quantity_kg), 0) FROM Products p WHERE p.process_id = NEW.id);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-19 20:33:52
