-- MySQL dump 10.13  Distrib 5.6.28, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: credit_card_ranking
-- ------------------------------------------------------
-- Server version	5.6.28-0ubuntu0.15.10.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `credit_card`
--

DROP TABLE IF EXISTS `credit_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_card` (
  `CId` int(11) NOT NULL AUTO_INCREMENT,
  `card_name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`CId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_card`
--

LOCK TABLES `credit_card` WRITE;
/*!40000 ALTER TABLE `credit_card` DISABLE KEYS */;
INSERT INTO `credit_card` VALUES (1,'Citibank Rewards Card'),(2,'ICICI Bank Coral Credit Card'),(3,'HDFC Bank Platinum plus credit card'),(4,'Axis Bank Infinite Credit Card'),(5,'SBI Gold Credit Card'),(6,'Standard Chartered Platinum Rewards Credit Card'),(7,'American Express payback credit card'),(8,'HSBC Platinum Credit card'),(9,'IndusInd Gold Credit Card'),(10,'Kotak Mahindra Essentia platinum credit card');
/*!40000 ALTER TABLE `credit_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_table`
--

DROP TABLE IF EXISTS `question_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question_table` (
  `QId` int(11) NOT NULL AUTO_INCREMENT,
  `Text` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`QId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_table`
--

LOCK TABLES `question_table` WRITE;
/*!40000 ALTER TABLE `question_table` DISABLE KEYS */;
INSERT INTO `question_table` VALUES (1,'Is your age less than 25?'),(2,'Do you want your credit card to have some minimum transaction balance required per month?'),(3,'Do you want to pay any joining fee for Credit Card?'),(4,'Do you want to use your credit card for daily purpose i.e paying electricity bills,fuel, buying groceries etc?'),(5,'Do you want to use your credit card for shopping/travelling/movie tickets etc?');
/*!40000 ALTER TABLE `question_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions_for_credit_cards`
--

DROP TABLE IF EXISTS `questions_for_credit_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questions_for_credit_cards` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `QuesNo` int(11) NOT NULL,
  `CardNo` int(11) NOT NULL,
  `Points` int(11) NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `card_quest_combination` (`CardNo`,`QuesNo`),
  KEY `QuesNo` (`QuesNo`),
  CONSTRAINT `questions_for_credit_cards_ibfk_1` FOREIGN KEY (`CardNo`) REFERENCES `credit_card` (`CId`),
  CONSTRAINT `questions_for_credit_cards_ibfk_2` FOREIGN KEY (`QuesNo`) REFERENCES `question_table` (`QId`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions_for_credit_cards`
--

LOCK TABLES `questions_for_credit_cards` WRITE;
/*!40000 ALTER TABLE `questions_for_credit_cards` DISABLE KEYS */;
INSERT INTO `questions_for_credit_cards` VALUES (1,1,5,10),(2,1,3,9),(3,1,4,8),(4,1,1,7),(5,1,7,6),(6,1,8,5),(7,1,9,4),(8,1,6,3),(9,1,10,2),(10,1,2,1),(11,2,5,10),(12,2,3,9),(13,2,7,8),(14,2,8,7),(15,2,9,6),(16,2,6,5),(17,2,10,4),(18,2,4,3),(19,2,1,2),(20,2,2,1),(21,3,4,10),(22,3,1,9),(23,3,3,8),(24,3,7,7),(25,3,8,6),(26,3,9,5),(27,3,5,4),(28,3,6,3),(29,3,2,2),(30,3,10,1),(31,4,2,10),(32,4,5,9),(33,4,4,8),(34,4,1,7),(35,4,3,6),(36,4,7,5),(37,4,8,4),(38,4,6,3),(39,4,9,2),(40,4,10,1),(41,5,10,10),(42,5,1,9),(43,5,4,8),(44,5,5,7),(45,5,7,6),(46,5,2,5),(47,5,6,4),(48,5,8,3),(49,5,9,2),(50,5,3,1);
/*!40000 ALTER TABLE `questions_for_credit_cards` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-07-09 11:10:38
