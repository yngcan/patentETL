/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : patstat2018bsample

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 17/06/2020 17:37:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for countryGeoIP
-- ----------------------------
DROP TABLE IF EXISTS `countryGeoIP`;
CREATE TABLE `countryGeoIP` (
  `country` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lat` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `long` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Countries and Regions` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Cout` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for TLS201_APPLN
-- ----------------------------
DROP TABLE IF EXISTS `TLS201_APPLN`;
CREATE TABLE `TLS201_APPLN` (
  `APPLN_ID` int unsigned NOT NULL,
  `APPLN_AUTH` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `APPLN_NR` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `APPLN_KIND` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT '',
  `APPLN_FILING_DATE` date DEFAULT NULL,
  `APPLN_FILING_YEAR` int DEFAULT NULL,
  `APPLN_NR_EPODOC` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `APPLN_NR_ORIGINAL` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `IPR_TYPE` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT '',
  `RECEIVING_OFFICE` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `INTERNAT_APPLN_ID` int DEFAULT NULL,
  `INT_PHASE` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N',
  `REG_PHASE` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N',
  `NAT_PHASE` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'N',
  `EARLIEST_FILING_DATE` date NOT NULL DEFAULT '9999-12-31',
  `EARLIEST_FILING_YEAR` int NOT NULL DEFAULT '9999',
  `EARLIEST_FILING_ID` int NOT NULL DEFAULT '0',
  `EARLIEST_PUBLN_DATE` date NOT NULL DEFAULT '9999-12-31',
  `EARLIEST_PUBLN_YEAR` int NOT NULL DEFAULT '9999',
  `EARLIEST_PAT_PUBLN_ID` int NOT NULL DEFAULT '0',
  `GRANTED` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `DOCDB_FAMILY_ID` int NOT NULL DEFAULT '0',
  `INPADOC_FAMILY_ID` int NOT NULL DEFAULT '0',
  `DOCDB_FAMILY_SIZE` int NOT NULL DEFAULT '0',
  `NB_CITING_DOCDB_FAM` int NOT NULL DEFAULT '0',
  `NB_APPLICANTS` int NOT NULL DEFAULT '0',
  `NB_INVENTORS` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`APPLN_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for tls202_appln_title
-- ----------------------------
DROP TABLE IF EXISTS `tls202_appln_title`;
CREATE TABLE `tls202_appln_title` (
  `APPLN_ID` int unsigned NOT NULL,
  `APPLN_TITLE_LG` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `APPLN_TITLE` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`APPLN_ID`),
  FULLTEXT KEY `title_fulltext` (`APPLN_TITLE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for TLS206_PERSON
-- ----------------------------
DROP TABLE IF EXISTS `TLS206_PERSON`;
CREATE TABLE `TLS206_PERSON` (
  `PERSON_ID` int unsigned NOT NULL,
  `PERSON_NAME` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `PERSON_ADDRESS` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `PERSON_CTRY_CODE` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NUTS` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `NUTS_LEVEL` int NOT NULL DEFAULT '9',
  `DOC_STD_NAME_ID` int unsigned NOT NULL,
  `DOC_STD_NAME` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `PSN_ID` int unsigned NOT NULL,
  `PSN_NAME` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `PSN_LEVEL` int unsigned NOT NULL,
  `PSN_SECTOR` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `HAN_ID` int unsigned NOT NULL,
  `HAN_NAME` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `HAN_HARMONIZED` int unsigned NOT NULL,
  PRIMARY KEY (`PERSON_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for TLS207_PERS_APPLN
-- ----------------------------
DROP TABLE IF EXISTS `TLS207_PERS_APPLN`;
CREATE TABLE `TLS207_PERS_APPLN` (
  `PERSON_ID` int unsigned NOT NULL,
  `APPLN_ID` int unsigned NOT NULL,
  `APPLT_SEQ_NR` smallint unsigned NOT NULL,
  `INVT_SEQ_NR` smallint unsigned NOT NULL,
  PRIMARY KEY (`PERSON_ID`,`APPLN_ID`,`APPLT_SEQ_NR`,`INVT_SEQ_NR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for TLS209_APPLN_IPC
-- ----------------------------
DROP TABLE IF EXISTS `TLS209_APPLN_IPC`;
CREATE TABLE `TLS209_APPLN_IPC` (
  `APPLN_ID` int unsigned NOT NULL,
  `IPC_CLASS_SYMBOL` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `IPC_CLASS_LEVEL` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `IPC_VERSION` date DEFAULT NULL,
  `IPC_VALUE` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `IPC_POSITION` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `IPC_GENER_AUTH` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`APPLN_ID`,`IPC_CLASS_SYMBOL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for TLS211_PAT_PUBLN
-- ----------------------------
DROP TABLE IF EXISTS `TLS211_PAT_PUBLN`;
CREATE TABLE `TLS211_PAT_PUBLN` (
  `PAT_PUBLN_ID` int unsigned NOT NULL,
  `PUBLN_AUTH` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `PUBLN_NR` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `PUBLN_NR_ORIGINAL` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `PUBLN_KIND` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `APPLN_ID` int unsigned NOT NULL,
  `PUBLN_DATE` date DEFAULT NULL,
  `PUBLN_LG` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `PUBLN_FIRST_GRANT` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `PUBLN_CLAIMS` varchar(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`PAT_PUBLN_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for TLS212_CITATION
-- ----------------------------
DROP TABLE IF EXISTS `TLS212_CITATION`;
CREATE TABLE `TLS212_CITATION` (
  `PAT_PUBLN_ID` int unsigned NOT NULL,
  `CITN_REPLENISHED` int NOT NULL DEFAULT '0',
  `CITN_ID` smallint unsigned NOT NULL,
  `CITN_ORIGIN` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `CITED_PAT_PUBLN_ID` int unsigned DEFAULT NULL,
  `CITED_APPLN_ID` int unsigned NOT NULL,
  `PAT_CITN_SEQ_NR` smallint unsigned DEFAULT NULL,
  `CITED_NPL_PUBLN_ID` int unsigned NOT NULL,
  `NPL_CITN_SEQ_NR` smallint unsigned DEFAULT NULL,
  `CITN_GENER_AUTH` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`PAT_PUBLN_ID`,`CITN_REPLENISHED`,`CITN_ID`),
  CONSTRAINT `fk_TLS212_CITATION_TLS211_PAT_PUBLN_1` FOREIGN KEY (`PAT_PUBLN_ID`) REFERENCES `TLS211_PAT_PUBLN` (`PAT_PUBLN_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for TLS224_APPLN_CPC
-- ----------------------------
DROP TABLE IF EXISTS `TLS224_APPLN_CPC`;
CREATE TABLE `TLS224_APPLN_CPC` (
  `APPLN_ID` int unsigned NOT NULL,
  `CPC_CLASS_SYMBOL` varchar(19) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `CPC_SCHEME` varchar(5) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `CPC_VERSION` date NOT NULL DEFAULT '9999-12-31',
  `CPC_VALUE` char(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `CPC_POSITION` char(1) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `CPC_GENER_AUTH` char(2) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`APPLN_ID`,`CPC_CLASS_SYMBOL`,`CPC_SCHEME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for TLS230_APPLN_TECHN_FIELD
-- ----------------------------
DROP TABLE IF EXISTS `TLS230_APPLN_TECHN_FIELD`;
CREATE TABLE `TLS230_APPLN_TECHN_FIELD` (
  `APPLN_ID` int NOT NULL DEFAULT '0',
  `TECHN_FIELD_NR` int NOT NULL DEFAULT '0',
  `WEIGHT` double NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for TLS801_COUNTRY
-- ----------------------------
DROP TABLE IF EXISTS `TLS801_COUNTRY`;
CREATE TABLE `TLS801_COUNTRY` (
  `CTRY_CODE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ISO_ALPHA3` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ST3_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `STATE_INDICATOR` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `CONTINENT` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `EU_MEMBER` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `EPO_MEMBER` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `OECD_MEMBER` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DISCONTINUED` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`CTRY_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for TLS901_TECHN_FIELD_IPC
-- ----------------------------
DROP TABLE IF EXISTS `TLS901_TECHN_FIELD_IPC`;
CREATE TABLE `TLS901_TECHN_FIELD_IPC` (
  `IPC_MAINGROUP_SYMBOL` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `TECHN_FIELD_NR` int NOT NULL DEFAULT '0',
  `TECHN_SECTOR` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `TECHN_FIELD` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`IPC_MAINGROUP_SYMBOL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for TLS904_NUTS
-- ----------------------------
DROP TABLE IF EXISTS `TLS904_NUTS`;
CREATE TABLE `TLS904_NUTS` (
  `NUTS` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `NUTS_LEVEL` int NOT NULL DEFAULT '0',
  `NUTS_LABEL` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`NUTS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

SET FOREIGN_KEY_CHECKS = 1;
