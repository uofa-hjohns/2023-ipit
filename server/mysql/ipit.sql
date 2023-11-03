-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: ipit
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.20.04.1

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
INSERT INTO `Customers` VALUES ('a2222222','Connor David','002200'),('a3333333','Emmet Frank','003300'),('a4444444','George Holmes','004400'),('a5555555','Iris Jones','005500'),('a6666666','Katy Leon','006600'),('a7777777','Mike Newman','007700'),('a8888888','Olaf Perrson','008800');
/*!40000 ALTER TABLE `Customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Entries`
--

DROP TABLE IF EXISTS `Entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Entries` (
  `Line_Number` int NOT NULL,
  `Line_Description` varchar(255) DEFAULT NULL,
  `Line_Operator_ID` varchar(255) DEFAULT NULL,
  `Line_Source_ID` varchar(255) DEFAULT NULL,
  `Line_Journal_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Line_Number`),
  KEY `FK_LineOperator` (`Line_Operator_ID`),
  KEY `FK_LineSource` (`Line_Source_ID`),
  KEY `FK_LineJournal` (`Line_Journal_ID`),
  CONSTRAINT `FK_LineJournal` FOREIGN KEY (`Line_Journal_ID`) REFERENCES `Journals` (`Journal_ID`),
  CONSTRAINT `FK_LineOperator` FOREIGN KEY (`Line_Operator_ID`) REFERENCES `Operators` (`Operator_ID`),
  CONSTRAINT `FK_LineSource` FOREIGN KEY (`Line_Source_ID`) REFERENCES `Sources` (`Source_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Entries`
--

LOCK TABLES `Entries` WRITE;
/*!40000 ALTER TABLE `Entries` DISABLE KEYS */;
INSERT INTO `Entries` VALUES (200,'Firmware Update','FSBATC01','AP','APA0513232'),(203,'Logitech MK120 Corded USB Keyb','FSBATC01','AP','APA0513232'),(205,'USB-C SLIM MULTI-PORT WITH ETH','FSBATC01','AP','APA0513232'),(207,'HP E34m G4 34\" WQHD CURVED 21','FSBATC01','AP','APA0513232'),(209,'Alogic Dual 4k Display Uni Doc','FSBATC01','AP','APA0513232'),(212,'HP 4y NBD Response OS support','FSBATC01','AP','APA0513232'),(329,'Logitech Multimedia Speakers Z','FSBATC01','AP','APA0511773'),(492,'Dell P-Series 23.8\" (16:9) IPS','FSBATC01','AP','APA0515664'),(506,'HP 3YR Parts & Labour next bus','FSBATC01','AP','APA0515664'),(510,'HP Z1 G9 TWR I7-12700 32GB 512','FSBATC01','AP','APA0515664'),(600,'Alogic Dual 4k Display Uni Doc','FSBATC01','AP','APA0514493'),(601,'Dell Latitude 7430 14\" NT i7 1','FSBATC01','AP','APA0514493'),(604,'Logitech MK270R Wireless Keybo','FSBATC01','AP','APA0514493'),(605,'HP E24 G4 23.8\" FHD IPS EYE','FSBATC01','AP','APA0514493'),(728,'QO230320-57862 - Leader CTO','FSBATC01','AP','APA0515540'),(910,'Apple 16\" MacBook Pro M2 Pro 1','FSBATC01','AP','APA0515346'),(912,'Apple Magic Mouse - Black Mult','FSBATC01','AP','APA0515346'),(914,'MacBook Pro 16\" 3-Year (total)','FSBATC01','AP','APA0515346'),(3386,'PANDUIT-UTPSP1.5MYLY','FSBATC01','AP','APA0512068');
/*!40000 ALTER TABLE `Entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Invoices`
--

DROP TABLE IF EXISTS `Invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Invoices` (
  `Invoice_ID` varchar(255) NOT NULL,
  `Invoice_Amount` varchar(255) DEFAULT NULL,
  `Invoice_Customer_ID` varchar(255) DEFAULT NULL,
  `Invoice_Vendor_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Invoice_ID`),
  KEY `FK_InvoiceCustomer` (`Invoice_Customer_ID`),
  KEY `FK_InvoiceVendor` (`Invoice_Vendor_ID`),
  CONSTRAINT `FK_InvoiceCustomer` FOREIGN KEY (`Invoice_Customer_ID`) REFERENCES `Customers` (`Customer_ID`),
  CONSTRAINT `FK_InvoiceVendor` FOREIGN KEY (`Invoice_Vendor_ID`) REFERENCES `Vendors` (`Vendor_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Invoices`
--

LOCK TABLES `Invoices` WRITE;
/*!40000 ALTER TABLE `Invoices` DISABLE KEYS */;
INSERT INTO `Invoices` VALUES ('K0576262','65.77','a8888888','643'),('K0577123','172.27','a7777777','53901'),('K0584226','205.05','a6666666','53901'),('K0599631','337.55','a5555555','53901'),('K0606873','118.08','a4444444','53901'),('K0607976','2669.73','a3333333','53901'),('K0609587','1425.2','a2222222','53901');
/*!40000 ALTER TABLE `Invoices` ENABLE KEYS */;
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
  `Journal_Invoice_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Journal_ID`),
  KEY `FK_JournalInvoice` (`Journal_Invoice_ID`),
  CONSTRAINT `FK_JournalInvoice` FOREIGN KEY (`Journal_Invoice_ID`) REFERENCES `Invoices` (`Invoice_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Journals`
--

LOCK TABLES `Journals` WRITE;
/*!40000 ALTER TABLE `Journals` DISABLE KEYS */;
INSERT INTO `Journals` VALUES ('APA0511773','10/01/2023','10/01/2023','K0576262'),('APA0512068','13/01/2023','13/01/2023','K0577123'),('APA0513232','10/02/2023','10/02/2023','K0584226'),('APA0514493','10/03/2023','10/03/2023','K0599631'),('APA0515346','31/03/2023','31/03/2023','K0606873'),('APA0515540','4/04/2023','4/04/2023','K0607976'),('APA0515664','6/04/2023','6/04/2023','K0609587');
/*!40000 ALTER TABLE `Journals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ledgers`
--

DROP TABLE IF EXISTS `Ledgers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ledgers` (
  `Ledger_ID` varchar(255) NOT NULL,
  `Ledger_Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Ledger_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ledgers`
--

LOCK TABLES `Ledgers` WRITE;
/*!40000 ALTER TABLE `Ledgers` DISABLE KEYS */;
INSERT INTO `Ledgers` VALUES ('2921','IT/ICT Equipment <$10k');
/*!40000 ALTER TABLE `Ledgers` ENABLE KEYS */;
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
  `Source_Description` varchar(255) DEFAULT NULL,
  `Source_Ledger_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Source_ID`),
  KEY `FK_SourceLedger` (`Source_Ledger_ID`),
  CONSTRAINT `FK_SourceLedger` FOREIGN KEY (`Source_Ledger_ID`) REFERENCES `Ledgers` (`Ledger_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sources`
--

LOCK TABLES `Sources` WRITE;
/*!40000 ALTER TABLE `Sources` DISABLE KEYS */;
INSERT INTO `Sources` VALUES ('AP','AP Voucher Accrual','2921');
/*!40000 ALTER TABLE `Sources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vendors`
--

DROP TABLE IF EXISTS `Vendors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vendors` (
  `Vendor_ID` varchar(255) NOT NULL,
  `Vendor_Name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Vendor_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vendors`
--

LOCK TABLES `Vendors` WRITE;
/*!40000 ALTER TABLE `Vendors` DISABLE KEYS */;
INSERT INTO `Vendors` VALUES ('53901','Computers Now Pty Ltd'),('643','Winc Australia Pty Ltd');
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

-- Dump completed on 2023-11-03  2:15:47
