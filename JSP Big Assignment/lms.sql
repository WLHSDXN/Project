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
INSERT INTO `blacklist` VALUES (6,'251','没有原因'),(7,'008','页面打不开'),(8,'008','未按时还书'),(9,'251','未按时还书');
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
INSERT INTO `book` VALUES ('9251','che','welcome.jpg','清华大学','清华大学出版社',4,'计算机教材',49.9,'A-B-01'),('9674020124','刘擎西方现代思想讲义','刘擎西方现代思想讲义.jpg','刘擎 ','新星出版社 ',15,'哲学类',0,'A-B-C'),('9677020124','三体','三体.jpg','刘慈欣','重庆出版社',8,'科幻类',0,'A-B-C'),('9677020125','孤独深处','孤独深处.jpg','郝景芳','江苏凤凰文艺出版社',10,'科幻类',0,'A-B-C'),('9677020126','中国历代政治得失','中国古代政治得失.jpg','钱穆','生活·读书·新知三联书店',10,'国学类',0,'A-B-C'),('9677020127','道德经','道德经.jpg','黄元吉','&#160;陕西人民出版社',15,'国学类',0,'A-B-C'),('9677020128','古文观止','古文观止.jpg','吴楚材&#160;/&#160;吴调侯','中华书局',15,'国学类',0,'A-B-C'),('9677020226','世说新语','世说新语.jpg','<南朝宋>刘义庆','山西古籍出版社',10,'国学类',0,'A-B-C'),('9677020726','中国古代思想史论','中国古代思想史论.jpg','李泽厚','生活·读书·新知三联书店',10,'国学类',0,'A-B-C'),('9687020024','霍比特人','霍比特人.jpg','J.R.R.托尔金','上海人民出版社',5,'科幻类',0,'A-B-C'),('9687020124','海底两万里','海底两万里.jpg','儒勒·凡尔纳','译林出版社',4,'科幻类',0,'A-B-C'),('9757020023','爱的艺术','爱的艺术.jpg','[美国] 艾·弗洛姆','上海译文出版社',10,'哲学类',0,'A-B-C'),('9757020024','理想国','理想国.jpg','柏拉图','商务印书馆',10,'哲学类',0,'A-B-C'),('9777020015','鲸歌','鲸歌.jpg','刘慈欣','大连出版社',15,'科幻类',0,'A-B-C'),('9777020016','中国哲学简史','中国哲学简史.jpg','冯友兰','&#160;北京大学出版社',13,'哲学类',0,'A-B-C'),('9777020023','假面山庄','假面山庄.jpg','东野圭吾','北京十月文艺出版社',5,'小说类',0,''),('9787020023','我的大学','我的大学.jpg','[苏联] 马克西姆·高尔基','人民文学出版社',10,'文学类',0,'A-B-C'),('9787020024','嫌疑人X的献身','嫌疑人.jpg','东野圭吾','南海出版公司',1,'小说类',0,'A-B-C'),('9787030023','时间的秩序','时间的秩序.jpg','[意] 卡洛·罗韦利','湖南科学技术出版社',10,'哲学类',0,'A-B-C'),('9787030523','史记','史记.jpg','司马迁','中华书局',10,'国学类',0,'A-B-C'),('9787050023','时间的秩序','时间的秩序.jpg','卡洛·罗韦利','企鹅兰登中国',10,'科幻类',0,'A-B-C'),('9787101085','人间词话','人间词话.jpg','王国维','中华书局',10,'国学类',0,'A-B-C'),('9787108004','宽容','宽容.jpg','[美] 莫提默·J. 艾德勒 ','商务印书馆',10,'文学类',0,'A-B-C'),('9787108005','解忧杂货店','解忧杂货店.jpg','东野圭吾','南海出版公司',10,'小说类',0,'A-B-C'),('9787108006','悲伤逆流成河','悲伤逆流成河.jpg','郭敬明','长江文艺出版社',10,'小说类',0,'A-B-C'),('9787111135','计算机程序的构造和解释','计算机程序的构造和解释.jpg','[美] Harold Abelson','机械工业出版社',10,'计算机类',0,'A-B-C'),('9787111213','Java编程思想','Java编程思想.jpg','[美] Bruce Eckel','机械工业出版社',10,'计算机类',0,'A-B-C'),('9787111214','云边有个小卖部','云边.jpg','张嘉佳','湖南文艺出版社',10,'小说类',0,'A-B-C'),('9787111321','深入理解计算机系统','深入理解计算机系统.jpg','[美] Randal E.Bryant','机械工业出版社',15,'计算机类',0,'A-B-C'),('9787111322','我与世界只差一个你','我与世界只差一个你.jpg','张皓宸','天津人民出版社',10,'小说类',0,'A-B-C'),('9787111504','计算机组成与设计','计算机组成与设计.jpg','约翰 L.亨尼斯 (John L.Hennessy)','机械工业出版社',10,'计算机类',0,'A-B-C'),('9787111521','人类简史','人类简史.jpg','[以色列] 尤瓦尔·赫拉利','中信出版社',15,'哲学类',0,'A-B-C'),('978711159','计算机网络（自顶向下方法）','计算机网络（自顶向下方法）.jpg','James F. Kurose','机械工业出版社',4,'计算机类',0,'A-B-C'),('9787118004','十五岁的小船长','十五岁的小船长.jpg','儒勒·凡尔纳','上海百家出版社',5,'科幻类',0,'A-B-C'),('9787300113','拖延心理学','拖延心理学.jpg','[美] 简·博克(Jane B. Burka)','中国人民大学出版社',10,'文学类',0,'A-B-C'),('9787302310','深入理解Javaweb开发技术','深入理解Javaweb开发技术.jpg','谭贞军','清华大学出版社',10,'计算机类',0,'A-B-C'),('9787302400','Javaweb高级编程','Javaweb高级编程.jpg','[美国] 威廉斯','清华大学出版社',10,'计算机类',0,'A-B-C'),('9787501162','追寻生命的意义','追寻生命的意义.jpg','[奥地利] 维克多·弗兰克','新华出版社',10,'文学类',0,'A-B-C'),('9787532167','简·爱','简·爱.jpg','[英] 夏洛蒂·勃朗特','上海文艺出版社',10,'文学类',0,'A-B-C'),('9787801053','梦的解析','梦的解析.jpg','[奥地利] 西格蒙德·弗洛伊德','国际文化出版公司',10,'文学类',0,'A-B-C'),('9788020023','人生的智慧','人类的智慧.jpg','[德] 阿图尔·叔本华','上海人民出版社',10,'哲学类',0,'A-B-C');
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
INSERT INTO `reader` VALUES ('008','zjh','default.jpg','12345678910','123456','女'),('1000000001','张三1','default.jpg','12345678910','123456','男'),('1000000002','李四2','default.jpg','12345678910','123456','女'),('1000000003','王五3','default.jpg','12345678910','123456','男'),('1000000004','张三4','default.jpg','12345678910','123456','男'),('1000000005','李四5','default.jpg','12345678910','123456','女'),('1000000006','王五6','default.jpg','12345678910','123456','男'),('1000000007','张三7','default.jpg','12345678910','123456','男'),('1000000008','李四8','default.jpg','12345678910','123456','女'),('1000000009','王五9','default.jpg','12345678910','123456','男'),('1000000010','张三10','default.jpg','12345678910','123456','男'),('1000000011','李四11','default.jpg','12345678910','123456','女'),('1000000012','王五1','default.jpg','12345678910','123456','男'),('110','ahc','default.jpg','12345678910','123456','女'),('213','wpd','default.jpg','12345678910','123456','男'),('251','che','default.jpg','12345678910','123456','男'),('999','九九九','c3e89d37ccf74ab4e21180b639839eff.jpeg','999','999','女');
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
INSERT INTO `readercredit` VALUES (6,'999','1','未知'),(7,'1000000001','1','未知'),(8,'1000000002','1','未知'),(9,'1000000003','1','未知'),(10,'1000000004','1','未知'),(11,'251','1','是');
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
