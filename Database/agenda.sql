-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: agenda
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `camisetas`
--

DROP TABLE IF EXISTS `camisetas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `camisetas` (
  `idcamiseta` int NOT NULL AUTO_INCREMENT,
  `talla` enum('XS','S','M','L','XL') NOT NULL,
  `color` varchar(30) NOT NULL,
  `estado_disponibilidad` enum('disponible','no disponible') NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `estampa_id` int DEFAULT NULL,
  `stock` int NOT NULL,
  PRIMARY KEY (`idcamiseta`),
  KEY `estampa_id` (`estampa_id`),
  CONSTRAINT `camisetas_ibfk_1` FOREIGN KEY (`estampa_id`) REFERENCES `estampas` (`idestampa`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `camisetas`
--

LOCK TABLES `camisetas` WRITE;
/*!40000 ALTER TABLE `camisetas` DISABLE KEYS */;
INSERT INTO `camisetas` VALUES (1,'M','azul','disponible',60000.00,NULL,0),(2,'S','rojo','disponible',70000.00,NULL,75),(3,'XL','verde','disponible',20000.00,NULL,65),(4,'M','azul','disponible',9000.00,NULL,53),(5,'M','Rojo','disponible',20.00,NULL,45),(6,'M','Rojo','disponible',20.00,NULL,45),(7,'M','Rojo','disponible',20.00,NULL,50),(8,'M','Rojo','disponible',20.00,NULL,42),(9,'M','Rojo','disponible',20.00,NULL,50),(10,'M','Rojo','disponible',20.00,NULL,50),(12,'XL','Rojo','disponible',35000.00,25,15),(13,'M','Rojo','disponible',35000.00,NULL,15);
/*!40000 ALTER TABLE `camisetas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizar_estado_camisetas` BEFORE UPDATE ON `camisetas` FOR EACH ROW BEGIN
    IF NEW.stock = 0 THEN
        SET NEW.estado_disponibilidad = 'no disponible';
    ELSE
        SET NEW.estado_disponibilidad = 'disponible';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `estampas`
--

DROP TABLE IF EXISTS `estampas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estampas` (
  `idestampa` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `caracteristicas` varchar(255) NOT NULL,
  `imagen` varchar(45) NOT NULL,
  `estado` enum('disponible','no disponible') NOT NULL,
  `tarifa` decimal(10,2) DEFAULT NULL,
  `stock` int DEFAULT NULL,
  PRIMARY KEY (`idestampa`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estampas`
--

