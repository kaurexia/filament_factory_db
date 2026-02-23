

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Иванов Иван Иванович','Оператор экструдера','2023-01-15',1),(2,'Петров Пётр Петрович','Мастер смены','2022-06-10',1),(3,'Сидорова Анна Сергеевна','Контролёр ОТК','2024-03-01',1),(4,'Козлов Алексей Дмитриевич','Кладовщик','2023-09-20',1),(5,'Иванов И.И.','Оператор','2022-01-10',1),(6,'Петров П.П.','Мастер','2021-03-15',1),(7,'Сидорова А.С.','ОТК','2023-05-01',1),(8,'Козлов А.Д.','Кладовщик','2022-09-12',1),(9,'Смирнов М.А.','Оператор','2023-02-20',1),(10,'Васильев Н.О.','Оператор','2024-01-11',1),(11,'Орлова Е.В.','ОТК','2023-07-07',1),(12,'Зайцев Д.К.','Мастер','2020-11-25',1),(13,'Куликов Р.С.','Оператор','2021-06-18',1),(14,'Фёдорова Л.М.','Логист','2022-12-01',1);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_maintenance_date` date DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
INSERT INTO `equipment` VALUES (1,'Экструдер №1 (Artillery)','Работает','2025-11-20','2023-05-10'),(2,'Экструдер №2 (Bambu Lab X1)','Работает','2025-11-15','2024-08-01'),(3,'Сушилка сырья 200 кг','Работает','2025-10-30','2023-07-20'),(4,'Намотчик катушек автоматизированный','На ремонте','2025-11-01','2024-01-15'),(5,'Экструдер A','Работает','2025-10-01','2022-01-01'),(6,'Экструдер B','Работает','2025-09-15','2023-02-10'),(7,'Экструдер C','На ремонте','2025-08-01','2021-05-05'),(8,'Сушилка 1','Работает','2025-10-10','2022-03-03'),(9,'Сушилка 2','Работает','2025-09-01','2023-06-06'),(10,'Намотчик X','Работает','2025-10-05','2023-01-20'),(11,'Намотчик Y','Работает','2025-09-20','2024-02-14'),(12,'Экструдер D','Работает','2025-10-11','2024-04-04'),(13,'Экструдер E','Работает','2025-10-12','2024-05-05'),(14,'Линия упаковки','Работает','2025-10-15','2023-09-09');
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filamentdiameters`
--

DROP TABLE IF EXISTS `filamentdiameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `filamentdiameters` (
  `id` int NOT NULL AUTO_INCREMENT,
  `diameter_mm` decimal(4,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filamentdiameters`
--

LOCK TABLES `filamentdiameters` WRITE;
/*!40000 ALTER TABLE `filamentdiameters` DISABLE KEYS */;
INSERT INTO `filamentdiameters` VALUES (1,1.75),(2,2.85),(3,3.00),(4,1.75),(5,2.85),(6,3.00),(7,1.00),(8,2.00);
/*!40000 ALTER TABLE `filamentdiameters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packagetypes`
--

DROP TABLE IF EXISTS `packagetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `packagetypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `length_mm` int DEFAULT NULL,
  `width_mm` int DEFAULT NULL,
  `height_mm` int DEFAULT NULL,
  `max_weight_kg` decimal(8,3) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packagetypes`
--

LOCK TABLES `packagetypes` WRITE;
/*!40000 ALTER TABLE `packagetypes` DISABLE KEYS */;
INSERT INTO `packagetypes` VALUES (1,'Картонная коробка 1 кг','BOX_1KG',210,210,80,1.500,1),(2,'Картонная коробка 0.5 кг','BOX_05KG',160,160,70,0.800,1),(3,'Вакуумный пакет + силикагель','VAC_1KG',NULL,NULL,NULL,1.300,1),(4,'Пластиковая катушка без коробки','SPOOL_ONLY',NULL,NULL,NULL,1.200,1),(5,'Мастер-спул (для Bambu AMS)','MASTER_SPOOL',200,200,65,1.300,1);
/*!40000 ALTER TABLE `packagetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packagings`
--

DROP TABLE IF EXISTS `packagings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `packagings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `package_type_id` int NOT NULL,
  `quantity` int NOT NULL,
  `packaging_date` date NOT NULL,
  `product_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `package_type_id` (`package_type_id`),
  KEY `product_id` (`product_id`),
  KEY `employee_id` (`employee_id`),
  KEY `idx_packagings_date` (`packaging_date`),
  CONSTRAINT `packagings_ibfk_1` FOREIGN KEY (`package_type_id`) REFERENCES `packagetypes` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `packagings_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `packagings_ibfk_3` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packagings`
--

LOCK TABLES `packagings` WRITE;
/*!40000 ALTER TABLE `packagings` DISABLE KEYS */;
INSERT INTO `packagings` VALUES (8,1,2,'2025-12-17',1,4,'Упаковка после успешного ОТК');
/*!40000 ALTER TABLE `packagings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productcolors`
--

DROP TABLE IF EXISTS `productcolors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productcolors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hex_code` char(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productcolors`
--

LOCK TABLES `productcolors` WRITE;
/*!40000 ALTER TABLE `productcolors` DISABLE KEYS */;
INSERT INTO `productcolors` VALUES (1,'Белый','#FFFFFF'),(2,'Чёрный','#000000'),(3,'Красный','#FF0000'),(4,'Синий','#0000FF'),(5,'Зелёный','#008000'),(6,'Жёлтый','#FFFF00'),(7,'Серый','#808080'),(8,'Оранжевый','#FFA500'),(9,'Прозрачный',NULL),(10,'Серебро','#C0C0C0'),(11,'Золото','#FFD700'),(12,'Натуральный','#F5F5DC'),(13,'Белый','#FFFFFF'),(14,'Чёрный','#000000'),(15,'Красный','#FF0000'),(16,'Синий','#0000FF'),(17,'Зелёный','#008000'),(18,'Жёлтый','#FFFF00'),(19,'Серый','#808080'),(20,'Оранжевый','#FFA500'),(21,'Прозрачный',NULL),(22,'Серебро','#C0C0C0');
/*!40000 ALTER TABLE `productcolors` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `qualitycontrols`
--

DROP TABLE IF EXISTS `qualitycontrols`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qualitycontrols` (
  `id` int NOT NULL AUTO_INCREMENT,
  `test_type_id` int NOT NULL,
  `test_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `result_value` decimal(10,4) DEFAULT NULL,
  `passed` tinyint(1) NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `product_id` int NOT NULL,
  `employee_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `test_type_id` (`test_type_id`),
  KEY `employee_id` (`employee_id`),
  KEY `idx_qualitycontrols_product` (`product_id`),
  KEY `idx_qualitycontrols_date` (`test_date`),
  CONSTRAINT `qualitycontrols_ibfk_1` FOREIGN KEY (`test_type_id`) REFERENCES `qualitytesttypes` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `qualitycontrols_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `qualitycontrols_ibfk_3` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qualitycontrols`
--

LOCK TABLES `qualitycontrols` WRITE;
/*!40000 ALTER TABLE `qualitycontrols` DISABLE KEYS */;
INSERT INTO `qualitycontrols` VALUES (8,1,'2025-12-16 14:40:42',NULL,1,'Диаметр в пределах допуска',1,3);
/*!40000 ALTER TABLE `qualitycontrols` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qualitytesttypes`
--

DROP TABLE IF EXISTS `qualitytesttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qualitytesttypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qualitytesttypes`
--

LOCK TABLES `qualitytesttypes` WRITE;
/*!40000 ALTER TABLE `qualitytesttypes` DISABLE KEYS */;
INSERT INTO `qualitytesttypes` VALUES (1,'Диаметр филамента (средний)','DIAM_AVG','мм'),(2,'Овальность','OVALITY','мм'),(3,'Вес 1 метра','WEIGHT_1M','г'),(4,'Прочность на разрыв','TENSILE','МПа'),(5,'Ударная вязкость','IMPACT','кДж/м²'),(6,'Температура размягчения (Vicat)','VICAT','°C'),(7,'Влажность сырья перед сушкой','MOISTURE_IN','%'),(8,'Влажность после сушки','MOISTURE_OUT','%'),(9,'Визуальный контроль (дефекты)','VISUAL',NULL),(10,'Тест на адгезию к столу','ADHESION',NULL);
/*!40000 ALTER TABLE `qualitytesttypes` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `rawmaterialtypes`
--

DROP TABLE IF EXISTS `rawmaterialtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rawmaterialtypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rawmaterialtypes`
--

LOCK TABLES `rawmaterialtypes` WRITE;
/*!40000 ALTER TABLE `rawmaterialtypes` DISABLE KEYS */;
INSERT INTO `rawmaterialtypes` VALUES (1,'PLA','PLA','Полилактид — самый популярный филамент'),(2,'PETG','PETG','Прочный и химстойкий'),(3,'ABS','ABS','Классика, требует закрытой камеры'),(4,'TPU','TPU','Гибкий, 95A'),(5,'ASA','ASA','Как ABS, но устойчив к УФ'),(6,'PC','PC','Поликарбонат — очень прочный'),(7,'Нейлон (PA)','PA','Высокая прочность, впитывает влагу'),(8,'PLA','PLA','Полилактид'),(9,'PETG','PETG','Прочный'),(10,'ABS','ABS','Термостойкий'),(11,'TPU','TPU','Гибкий'),(12,'ASA','ASA','УФ-стойкий'),(13,'PC','PC','Поликарбонат'),(14,'PA','PA','Нейлон'),(15,'HIPS','HIPS','Поддержки'),(16,'PVA','PVA','Растворимый'),(17,'CF PLA','CFPLA','С углеволокном');
/*!40000 ALTER TABLE `rawmaterialtypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `report_type_id` int NOT NULL,
  `generated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `period_start` date DEFAULT NULL,
  `period_end` date DEFAULT NULL,
  `content` json DEFAULT NULL,
  `file_path` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generated_by_employee_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `generated_by_employee_id` (`generated_by_employee_id`),
  KEY `idx_reports_type_date` (`report_type_id`,`generated_at`),
  CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`report_type_id`) REFERENCES `reporttypes` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `reports_ibfk_2` FOREIGN KEY (`generated_by_employee_id`) REFERENCES `employees` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporttypes`
--

DROP TABLE IF EXISTS `reporttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporttypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporttypes`
--

LOCK TABLES `reporttypes` WRITE;
/*!40000 ALTER TABLE `reporttypes` DISABLE KEYS */;
INSERT INTO `reporttypes` VALUES (1,'Суточный отчёт производства','DAILY_PROD','Выпуск за сутки по типам и цветам',1,'2025-12-08 18:15:39'),(2,'Отчёт по браку','REJECT','Причины и объём брака',1,'2025-12-08 18:15:39'),(3,'Приёмка сырья','RAW_IN','Приход сырья от поставщикам',1,'2025-12-08 18:15:39'),(4,'Инвентаризация склада','INVENTORY','Остатки на складах',1,'2025-12-08 18:15:39'),(5,'Сменный рапорт','SHIFT','Отчёт по смене',1,'2025-12-08 18:15:39'),(6,'Отчёт по качеству','QUALITY','Результаты тестов за период',1,'2025-12-08 18:15:39');
/*!40000 ALTER TABLE `reporttypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_info` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (1,'BestFilament LLC','+7 (999) 123-45-67','2025-12-08 18:15:39'),(2,'BestFilament SPb','+7(812)555-66-77','2025-12-08 18:15:39'),(3,'Filamentum Russia','+7(495)111-22-33','2025-12-08 18:15:39'),(4,'3DPlast Урал','+7(343)999-88-77','2025-12-08 18:15:39'),(5,'Filament Pro','+7 900 111-11-11','2025-12-16 12:10:35'),(6,'PlastLine','+7 900 222-22-22','2025-12-16 12:10:35'),(7,'PolyTech','+7 900 333-33-33','2025-12-16 12:10:35'),(8,'RawChem','+7 900 444-44-44','2025-12-16 12:10:35'),(9,'3D Source','+7 900 555-55-55','2025-12-16 12:10:35'),(10,'PlastMaster','+7 900 666-66-66','2025-12-16 12:10:35'),(11,'NeoPlast','+7 900 777-77-77','2025-12-16 12:10:35'),(12,'TechPoly','+7 900 888-88-88','2025-12-16 12:10:35'),(13,'Global Filament','+7 900 999-99-99','2025-12-16 12:10:35'),(14,'EcoPlast','+7 900 000-00-00','2025-12-16 12:10:35');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouses`
--

DROP TABLE IF EXISTS `warehouses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `capacity_kg` decimal(12,2) DEFAULT NULL,
  `current_stock_kg` decimal(12,2) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouses`
--

LOCK TABLES `warehouses` WRITE;
/*!40000 ALTER TABLE `warehouses` DISABLE KEYS */;
INSERT INTO `warehouses` VALUES (1,'Основной склад готовой продукции',10000.00,58.00),(2,'Склад сырья',20000.00,25.00),(3,'Зона брака и карантина',1000.00,13.00),(4,'Готовая продукция',10000.00,0.00),(5,'Склад сырья',20000.00,0.00),(6,'Брак и карантин',3000.00,0.00);
/*!40000 ALTER TABLE `warehouses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehousestock`
--

DROP TABLE IF EXISTS `warehousestock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehousestock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `warehouse_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity_kg` decimal(10,3) NOT NULL,
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_product_warehouse` (`warehouse_id`,`product_id`),
  KEY `product_id` (`product_id`),
  KEY `idx_warehousestock_warehouse` (`warehouse_id`),
  CONSTRAINT `warehousestock_ibfk_1` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `warehousestock_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehousestock`
--

LOCK TABLES `warehousestock` WRITE;
/*!40000 ALTER TABLE `warehousestock` DISABLE KEYS */;
INSERT INTO `warehousestock` VALUES (32,1,2,10.000,'2025-12-16 12:10:35'),(33,1,3,8.000,'2025-12-16 12:10:35'),(34,1,4,7.000,'2025-12-16 12:10:35'),(35,1,5,6.000,'2025-12-16 12:10:35'),(36,1,6,9.000,'2025-12-16 12:10:35'),(37,1,7,8.000,'2025-12-16 12:10:35'),(38,3,8,6.000,'2025-12-16 12:10:35'),(39,3,9,7.000,'2025-12-16 12:10:35'),(40,1,10,10.000,'2025-12-16 12:10:35'),(42,2,2,25.000,'2025-12-16 12:48:51');
/*!40000 ALTER TABLE `warehousestock` ENABLE KEYS */;
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

-- Dump completed on 2025-12-18 17:49:03
