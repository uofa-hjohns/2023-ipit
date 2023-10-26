-- MySQL dump 10.13  Distrib 8.0.34, for Linux (x86_64)
--
-- Host: localhost    Database: ipit
-- ------------------------------------------------------
-- Server version	8.0.34-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `ipit`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ipit` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `ipit`;

--
-- Table structure for table `Customers`
--

DROP TABLE IF EXISTS `Customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customers` (
  `Customer_ID` varchar(255) NOT NULL,
  `Customer_Name` varchar(255) DEFAULT NULL,
  `Customer_BillerID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Customer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customers`
--

LOCK TABLES `Customers` WRITE;
/*!40000 ALTER TABLE `Customers` DISABLE KEYS */;
INSERT INTO `Customers` VALUES ('a1111111','Abby Bede','001100'),('a2222222','Connor David','002200'),('a3333333','Emmet Frank','003300'),('a4444444','George Holmes','004400'),('a5555555','Iris Jones','005500'),('a6666666','Katy Leon','006600'),('a7777777','Mike Newman','007700'),('a8888888','Olaf Perrson','008800'),('a9999999','Quentin Ron','009900');
/*!40000 ALTER TABLE `Customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GeneralLedgerEntries`
--

DROP TABLE IF EXISTS `GeneralLedgerEntries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GeneralLedgerEntries` (
  `GLE_LineNumber` int NOT NULL,
  `GLE_LineDescription` varchar(255) DEFAULT NULL,
  `GLE_Period` int NOT NULL,
  `GLE_Year` year NOT NULL,
  `GLEFK_GL_AccountID` int NOT NULL,
  `GLEFK_Operator_ID` varchar(255) DEFAULT NULL,
  `GLEFK_Source_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`GLE_LineNumber`),
  KEY `FK_GLEtGL` (`GLEFK_GL_AccountID`),
  KEY `FK_GLEOper` (`GLEFK_Operator_ID`),
  KEY `FK_GLESrc` (`GLEFK_Source_ID`),
  CONSTRAINT `FK_GLEOper` FOREIGN KEY (`GLEFK_Operator_ID`) REFERENCES `Operators` (`Operator_ID`),
  CONSTRAINT `FK_GLESrc` FOREIGN KEY (`GLEFK_Source_ID`) REFERENCES `Sources` (`Source_ID`),
  CONSTRAINT `FK_GLEtGL` FOREIGN KEY (`GLEFK_GL_AccountID`) REFERENCES `GeneralLedgers` (`GL_AccountID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GeneralLedgerEntries`
--

LOCK TABLES `GeneralLedgerEntries` WRITE;
/*!40000 ALTER TABLE `GeneralLedgerEntries` DISABLE KEYS */;
INSERT INTO `GeneralLedgerEntries` VALUES (91,'Purchase Officeworks',1,2023,2921,'FSBATC01','SPA'),(200,'Firmware Update',2,2023,2921,'FSBATC01','AP'),(203,'Logitech MK120 Corded USB Keyb',2,2023,2921,'FSBATC01','AP'),(205,'USB-C SLIM MULTI-PORT WITH ETH',2,2023,2921,'FSBATC01','AP'),(207,'HP E34m G4 34\" WQHD CURVED 21',2,2023,2921,'FSBATC01','AP'),(209,'Alogic Dual 4k Display Uni Doc',2,2023,2921,'FSBATC01','AP'),(212,'HP 4y NBD Response OS support',2,2023,2921,'FSBATC01','AP'),(218,'UPH-Monitor / Dock Onsite Inst',2,2023,2921,'FSBATC01','AP'),(220,'UPH-New to Service Tagging',2,2023,2921,'FSBATC01','AP'),(229,'UPH-New to Service Tagging',2,2023,2921,'FSBATC01','AP'),(329,'Logitech Multimedia Speakers Z',1,2023,2921,'FSBATC01','AP'),(491,'UPH - Asset Tag',4,2023,2921,'FSBATC01','AP'),(492,'Dell P-Series 23.8\" (16:9) IPS',4,2023,2921,'FSBATC01','AP'),(503,'UPH - Software Co-ordination a',4,2023,2921,'FSBATC01','AP'),(504,'UPH - Asset Tag',4,2023,2921,'FSBATC01','AP'),(505,'UPH - Standard Image Install',4,2023,2921,'FSBATC01','AP'),(506,'HP 3YR Parts & Labour next bus',4,2023,2921,'FSBATC01','AP'),(507,'UPH-New to Service Tagging',4,2023,2921,'FSBATC01','AP'),(508,'UPH - Deployment To Your Desk',4,2023,2921,'FSBATC01','AP'),(509,'UPH-New to Service Tagging',4,2023,2921,'FSBATC01','AP'),(510,'HP Z1 G9 TWR I7-12700 32GB 512',4,2023,2921,'FSBATC01','AP'),(600,'Alogic Dual 4k Display Uni Doc',3,2023,2921,'FSBATC01','AP'),(601,'Dell Latitude 7430 14\" NT i7 1',3,2023,2921,'FSBATC01','AP'),(604,'Logitech MK270R Wireless Keybo',3,2023,2921,'FSBATC01','AP'),(605,'HP E24 G4 23.8\" FHD IPS EYE',3,2023,2921,'FSBATC01','AP'),(681,'UPH - Asset Tag',4,2023,2921,'FSBATC01','AP'),(691,'UPH - Software Co-ordination a',4,2023,2921,'FSBATC01','AP'),(700,'UPH-New to Service Tagging',4,2023,2921,'FSBATC01','AP'),(724,'UPH - Standard Image Install',4,2023,2921,'FSBATC01','AP'),(726,'UPH - Deployment To Your Desk',4,2023,2921,'FSBATC01','AP'),(728,'QO230320-57862 - Leader CTO',4,2023,2921,'FSBATC01','AP'),(775,'Purchase Core Electronics',8,2023,2921,'FSBATC01','SPA'),(897,'UPH - Asset Tag',3,2023,2921,'FSBATC01','AP'),(899,'UPH - Software Co-ordination a',3,2023,2921,'FSBATC01','AP'),(902,'UPH-New to Service Tagging',3,2023,2921,'FSBATC01','AP'),(904,'UPH - Deployment To Your Desk',3,2023,2921,'FSBATC01','AP'),(908,'UPH - Standard Image Install',3,2023,2921,'FSBATC01','AP'),(910,'Apple 16\" MacBook Pro M2 Pro 1',3,2023,2921,'FSBATC01','AP'),(912,'Apple Magic Mouse - Black Mult',3,2023,2921,'FSBATC01','AP'),(914,'MacBook Pro 16\" 3-Year (total)',3,2023,2921,'FSBATC01','AP'),(3386,'PANDUIT-UTPSP1.5MYLY',1,2023,2921,'FSBATC01','AP');
/*!40000 ALTER TABLE `GeneralLedgerEntries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GeneralLedgers`
--

DROP TABLE IF EXISTS `GeneralLedgers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GeneralLedgers` (
  `GL_AccountID` int NOT NULL,
  `GL_AccountDescription` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`GL_AccountID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GeneralLedgers`
--

LOCK TABLES `GeneralLedgers` WRITE;
/*!40000 ALTER TABLE `GeneralLedgers` DISABLE KEYS */;
INSERT INTO `GeneralLedgers` VALUES (2921,'IT/ICT Equipment <$10k');
/*!40000 ALTER TABLE `GeneralLedgers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Journals`
--

DROP TABLE IF EXISTS `Journals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Journals` (
  `Journal_ID` varchar(255) NOT NULL,
  `Journal_Date` varchar(255) DEFAULT NULL,
  `Journal_EntryDate` varchar(255) DEFAULT NULL,
  `JournalFK_GLE_LineNumber` int NOT NULL,
  `JournalFK_Transaction_InvoiceID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Journal_ID`),
  KEY `FK_Journals_GLE` (`JournalFK_GLE_LineNumber`),
  KEY `FK_Journals_Transactions` (`JournalFK_Transaction_InvoiceID`),
  CONSTRAINT `FK_Journals_GLE` FOREIGN KEY (`JournalFK_GLE_LineNumber`) REFERENCES `GeneralLedgerEntries` (`GLE_LineNumber`),
  CONSTRAINT `FK_Journals_Transactions` FOREIGN KEY (`JournalFK_Transaction_InvoiceID`) REFERENCES `Transactions` (`Transaction_InvoiceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Journals`
--

LOCK TABLES `Journals` WRITE;
/*!40000 ALTER TABLE `Journals` DISABLE KEYS */;
INSERT INTO `Journals` VALUES ('APA0511773','10/01/2023','10/01/2023',329,'K0576262'),('APA0512068','13/01/2023','13/01/2023',3386,'K0577123'),('APA0513232','10/02/2023','10/02/2023',212,'K0584226'),('APA0514493','10/03/2023','10/03/2023',600,'K0599631'),('APA0515346','31/03/2023','31/03/2023',912,'K0606873'),('APA0515540','4/04/2023','4/04/2023',700,'K0607976'),('APA0515664','6/04/2023','6/04/2023',508,'K0609587'),('EMSCQ58139','4/01/2023','5/01/2023',91,'9877654'),('EMSCQ60981','4/08/2023','7/08/2023',775,'1233489');
/*!40000 ALTER TABLE `Journals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Operators`
--

DROP TABLE IF EXISTS `Operators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Operators` (
  `Operator_ID` varchar(255) NOT NULL,
  `Operator_Name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Operator_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Operators`
--

LOCK TABLES `Operators` WRITE;
/*!40000 ALTER TABLE `Operators` DISABLE KEYS */;
INSERT INTO `Operators` VALUES ('FSBATC01','Ivan Tom');
/*!40000 ALTER TABLE `Operators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sources`
--

DROP TABLE IF EXISTS `Sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sources` (
  `Source_ID` varchar(255) NOT NULL,
  `Source_LongDescription` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Source_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sources`
--

LOCK TABLES `Sources` WRITE;
/*!40000 ALTER TABLE `Sources` DISABLE KEYS */;
INSERT INTO `Sources` VALUES ('AP','AP Voucher Accrual'),('SPA','Fraedom Card Acquittals');
/*!40000 ALTER TABLE `Sources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transactions`
--

DROP TABLE IF EXISTS `Transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Transactions` (
  `Transaction_InvoiceID` varchar(255) NOT NULL,
  `Transaction_InvoiceAmount` int NOT NULL,
  `TransactionFK_Customer_ID` varchar(255) DEFAULT NULL,
  `TransactionFK_Vendor_ID` int NOT NULL,
  PRIMARY KEY (`Transaction_InvoiceID`),
  KEY `FK_TransactionCustomers` (`TransactionFK_Customer_ID`),
  KEY `FK_TransactionVendors` (`TransactionFK_Vendor_ID`),
  CONSTRAINT `FK_TransactionCustomers` FOREIGN KEY (`TransactionFK_Customer_ID`) REFERENCES `Customers` (`Customer_ID`),
  CONSTRAINT `FK_TransactionVendors` FOREIGN KEY (`TransactionFK_Vendor_ID`) REFERENCES `Vendors` (`Vendor_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transactions`
--

LOCK TABLES `Transactions` WRITE;
/*!40000 ALTER TABLE `Transactions` DISABLE KEYS */;
INSERT INTO `Transactions` VALUES ('1233489',1352,'a1111111',1024),('9877654',180,'a9999999',2048),('K0576262',66,'a8888888',643),('K0577123',172,'a7777777',53901),('K0584226',205,'a6666666',53901),('K0599631',338,'a5555555',53901),('K0606873',118,'a4444444',53901),('K0607976',3,'a3333333',53901),('K0609587',250,'a2222222',53901);
/*!40000 ALTER TABLE `Transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vendors`
--

DROP TABLE IF EXISTS `Vendors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vendors` (
  `Vendor_ID` int NOT NULL,
  `Vendor_Name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Vendor_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vendors`
--

LOCK TABLES `Vendors` WRITE;
/*!40000 ALTER TABLE `Vendors` DISABLE KEYS */;
INSERT INTO `Vendors` VALUES (643,'Winc Australia Pty Ltd'),(1024,'Core Electronics'),(2048,'Officeworks Pty Ltd'),(53901,'Computers Now Pty Ltd');
/*!40000 ALTER TABLE `Vendors` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-26  2:07:36
