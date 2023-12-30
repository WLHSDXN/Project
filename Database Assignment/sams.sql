-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: sams
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `Id` char(15) NOT NULL,
  `Password` char(30) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Id` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('101','123456');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c`
--

DROP TABLE IF EXISTS `c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c` (
  `Cno` char(4) NOT NULL,
  `Cname` char(15) DEFAULT NULL,
  `Credit` int DEFAULT NULL,
  `Term` char(8) DEFAULT NULL,
  PRIMARY KEY (`Cno`),
  UNIQUE KEY `Cno` (`Cno`),
  KEY `i_cname` (`Cname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c`
--

LOCK TABLES `c` WRITE;
/*!40000 ALTER TABLE `c` DISABLE KEYS */;
INSERT INTO `c` VALUES ('2001','数据库',3,'第二学期'),('2002','JAVA',3,'第二学期'),('2003','离散',3,'第二学期'),('2004','C语言',2,'第一学期');
/*!40000 ALTER TABLE `c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s`
--

DROP TABLE IF EXISTS `s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `s` (
  `Sno` char(8) NOT NULL,
  `Sname` char(10) DEFAULT NULL,
  `Sex` char(2) DEFAULT NULL,
  `Sdate` date DEFAULT NULL,
  `Sdept` char(15) DEFAULT NULL,
  PRIMARY KEY (`Sno`),
  UNIQUE KEY `Sno` (`Sno`),
  KEY `i_sname` (`Sname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s`
--

LOCK TABLES `s` WRITE;
/*!40000 ALTER TABLE `s` DISABLE KEYS */;
INSERT INTO `s` VALUES ('20200001','孙三','男','2000-01-01','计算机'),('20200002','姚桑','男','2001-01-01','计算机'),('20200003','冯桑','男','2001-02-01','机械'),('20200004','张桑','男','2000-10-01','机械'),('20200005','夏桑','女','2002-01-01','经管'),('20200006','任桑','女','2001-01-01','艺术'),('20200007','潘桑','男','1999-01-01','体育'),('20200008','李桑','男','2000-06-01','体育');
/*!40000 ALTER TABLE `s` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sc`
--

DROP TABLE IF EXISTS `sc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sc` (
  `Sno` char(8) DEFAULT NULL,
  `Cno` char(4) DEFAULT NULL,
  `Tno` char(6) DEFAULT NULL,
  `Grade` int DEFAULT NULL,
  KEY `Sno` (`Sno`),
  KEY `Cno` (`Cno`),
  KEY `Tno` (`Tno`),
  CONSTRAINT `sc_ibfk_1` FOREIGN KEY (`Sno`) REFERENCES `s` (`Sno`),
  CONSTRAINT `sc_ibfk_2` FOREIGN KEY (`Cno`) REFERENCES `c` (`Cno`),
  CONSTRAINT `sc_ibfk_3` FOREIGN KEY (`Tno`) REFERENCES `t` (`Tno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sc`
--

LOCK TABLES `sc` WRITE;
/*!40000 ALTER TABLE `sc` DISABLE KEYS */;
INSERT INTO `sc` VALUES ('20200001','2001','100001',90),('20200002','2001','100001',90),('20200003','2001','100001',90),('20200004','2002','100003',90),('20200005','2003','100004',90),('20200006','2004','100002',90),('20200007','2001','100001',90),('20200008','2002','100003',90);
/*!40000 ALTER TABLE `sc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t`
--

DROP TABLE IF EXISTS `t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t` (
  `Tno` char(6) NOT NULL,
  `Tname` char(10) DEFAULT NULL,
  `Sex` char(2) DEFAULT NULL,
  `Tel` char(11) DEFAULT NULL,
  PRIMARY KEY (`Tno`),
  UNIQUE KEY `Tno` (`Tno`),
  KEY `i_tname` (`Tname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t`
--

LOCK TABLES `t` WRITE;
/*!40000 ALTER TABLE `t` DISABLE KEYS */;
INSERT INTO `t` VALUES ('100001','常老师','女','17809520001'),('100002','吴老师','女','17809520002'),('100003','李老师','男','17809520003'),('100004','马老师','女','17809520004');
/*!40000 ALTER TABLE `t` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_samesdept_grade`
--

DROP TABLE IF EXISTS `v_samesdept_grade`;
/*!50001 DROP VIEW IF EXISTS `v_samesdept_grade`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_samesdept_grade` AS SELECT 
 1 AS `Sno`,
 1 AS `Cno`,
 1 AS `Tno`,
 1 AS `Grade`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_samesdept_grade`
--

/*!50001 DROP VIEW IF EXISTS `v_samesdept_grade`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_samesdept_grade` AS select `sc`.`Sno` AS `Sno`,`sc`.`Cno` AS `Cno`,`sc`.`Tno` AS `Tno`,`sc`.`Grade` AS `Grade` from `sc` where `sc`.`Sno` in (select `s`.`Sno` from `s` where (`s`.`Sdept` = '计算机')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-03 23:25:12
