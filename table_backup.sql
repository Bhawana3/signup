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
  `image` varchar(200) NOT NULL,
  `detail` varchar(500) NOT NULL,
  PRIMARY KEY (`CId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_card`
--

LOCK TABLES `credit_card` WRITE;
/*!40000 ALTER TABLE `credit_card` DISABLE KEYS */;
INSERT INTO `credit_card` VALUES (1,'Citibank Rewards Card','images/citi.png','Cardholders can earn 10 reward points upon spending Rs.125 at 50 plus partner stores.Customers can earn reward points at the rate of 1 point for every Rs.125 on all other purchases.Reward points can be redeemed at over 700 outlets and e-shopping partners.Upon card activation, cardholders can get 2,500 points.'),(2,'ICICI Bank Coral Credit Card','images/icici.jpg','You pay a Joining Fee of Rs.1,000 + service tax and get a complimentary tie worth Rs.999 from Provogue.2x cash rewards at supermarkets, on groceries and dining.Buy one get one free movie ticket offer on Bookmyshow. Avail up to 2 tickets per month up to the value of Rs. 250 per ticket.2 complimentary domestic airport lounge visits every quarter.Culinary Treats program offers a minimum 15% savings on dining bills at over 800 restaurants across India.'),(3,'HDFC Bank Platinum plus credit card','images/hdfc.jpg','This card has zero joining fees and annual fees of Rs.299.You get 50% more reward points when you spend more than Rs.50,000 in a statement cycle. Some of the benefits include incremental reward points, 0% fuel surcharge and lower interest rate on revolving your credit facility.'),(4,'Axis Bank Infinite Credit Card','images/axis.png','It is famous for its lowest interest rate, zero joining as well as annual fees and 0% fuel surcharge for transactions between Rs.400 to Rs.4000. It offers 25% cash back on movie ticket purchase (up to Rs.1000 in a year) and double the rewards when you spend internationally.'),(5,'SBI Gold Credit Card','images/sbi.png','The joining and the annual fee on this card are Rs.299, and you can earn 1 point for every Rs.100 you spend and 10 Cash Points for every Rs.100 spent on Departmental Store & Grocery Spends through your credit card.'),(6,'Standard Chartered Platinum Rewards Credit Card','images/standard.png','This card has a joining fee of Rs.399 which is waived off when you apply for a credit card online. You get bonus rewards after first 5 transactions And each time you shop with your card at participating partners.'),(7,'American Express payback credit card','images/american.png','You can earn 3 PAYBACK Points for every Rs.100 spent.Spend at listed merchants in their listed categories(grocery, restaurants, fuel etc.) every month, and get a complimentary movie voucher for two worth Rs. 700, every month.'),(8,'HSBC Platinum Credit card','images/hsbc.png','This card also has zero joining and annual fee. It comes with 0% fuel surcharge and you can Earn 2 Reward points for every Rs.150 spent.'),(9,'IndusInd Gold Credit Card','images/indusind.png','You get a chance to choose the savings plan that matches your lifestyle and spend patterns. It offers 4 different plans which include shop plan, home plan, travel plan and party plan. Under Gold Home plan, for every Rs 100 spent, you can earn 4 savings points for grocery shopping, 2.5 points for Cellphone & electricity bills, 1.5 for insurance premium & medical bills and 0.5 points for all other spends.'),(10,'Kotak Mahindra Essentia platinum credit card','images/kotak.jpg','This credit card has a joining fee of Rs.1499 and an annual fee of Rs.749, but it gives you 10 Saving Points for Rs.100 you spend at Departmental & Grocery Stores  wherein 1 Saving Point = Re.1 with the condition that the Minimum transaction size should be Rs. 1500 & Maximum Rs. 4000. Maximum Saving Points for a month can be 500. You can earn 1 Saving Point for Rs. 250 you spend on other categories and redeem for cash and against Airline tickets/ Merchandise/ Mobile recharge.');
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
INSERT INTO `question_table` VALUES (1,'Is your age less than 25?'),(2,'Is your salary more than 6 lakh per annum?'),(3,'Do you already have an existing credit card?'),(4,'Do you want to use your credit card for daily purpose i.e paying electricity bills,fuel, buying groceries etc?'),(5,'Do you want to use your credit card for shopping/travelling/movie tickets etc?');
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

-- Dump completed on 2016-07-13 19:08:27
