-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: lms
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
  `ADMIN_NO` char(8) NOT NULL,
  `ADMIN_PSW` varchar(18) DEFAULT NULL,
  `ADMIN_NAME` varchar(50) DEFAULT NULL,
  `ADMIN_TEL` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`ADMIN_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('00000001','admin','admin','12345678910'),('008','zjh','admin_zjh','12345678910'),('110','ahc','admin_ahc','12345678910'),('213','wpd','admin_wpd','12345678910'),('251','ckp','admin_ckp','12345678910'),('9251','admin','admin','12345678910');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blacklist`
--

DROP TABLE IF EXISTS `blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blacklist` (
  `BLACKLIST_NO` int NOT NULL AUTO_INCREMENT,
  `READER_NO` char(10) DEFAULT NULL,
  `BLACKLIST_REASON` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`BLACKLIST_NO`),
  KEY `READER_NO` (`READER_NO`),
  CONSTRAINT `blacklist_ibfk_1` FOREIGN KEY (`READER_NO`) REFERENCES `reader` (`READER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blacklist`
--

LOCK TABLES `blacklist` WRITE;
/*!40000 ALTER TABLE `blacklist` DISABLE KEYS */;
INSERT INTO `blacklist` VALUES (6,'251','????????????'),(7,'008','???????????????'),(8,'008','???????????????'),(9,'251','???????????????');
/*!40000 ALTER TABLE `blacklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `BOOK_NO` char(12) NOT NULL,
  `BOOK_NAME` varchar(50) DEFAULT NULL,
  `BOOK_IMAGE` varchar(100) DEFAULT NULL,
  `BOOK_AUTHOR` varchar(50) DEFAULT NULL,
  `BOOK_PRESS` varchar(50) DEFAULT NULL,
  `BOOK_COUNT` int DEFAULT NULL,
  `BOOK_CLASS` varchar(50) DEFAULT NULL,
  `BOOK_PRICE` double DEFAULT NULL,
  `BOOK_POSITION` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`BOOK_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES ('9251','che','welcome.jpg','????????????','?????????????????????',4,'???????????????',49.9,'A-B-01'),('9674020124','??????????????????????????????','??????????????????????????????.jpg','?????? ','??????????????? ',15,'?????????',0,'A-B-C'),('9677020124','??????','??????.jpg','?????????','???????????????',8,'?????????',0,'A-B-C'),('9677020125','????????????','????????????.jpg','?????????','???????????????????????????',10,'?????????',0,'A-B-C'),('9677020126','????????????????????????','????????????????????????.jpg','??????','??????????????????????????????????',10,'?????????',0,'A-B-C'),('9677020127','?????????','?????????.jpg','?????????','&#160;?????????????????????',15,'?????????',0,'A-B-C'),('9677020128','????????????','????????????.jpg','?????????&#160;/&#160;?????????','????????????',15,'?????????',0,'A-B-C'),('9677020226','????????????','????????????.jpg','<?????????>?????????','?????????????????????',10,'?????????',0,'A-B-C'),('9677020726','????????????????????????','????????????????????????.jpg','?????????','??????????????????????????????????',10,'?????????',0,'A-B-C'),('9687020024','????????????','????????????.jpg','J.R.R.?????????','?????????????????????',5,'?????????',0,'A-B-C'),('9687020124','???????????????','???????????????.jpg','?????????????????','???????????????',4,'?????????',0,'A-B-C'),('9757020023','????????????','????????????.jpg','[??????] ??????????????','?????????????????????',10,'?????????',0,'A-B-C'),('9757020024','?????????','?????????.jpg','?????????','???????????????',10,'?????????',0,'A-B-C'),('9777020015','??????','??????.jpg','?????????','???????????????',15,'?????????',0,'A-B-C'),('9777020016','??????????????????','??????????????????.jpg','?????????','&#160;?????????????????????',13,'?????????',0,'A-B-C'),('9777020023','????????????','????????????.jpg','????????????','???????????????????????????',5,'?????????',0,''),('9787020023','????????????','????????????.jpg','[??????] ???????????????????????','?????????????????????',10,'?????????',0,'A-B-C'),('9787020024','?????????X?????????','?????????.jpg','????????????','??????????????????',1,'?????????',0,'A-B-C'),('9787030023','???????????????','???????????????.jpg','[???] ?????????????????','???????????????????????????',10,'?????????',0,'A-B-C'),('9787030523','??????','??????.jpg','?????????','????????????',10,'?????????',0,'A-B-C'),('9787050023','???????????????','???????????????.jpg','?????????????????','??????????????????',10,'?????????',0,'A-B-C'),('9787101085','????????????','????????????.jpg','?????????','????????????',10,'?????????',0,'A-B-C'),('9787108004','??????','??????.jpg','[???] ???????????J. ????????? ','???????????????',10,'?????????',0,'A-B-C'),('9787108005','???????????????','???????????????.jpg','????????????','??????????????????',10,'?????????',0,'A-B-C'),('9787108006','??????????????????','??????????????????.jpg','?????????','?????????????????????',10,'?????????',0,'A-B-C'),('9787111135','?????????????????????????????????','?????????????????????????????????.jpg','[???] Harold Abelson','?????????????????????',10,'????????????',0,'A-B-C'),('9787111213','Java????????????','Java????????????.jpg','[???] Bruce Eckel','?????????????????????',10,'????????????',0,'A-B-C'),('9787111214','?????????????????????','??????.jpg','?????????','?????????????????????',10,'?????????',0,'A-B-C'),('9787111321','???????????????????????????','???????????????????????????.jpg','[???] Randal E.Bryant','?????????????????????',15,'????????????',0,'A-B-C'),('9787111322','???????????????????????????','???????????????????????????.jpg','?????????','?????????????????????',10,'?????????',0,'A-B-C'),('9787111504','????????????????????????','????????????????????????.jpg','?????? L.????????? (John L.Hennessy)','?????????????????????',10,'????????????',0,'A-B-C'),('9787111521','????????????','????????????.jpg','[?????????] ????????????????????','???????????????',15,'?????????',0,'A-B-C'),('978711159','???????????????????????????????????????','???????????????????????????????????????.jpg','James F. Kurose','?????????????????????',4,'????????????',0,'A-B-C'),('9787118004','?????????????????????','?????????????????????.jpg','?????????????????','?????????????????????',5,'?????????',0,'A-B-C'),('9787300113','???????????????','???????????????.jpg','[???] ???????????(Jane B. Burka)','???????????????????????????',10,'?????????',0,'A-B-C'),('9787302310','????????????Javaweb????????????','????????????Javaweb????????????.jpg','?????????','?????????????????????',10,'????????????',0,'A-B-C'),('9787302400','Javaweb????????????','Javaweb????????????.jpg','[??????] ?????????','?????????????????????',10,'????????????',0,'A-B-C'),('9787501162','?????????????????????','?????????????????????.jpg','[?????????] ????????????????????','???????????????',10,'?????????',0,'A-B-C'),('9787532167','????????','????????.jpg','[???] ????????????????????','?????????????????????',10,'?????????',0,'A-B-C'),('9787801053','????????????','????????????.jpg','[?????????] ??????????????????????????','????????????????????????',10,'?????????',0,'A-B-C'),('9788020023','???????????????','???????????????.jpg','[???] ????????????????????','?????????????????????',10,'?????????',0,'A-B-C');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrow`
--

DROP TABLE IF EXISTS `borrow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrow` (
  `BORROW_NO` int NOT NULL AUTO_INCREMENT,
  `BOOK_NO` char(12) DEFAULT NULL,
  `READER_NO` char(10) DEFAULT NULL,
  `BORROW_DATE` datetime DEFAULT NULL,
  `EXPECTRETURN_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`BORROW_NO`),
  KEY `BOOK_NO` (`BOOK_NO`),
  KEY `READER_NO` (`READER_NO`),
  CONSTRAINT `borrow_ibfk_1` FOREIGN KEY (`BOOK_NO`) REFERENCES `book` (`BOOK_NO`),
  CONSTRAINT `borrow_ibfk_2` FOREIGN KEY (`READER_NO`) REFERENCES `reader` (`READER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrow`
--

LOCK TABLES `borrow` WRITE;
/*!40000 ALTER TABLE `borrow` DISABLE KEYS */;
INSERT INTO `borrow` VALUES (8,'9251','251','2021-06-10 00:00:00','2021-07-10 00:00:00'),(9,'9251','251','2021-06-10 00:00:00','2021-07-10 00:00:00');
/*!40000 ALTER TABLE `borrow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fineticket`
--

DROP TABLE IF EXISTS `fineticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fineticket` (
  `FINETICKET_NO` int NOT NULL AUTO_INCREMENT,
  `READER_NO` char(10) DEFAULT NULL,
  `FINETICKET_DATE` datetime DEFAULT NULL,
  `FINETICKET_MONEY` double DEFAULT NULL,
  PRIMARY KEY (`FINETICKET_NO`),
  KEY `READER_NO` (`READER_NO`),
  CONSTRAINT `fineticket_ibfk_1` FOREIGN KEY (`READER_NO`) REFERENCES `reader` (`READER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fineticket`
--

LOCK TABLES `fineticket` WRITE;
/*!40000 ALTER TABLE `fineticket` DISABLE KEYS */;
INSERT INTO `fineticket` VALUES (6,'008','2021-07-11 00:00:00',9.99),(7,'251','2021-07-11 00:00:00',9.99);
/*!40000 ALTER TABLE `fineticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `godownentry`
--

DROP TABLE IF EXISTS `godownentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `godownentry` (
  `GODOWNENTRY_NO` int NOT NULL AUTO_INCREMENT,
  `BOOK_NO` char(12) DEFAULT NULL,
  `GODOWNENTRY_DATE` datetime DEFAULT NULL,
  `GODOWNENTRY_COUNT` int DEFAULT NULL,
  PRIMARY KEY (`GODOWNENTRY_NO`),
  KEY `BOOK_NO` (`BOOK_NO`),
  CONSTRAINT `godownentry_ibfk_1` FOREIGN KEY (`BOOK_NO`) REFERENCES `book` (`BOOK_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `godownentry`
--

LOCK TABLES `godownentry` WRITE;
/*!40000 ALTER TABLE `godownentry` DISABLE KEYS */;
INSERT INTO `godownentry` VALUES (11,'9251','2021-06-01 00:00:00',15),(12,'9251','2021-06-01 00:00:00',15);
/*!40000 ALTER TABLE `godownentry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reader`
--

DROP TABLE IF EXISTS `reader`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reader` (
  `READER_NO` char(10) NOT NULL,
  `READER_NAME` varchar(50) DEFAULT NULL,
  `READER_IMAGE` varchar(100) DEFAULT NULL,
  `READER_TEL` varchar(11) DEFAULT NULL,
  `READER_PSW` varchar(18) DEFAULT NULL,
  `READER_SEX` char(2) DEFAULT NULL,
  PRIMARY KEY (`READER_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reader`
--

LOCK TABLES `reader` WRITE;
/*!40000 ALTER TABLE `reader` DISABLE KEYS */;
INSERT INTO `reader` VALUES ('008','zjh','default.jpg','12345678910','123456','???'),('1000000001','??????1','default.jpg','12345678910','123456','???'),('1000000002','??????2','default.jpg','12345678910','123456','???'),('1000000003','??????3','default.jpg','12345678910','123456','???'),('1000000004','??????4','default.jpg','12345678910','123456','???'),('1000000005','??????5','default.jpg','12345678910','123456','???'),('1000000006','??????6','default.jpg','12345678910','123456','???'),('1000000007','??????7','default.jpg','12345678910','123456','???'),('1000000008','??????8','default.jpg','12345678910','123456','???'),('1000000009','??????9','default.jpg','12345678910','123456','???'),('1000000010','??????10','default.jpg','12345678910','123456','???'),('1000000011','??????11','default.jpg','12345678910','123456','???'),('1000000012','??????1','default.jpg','12345678910','123456','???'),('110','ahc','default.jpg','12345678910','123456','???'),('213','wpd','default.jpg','12345678910','123456','???'),('251','che','default.jpg','12345678910','123456','???'),('999','?????????','c3e89d37ccf74ab4e21180b639839eff.jpeg','999','999','???');
/*!40000 ALTER TABLE `reader` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `readercredit`
--

DROP TABLE IF EXISTS `readercredit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `readercredit` (
  `readercredit_NO` int NOT NULL AUTO_INCREMENT,
  `READER_NO` char(10) DEFAULT NULL,
  `READER_CREDIT` char(2) DEFAULT NULL,
  `ISRETURNBOOK` char(2) DEFAULT NULL,
  PRIMARY KEY (`readercredit_NO`),
  KEY `READER_NO` (`READER_NO`),
  CONSTRAINT `readercredit_ibfk_1` FOREIGN KEY (`READER_NO`) REFERENCES `reader` (`READER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `readercredit`
--

LOCK TABLES `readercredit` WRITE;
/*!40000 ALTER TABLE `readercredit` DISABLE KEYS */;
INSERT INTO `readercredit` VALUES (6,'999','1','??????'),(7,'1000000001','1','??????'),(8,'1000000002','1','??????'),(9,'1000000003','1','??????'),(10,'1000000004','1','??????'),(11,'251','1','???');
/*!40000 ALTER TABLE `readercredit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `returnbook`
--

DROP TABLE IF EXISTS `returnbook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `returnbook` (
  `RETURN_NO` int NOT NULL AUTO_INCREMENT,
  `BOOK_NO` char(12) DEFAULT NULL,
  `READER_NO` char(10) DEFAULT NULL,
  `RETURN_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`RETURN_NO`),
  KEY `BOOK_NO` (`BOOK_NO`),
  KEY `READER_NO` (`READER_NO`),
  CONSTRAINT `returnbook_ibfk_1` FOREIGN KEY (`BOOK_NO`) REFERENCES `book` (`BOOK_NO`),
  CONSTRAINT `returnbook_ibfk_2` FOREIGN KEY (`READER_NO`) REFERENCES `reader` (`READER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `returnbook`
--

LOCK TABLES `returnbook` WRITE;
/*!40000 ALTER TABLE `returnbook` DISABLE KEYS */;
INSERT INTO `returnbook` VALUES (6,'9251','251','2021-07-09 00:00:00');
/*!40000 ALTER TABLE `returnbook` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-09 19:14:34