LOCK TABLES `estampas` WRITE;
/*!40000 ALTER TABLE `estampas` DISABLE KEYS */;
INSERT INTO `estampas` VALUES (15,'luz','una luz al amanecer','kjfhjsdjfjsd','disponible',25.50,66),(16,'Estampa A','Caracteristicas A','imagenA.jpg','disponible',5.00,4),(17,'Estampa B','Caracteristicas B','imagenB.jpg','disponible',6.00,9),(18,'Estampa A','Caracteristicas A','imagenA.jpg','disponible',5.00,7),(19,'Estampa B','Caracteristicas B','imagenB.jpg','disponible',6.00,11),(20,'Estampa A','Caracteristicas A','imagenA.jpg','disponible',5.00,8),(21,'Estampa B','Caracteristicas B','imagenB.jpg','disponible',6.00,15),(22,'Estampa A','Caracteristicas A','imagenA.jpg','disponible',5.00,2),(23,'Estampa B','Caracteristicas B','imagenB.jpg','disponible',6.00,12),(24,'Estampa A','Caracteristicas A','imagenA.jpg','disponible',5.00,8),(25,'Estampa B','Caracteristicas B','imagenB.jpg','disponible',6.00,10),(26,'Estampa A','Caracteristicas A','imagenA.jpg','disponible',5.00,10),(27,'Estampa B','Caracteristicas B','imagenB.jpg','disponible',6.00,11),(28,'Estampa A','Caracteristicas A','imagenA.jpg','disponible',5.00,15),(29,'Estampa B','Caracteristicas B','imagenB.jpg','disponible',6.00,5),(30,'Estampa perrito','Característica 1','imagen1.jpg','disponible',10000.00,10),(31,'Estampa pajarito','Característica 2','imagen2.jpg','disponible',10000.00,10),(32,'Estampa gatico','Característica 3','imagen3.jpg','disponible',10000.00,10),(33,'Estampa bebe','Característica 4','imagen4.jpg','disponible',10000.00,10),(34,'Estampa amor','Característica 5','imagen5.jpg','disponible',10000.00,10),(36,'Estampa 28 - 7','Característica 7','imagen7.jpg','disponible',10000.00,10),(37,'Estampa 28 - 8','Característica 8','imagen8.jpg','disponible',10000.00,10),(38,'Estampa 28 - 9','Característica 9','imagen9.jpg','disponible',10000.00,10),(39,'Estampa 28 - 10','Característica 10','imagen10.jpg','disponible',10000.00,10),(41,'Estampa 29 - 2','Característica 2','imagen2.jpg','disponible',15000.00,10),(42,'Estampa 29 - 3','Característica 3','imagen3.jpg','disponible',15000.00,10),(43,'Estampa 29 - 4','Característica 4','imagen4.jpg','disponible',15000.00,10),(44,'Estampa 29 - 5','Característica 5','imagen5.jpg','disponible',15000.00,10),(45,'Estampa 29 - 6','Característica 6','imagen6.jpg','disponible',15000.00,10),(46,'Estampa 29 - 7','Característica 7','imagen7.jpg','disponible',15000.00,10),(47,'Estampa 29 - 8','Característica 8','imagen8.jpg','disponible',15000.00,10),(48,'Estampa 29 - 9','Característica 9','imagen9.jpg','disponible',15000.00,10),(49,'Estampa 29 - 10','Característica 10','imagen10.jpg','disponible',15000.00,10);
/*!40000 ALTER TABLE `estampas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizar_estado_estampa` BEFORE UPDATE ON `estampas` FOR EACH ROW BEGIN
    IF NEW.stock = 0 THEN
        SET NEW.estado = 'no disponible';
    ELSE
        SET NEW.estado = 'disponible';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factura` (
  `idfactura` int NOT NULL AUTO_INCREMENT,
  `idventa` int NOT NULL,
  `nombre_usuario` varchar(100) NOT NULL,
  `num_documento` varchar(20) NOT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `total` decimal(10,2) NOT NULL,
  `cliente_id` int DEFAULT NULL,
  PRIMARY KEY (`idfactura`),
  KEY `idventa` (`idventa`),
  KEY `fk_cliente` (`cliente_id`),
  CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`idventa`) REFERENCES `ventas` (`idventa`),
  CONSTRAINT `fk_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `usuarios` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura`
--

LOCK TABLES `factura` WRITE;
/*!40000 ALTER TABLE `factura` DISABLE KEYS */;
INSERT INTO `factura` VALUES (1,18,'Juan','123456789','2024-10-08 13:51:45',185005.00,7),(2,23,'Juan','123456789','2024-10-08 14:06:38',185005.00,7),(3,24,'Juan','123456789','2024-10-08 14:09:07',185005.00,7),(4,25,'Juan','123456789','2024-10-08 14:09:08',185096.00,7),(5,38,'María','789456123','2024-10-08 20:20:04',140000.00,10),(6,40,'Luis','456123789','2024-10-08 20:29:55',80184.00,9);
/*!40000 ALTER TABLE `factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persona` (
  `idpersona` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `num_documento` varchar(45) NOT NULL,
  PRIMARY KEY (`idpersona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (1,'hugo ','hernandez','hugo@gmail.com','287267262'),(9,'maria','Péreira','maria@example.com','123645678'),(18,'alejandra laura','rodriguez quiroga','alejandra@hormail','83735353');
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sistema_monitor`
--

DROP TABLE IF EXISTS `sistema_monitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sistema_monitor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `cpu_usage` decimal(5,2) DEFAULT NULL,
  `memory_usage` decimal(5,2) DEFAULT NULL,
  `errores` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sistema_monitor`
--

LOCK TABLES `sistema_monitor` WRITE;
/*!40000 ALTER TABLE `sistema_monitor` DISABLE KEYS */;
INSERT INTO `sistema_monitor` VALUES (1,'2024-09-29 22:00:05',14.10,88.80,'Alerta: Uso alto de memoria - 88.8%\n'),(2,'2024-09-29 22:05:06',19.40,89.80,'Alerta: Uso alto de memoria - 89.8%\n'),(3,'2024-09-29 22:08:36',18.50,90.40,'Alerta: Uso alto de memoria - 90.4%\n'),(4,'2024-09-30 00:07:47',12.50,93.10,'Alerta: Uso alto de memoria - 93.1%\n'),(5,'2024-09-30 00:16:24',4.20,91.20,'Alerta: Uso alto de memoria - 91.2%\n');
/*!40000 ALTER TABLE `sistema_monitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `idusuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `num_documento` varchar(45) NOT NULL,
  `tipo` enum('artista','cliente') NOT NULL DEFAULT 'cliente',
  PRIMARY KEY (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (4,'nicolas','pardo','nico@gmail.com','1073246697','artista'),(5,'danna valentina','garcia','dana@gmail.com','345678','artista'),(7,'Juan','Pérez','juan.perez@email.com','123456789','cliente'),(8,'Ana','Gómez','ana.gomez@email.com','987654321','cliente'),(9,'Luis','Martínez','luis.martinez@email.com','456123789','cliente'),(10,'María','López','maria.lopez@email.com','789456123','cliente');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `idventa` int NOT NULL AUTO_INCREMENT,
  `camiseta_id` int DEFAULT NULL,
  `idestampa_frontal` int DEFAULT NULL,
  `idestampa_trasera` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total` decimal(10,2) DEFAULT NULL,
  `cliente_id` int DEFAULT NULL,
  `factura_id` int DEFAULT NULL,
  PRIMARY KEY (`idventa`),
  KEY `idcamiseta` (`camiseta_id`),
  KEY `idestampa_frontal` (`idestampa_frontal`),
  KEY `idestampa_trasera` (`idestampa_trasera`),
  KEY `fk_cliente_id` (`cliente_id`),
  KEY `fk_factura` (`factura_id`),
  CONSTRAINT `fk_cliente_id` FOREIGN KEY (`cliente_id`) REFERENCES `usuarios` (`idusuario`),
  CONSTRAINT `fk_factura` FOREIGN KEY (`factura_id`) REFERENCES `factura` (`idfactura`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`camiseta_id`) REFERENCES `camisetas` (`idcamiseta`),
  CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`idestampa_frontal`) REFERENCES `estampas` (`idestampa`),
  CONSTRAINT `ventas_ibfk_3` FOREIGN KEY (`idestampa_trasera`) REFERENCES `estampas` (`idestampa`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (2,1,16,18,NULL,'2024-09-30 03:17:34',60010.00,NULL,NULL),(3,8,27,NULL,NULL,'2024-09-30 03:22:48',26.00,NULL,NULL),(4,8,27,NULL,NULL,'2024-09-30 03:22:48',26.00,NULL,NULL),(5,8,27,NULL,NULL,'2024-09-30 03:22:48',26.00,NULL,NULL),(6,8,27,NULL,NULL,'2024-09-30 03:22:48',26.00,NULL,NULL),(7,3,28,29,NULL,'2024-09-30 22:14:18',20011.00,NULL,NULL),(8,3,28,29,NULL,'2024-09-30 22:14:18',20011.00,NULL,NULL),(9,3,29,NULL,NULL,'2024-10-01 21:44:47',20006.00,NULL,NULL),(10,3,29,NULL,NULL,'2024-10-01 21:44:47',20006.00,NULL,NULL),(11,3,29,NULL,NULL,'2024-10-01 21:44:47',20006.00,NULL,NULL),(12,3,29,NULL,NULL,'2024-10-01 21:44:47',20006.00,NULL,NULL),(13,3,29,NULL,NULL,'2024-10-01 21:44:47',20006.00,NULL,NULL),(14,1,29,22,8,'2024-10-06 00:55:55',480088.00,NULL,NULL),(15,2,NULL,25,3,'2024-10-06 01:35:39',210006.00,8,NULL),(16,6,15,23,3,'2024-10-06 03:30:52',5066.00,7,NULL),(17,4,16,NULL,4,'2024-10-06 15:57:37',36005.00,8,NULL),(18,1,15,16,3,'2024-10-08 18:51:45',185005.00,7,1),(19,1,15,16,3,'2024-10-08 18:51:47',185005.00,7,NULL),(20,1,15,16,3,'2024-10-08 18:52:20',185005.00,7,NULL),(21,1,15,16,3,'2024-10-08 18:52:23',185005.00,7,NULL),(22,1,15,16,3,'2024-10-08 19:01:14',185005.00,7,NULL),(23,1,15,16,3,'2024-10-08 19:06:37',185005.00,7,2),(24,1,15,16,3,'2024-10-08 19:09:07',185005.00,7,3),(25,1,15,16,3,'2024-10-08 19:09:08',185005.00,7,4),(26,1,15,16,3,'2024-10-08 19:38:25',185005.00,7,NULL),(27,1,15,16,3,'2024-10-08 19:38:49',185005.00,7,NULL),(28,1,15,16,3,'2024-10-08 19:39:18',185005.00,7,NULL),(29,1,15,16,3,'2024-10-08 19:48:47',185005.00,7,NULL),(30,1,15,16,3,'2024-10-08 19:48:51',185005.00,7,NULL),(31,1,15,16,3,'2024-10-08 19:50:17',185005.00,7,NULL),(32,1,15,16,3,'2024-10-08 19:51:29',185005.00,7,NULL),(33,1,15,16,3,'2024-10-08 19:51:53',185005.00,7,NULL),(34,1,15,16,3,'2024-10-08 19:52:54',185005.00,7,NULL),(35,1,15,16,3,'2024-10-08 19:53:03',185005.00,7,NULL),(36,1,15,16,3,'2024-10-08 19:53:48',185005.00,7,NULL),(37,1,15,15,1,'2024-10-09 01:13:35',70000.00,10,NULL),(38,1,15,15,1,'2024-10-09 01:20:03',70000.00,10,5),(39,1,15,15,1,'2024-10-09 01:24:11',70000.00,10,5),(40,6,20,16,2,'2024-10-09 01:29:55',50.00,9,6),(41,3,18,19,2,'2024-10-09 01:32:30',40011.00,9,6),(42,8,16,17,4,'2024-10-09 01:35:26',91.00,7,4),(43,3,19,24,2,'2024-10-09 01:39:54',40011.00,9,6),(44,5,25,17,2,'2024-10-09 01:42:30',52.00,9,6),(45,5,NULL,NULL,3,'2024-10-23 19:05:28',60.00,9,6);
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_monitor`
--

DROP TABLE IF EXISTS `ventas_monitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas_monitor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `ventas_diarias` int NOT NULL,
  `ingresos_diarios` decimal(10,2) NOT NULL,
  `productos_vendidos` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_monitor`
--

LOCK TABLES `ventas_monitor` WRITE;
/*!40000 ALTER TABLE `ventas_monitor` DISABLE KEYS */;
INSERT INTO `ventas_monitor` VALUES (1,'2024-09-29',150,5000.50,200),(2,'2024-09-29',150,5000.50,200),(3,'2024-09-29',150,5000.50,200),(4,'2024-09-29',150,5000.50,200),(5,'2024-09-29',150,5000.50,200);
/*!40000 ALTER TABLE `ventas_monitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventascalificaciones`
--

DROP TABLE IF EXISTS `ventascalificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventascalificaciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idestampa` int DEFAULT NULL,
  `ventas` int DEFAULT '0',
  `calificacion` decimal(3,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ventascalificaciones_ibfk_1` (`idestampa`),
  CONSTRAINT `ventascalificaciones_ibfk_1` FOREIGN KEY (`idestampa`) REFERENCES `estampas` (`idestampa`),
  CONSTRAINT `ventascalificaciones_chk_1` CHECK (((`calificacion` >= 0) and (`calificacion` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventascalificaciones`
--

LOCK TABLES `ventascalificaciones` WRITE;
/*!40000 ALTER TABLE `ventascalificaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `ventascalificaciones` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-23 14:48:45
