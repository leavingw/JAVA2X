CREATE DATABASE LibraryX;

DROP TABLE IF EXISTS `author`;

CREATE TABLE `author` (
  `AuthorID` int NOT NULL AUTO_INCREMENT,
  `AuthorFname` varchar(45) NOT NULL,
  `AuthorLname` varchar(45) NOT NULL,
  PRIMARY KEY (`AuthorID`)
);

DROP TABLE IF EXISTS `accounttype`;

CREATE TABLE `accounttype` (
  `AccountType` varchar(45) DEFAULT('Standard') NOT NULL,
  `MaximumNumber` varchar(45) NOT NULL,
  PRIMARY KEY (`AccountType`)
);

INSERT INTO accounttype (AccountType, MaximumNumber)
VALUES ('standard', 5);


DROP TABLE IF EXISTS `books`;

CREATE TABLE `books` (
  `ISBN` char(13) NOT NULL,
  `BookPublisher` varchar(45) NOT NULL,
  `BookCategory` varchar(45) NOT NULL,
  `title` varchar(45) NOT NULL,
  `YearOfPublication` year NOT NULL,
  `Classification` varchar(45) NOT NULL,
  PRIMARY KEY (`ISBN`)
);

DROP TABLE IF EXISTS `authorship`;

CREATE TABLE `authorship` (
  `AuthorshipID` int NOT NULL,
  `AuthorID` int NOT NULL,
  `ISBN` char(13) NOT NULL,
  PRIMARY KEY (`AuthorshipID`),
  KEY `AuthorID_idx` (`ISBN`),
  KEY `AuthorID_idx1` (`AuthorID`),
  CONSTRAINT `AuthorID` FOREIGN KEY (`AuthorID`) REFERENCES `author` (`AuthorID`),
  CONSTRAINT `ISBN` FOREIGN KEY (`ISBN`) REFERENCES `books` (`ISBN`)
);


DROP TABLE IF EXISTS `dvd`;

CREATE TABLE `dvd` (
  `MovieID` int NOT NULL AUTO_INCREMENT,
  `Director` varchar(45) NOT NULL,
  `Producer` varchar(45) NOT NULL,
  `DVDCategory` varchar(45) NOT NULL,
  `Classification` varchar(45) NOT NULL,
  `YearOfPublication` year NOT NULL,
  `title` varchar(45) NOT NULL,
  `ProductionCountry` varchar(45) NOT NULL,
  PRIMARY KEY (`MovieID`)
);

DROP TABLE IF EXISTS `copy`;

CREATE TABLE `copy` (
  `Barcode` int NOT NULL AUTO_INCREMENT,
  `PhysicalLocation` varchar(45) NOT NULL,
  `Status` varchar(45) NOT NULL,
  `MovieID` int DEFAULT NULL,
  `ISBN` char(13) DEFAULT NULL,
  PRIMARY KEY (`Barcode`),
  KEY `ISBN_idx` (`ISBN`),
  KEY `MovieID_idx` (`MovieID`),
  CONSTRAINT `ISBN2` FOREIGN KEY (`ISBN`) REFERENCES `books` (`ISBN`),
  CONSTRAINT `MovieID2` FOREIGN KEY (`MovieID`) REFERENCES `dvd` (`MovieID`)
);

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `Fname` varchar(45) NOT NULL,
  `Lname` varchar(45) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `SSN` char(10) NOT NULL,
  `PhoneNumber` char(10) DEFAULT NULL,
  `Status` tinyint DEFAULT '1' NOT NULL,
  `AccountType` varchar(45) NOT NULL,
  PRIMARY KEY (`userID`),
  KEY `AccountType_idx` (`AccountType`),
  CONSTRAINT `AccountType` FOREIGN KEY (`AccountType`) REFERENCES `accounttype` (`AccountType`)
);


DROP TABLE IF EXISTS `loan`;

CREATE TABLE `loan` (
  `LoanNo` int NOT NULL AUTO_INCREMENT,
  `Startdate` date NOT NULL,
  `Enddate` date NOT NULL,
  `Returndate` timestamp NULL DEFAULT NULL,
  `Barcode` int NOT NULL,
  `UserID` int NOT NULL,
  PRIMARY KEY (`LoanNo`),
  KEY `barcode_idx` (`Barcode`),
  KEY `UserID_idx` (`UserID`),
  CONSTRAINT `Barcode` FOREIGN KEY (`Barcode`) REFERENCES `copy` (`Barcode`),
  CONSTRAINT `UserID` FOREIGN KEY (`UserID`) REFERENCES `user` (`userID`)
);

DROP TABLE IF EXISTS `reservation`;

CREATE TABLE `reservation` (
  `ReservationNo` int NOT NULL AUTO_INCREMENT,
  `Startdate` timestamp NOT NULL,
  `ResStatus` varchar(45) NOT NULL,
  `UserID` int NOT NULL,
  `Barcode` int NOT NULL,
  PRIMARY KEY (`ReservationNo`),
  KEY `UserID_idx` (`UserID`),
  KEY `Barcode_idx` (`Barcode`),
  CONSTRAINT `Barcode2` FOREIGN KEY (`Barcode`) REFERENCES `copy` (`Barcode`),
  CONSTRAINT `UserID2` FOREIGN KEY (`UserID`) REFERENCES `user` (`userID`)
);




