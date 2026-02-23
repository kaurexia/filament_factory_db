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
-- Dumping routines for database 'filament_factory'
--
/*!50003 DROP FUNCTION IF EXISTS `days_until_rawmaterial_runs_out` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `days_until_rawmaterial_runs_out`(raw_id INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Сколько дней осталось до полного расхода партии сырья при текущей средней скорости'
BEGIN
    DECLARE remaining_kg     DECIMAL(10,3) DEFAULT 0;
    DECLARE avg_daily_usage  DECIMAL(10,3) DEFAULT 0;
    DECLARE days_left        INT           DEFAULT 0;

    -- Сколько кг осталось от этой приёмки
    SELECT quantity_kg - COALESCE((
        SELECT SUM(p.quantity_kg)
        FROM Products p
        JOIN ProductionProcesses pp ON p.process_id = pp.id
        WHERE pp.raw_material_id = raw_id
    ), 0) INTO remaining_kg
    FROM RawMaterials
    WHERE id = raw_id;

    IF remaining_kg <= 0 THEN
        RETURN 0;  -- уже закончилось
    END IF;

    -- Средний расход этого типа материала за последние 30 дней (кг в день)
    SELECT COALESCE(AVG(daily_usage), 0) INTO avg_daily_usage
    FROM (
        SELECT 
            DATE(pp.start_time) AS proc_date,
            SUM(p.quantity_kg) AS daily_usage
        FROM ProductionProcesses pp
        JOIN Products p ON p.process_id = pp.id
        JOIN RawMaterials rm ON pp.raw_material_id = rm.id
        WHERE rm.material_type_id = (SELECT material_type_id FROM RawMaterials WHERE id = raw_id)
          AND pp.start_time >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
        GROUP BY proc_date
    ) daily;

    IF avg_daily_usage <= 0.1 THEN
        RETURN 999;  -- почти не расходуется → "очень долго"
    END IF;

    SET days_left = CEIL(remaining_kg / avg_daily_usage);

    RETURN days_left;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `quality_passed` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `quality_passed`(product_id INT) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'TRUE = все тесты пройдены, FALSE = есть брак'
BEGIN
    DECLARE failed INT DEFAULT 0;
    
    SELECT COUNT(*) INTO failed
    FROM QualityControls
    WHERE product_id = product_id AND passed = FALSE;
    
    RETURN (failed = 0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `rawmaterial_used_kg` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `rawmaterial_used_kg`(raw_id INT) RETURNS decimal(10,3)
    READS SQL DATA
    DETERMINISTIC
    COMMENT 'Сколько кг из партии сырья уже переработано в готовый филамент'
BEGIN
    DECLARE used DECIMAL(10,3) DEFAULT 0.000;
    
    SELECT COALESCE(SUM(p.quantity_kg), 0) INTO used
    FROM Products p
    JOIN ProductionProcesses pp ON p.process_id = pp.id
    WHERE pp.raw_material_id = raw_id;
    
    RETURN used;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `finish_production_process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `finish_production_process`(
    IN p_process_id INT,
    IN p_product_type VARCHAR(100),
    IN p_color_id INT,
    IN p_diameter_id INT,
    IN p_quantity_kg DECIMAL(10,3),
    IN p_batch_number VARCHAR(100)
)
BEGIN
    -- Завершаем процесс
    UPDATE ProductionProcesses
    SET status = 'Завершён',
        end_time = NOW()
    WHERE id = p_process_id;

    -- Создаём продукт
    INSERT INTO Products (
        product_type,
        color_id,
        diameter_id,
        quantity_kg,
        production_date,
        process_id,
        batch_number
    )
    VALUES (
        p_product_type,
        p_color_id,
        p_diameter_id,
        p_quantity_kg,
        CURDATE(),
        p_process_id,
        p_batch_number
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pack_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pack_product`(
    IN p_product_id INT,
    IN p_package_type_id INT,
    IN p_quantity INT,
    IN p_employee_id INT,
    IN p_notes TEXT
)
BEGIN
    IF quality_passed(p_product_id) = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Упаковка запрещена — продукт не прошёл ОТК';
    END IF;

    INSERT INTO Packagings (
        package_type_id,
        quantity,
        packaging_date,
        product_id,
        employee_id,
        notes
    )
    VALUES (
        p_package_type_id,
        p_quantity,
        CURDATE(),
        p_product_id,
        p_employee_id,
        p_notes
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stock_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `stock_report`()
BEGIN
    SELECT
        w.location AS `Склад`,
        CONCAT(p.product_type, ' ', COALESCE(c.name, '—'), ' ', COALESCE(d.diameter_mm, 0), 'мм') AS `Товар`,
        p.batch_number AS `Партия`,
        ROUND(ws.quantity_kg, 3) AS `Остаток, кг`,
        ROUND(ws.quantity_kg * COALESCE(rm.price_total / NULLIF(rm.quantity_kg, 0), 0), 2) AS `Себестоимость, руб`,
        ROUND(ws.quantity_kg * 1800, 2) AS `Рыночная цена, руб`
    FROM WarehouseStock ws
    JOIN Warehouses w ON ws.warehouse_id = w.id
    JOIN Products p ON ws.product_id = p.id
    LEFT JOIN ProductColors c ON p.color_id = c.id
    LEFT JOIN FilamentDiameters d ON p.diameter_id = d.id
    LEFT JOIN ProductionProcesses pp ON p.process_id = pp.id
    LEFT JOIN RawMaterials rm ON pp.raw_material_id = rm.id
    WHERE ws.quantity_kg > 0
    ORDER BY w.location, ws.quantity_kg DESC;
END ;;
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

-- Dump completed on 2025-12-19 20:33:56
