-- MariaDB dump 10.19  Distrib 10.9.4-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: community
-- ------------------------------------------------------
-- Server version	10.9.4-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(50) NOT NULL,
  `content` text NOT NULL DEFAULT '',
  `user_id` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `draft` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `post_user_id_fk` (`user_id`),
  CONSTRAINT `post_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='post';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES
(1,'This is a first post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(2,'This is a second post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(3,'This is a third post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(4,'This is a fourth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(5,'This is a fifth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(6,'This is a sixth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(7,'This is a seventh post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(8,'This is a eighth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(9,'This is a ninth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(10,'This is a tenth post','# This is a tenth post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-05 15:46:15',0),
(11,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(12,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(13,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(14,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(15,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(16,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(17,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(18,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(19,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(20,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(21,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(22,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(23,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(24,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(25,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(26,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(27,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(28,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(29,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(30,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(31,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(32,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(33,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-03 14:26:35',0),
(34,'This is a tenth post','# This is a first post\n\n```java\npublic static void main() {\n    System.out.println(\"This is a first post\")\n}\n```',1,'2022-11-03 09:38:46','2022-11-24 09:24:04',0),
(35,'too long','1.\n2.\n3.\n4.\n5.\n6.\n7.\n8.\n9.\n10.\n11.\n12.\n13.\n14.\n15.\n16.\n17.\n18.\n19.\n20.\n21.\n22.\n23.\n24.\n25.\n26.\n27.\n28.\n29.\n30.\n31.\n32.\n33.\n34.\n35.\n36.\n37.\n38.\n39.\n40.\n41.\n42.\n43.\n44.\n45.',1,'2022-11-05 16:56:48','2022-11-23 09:15:42',0),
(36,'too wide','# Tiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiitile',1,'2022-11-05 16:58:47','2022-11-05 17:52:13',1),
(37,'2022-11-24','# 2022-11-24\n\n```java\npublic static void main() {\n System.out.println(\"2022-11-24\");\n}\n```',1,'2022-11-24 10:10:47','2022-11-24 10:12:13',0);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_comment`
--

DROP TABLE IF EXISTS `post_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `post_id` bigint(20) NOT NULL,
  `comment` text NOT NULL,
  `create_time` datetime NOT NULL,
  `del` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `post_comment_user_id_fk` (`user_id`),
  KEY `post_comment_post_id_fk` (`post_id`),
  CONSTRAINT `post_comment_post_id_fk` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`),
  CONSTRAINT `post_comment_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_comment`
--

LOCK TABLES `post_comment` WRITE;
/*!40000 ALTER TABLE `post_comment` DISABLE KEYS */;
INSERT INTO `post_comment` VALUES
(1,1,35,'123','2022-11-22 09:15:57',0),
(4,1,35,'123','2022-11-22 09:15:57',0),
(5,1,35,'123','2022-11-22 09:15:57',0),
(6,1,35,'123','2022-11-22 09:15:57',0),
(7,1,35,'123','2022-11-22 09:15:57',0),
(8,1,35,'123','2022-11-22 09:15:57',0),
(9,1,35,'123','2022-11-22 09:15:57',0),
(10,1,35,'123','2022-11-22 09:15:57',0),
(11,1,35,'123','2022-11-22 09:15:57',0),
(12,1,35,'123','2022-11-22 09:15:57',0),
(13,1,35,'123','2022-11-22 09:15:57',0),
(14,1,35,'123','2022-11-22 09:15:57',0),
(15,1,35,'123','2022-11-22 09:15:57',0),
(16,1,35,'123','2022-11-22 09:15:57',0),
(17,1,35,'123','2022-11-22 09:15:57',0),
(18,1,35,'123','2022-11-22 09:15:57',0),
(19,1,35,'123','2022-11-22 09:15:57',0),
(20,1,35,'123','2022-11-22 09:15:57',0),
(21,1,35,'123','2022-11-22 09:15:57',0),
(22,1,35,'123','2022-11-22 09:15:57',0),
(23,1,35,'123','2022-11-22 09:15:57',0),
(24,1,35,'123','2022-11-22 09:15:57',0),
(25,1,35,'123','2022-11-22 09:15:57',0),
(26,1,35,'123','2022-11-22 09:15:57',0),
(27,1,35,'123','2022-11-23 09:15:42',0),
(28,1,34,'123','2022-11-23 16:38:40',0),
(29,1,34,'12323123213','2022-11-24 09:24:04',0),
(30,1,37,'2022-11-24','2022-11-24 10:12:13',0);
/*!40000 ALTER TABLE `post_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(18) NOT NULL COMMENT 'username',
  `password` varchar(32) NOT NULL COMMENT 'password',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='user';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES
(1,'enaium','202cb962ac59075b964b07152d234b70');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_information`
--

DROP TABLE IF EXISTS `user_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_information` (
  `user_id` bigint(20) DEFAULT NULL,
  `nickname` varchar(20) DEFAULT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  KEY `user_information_user_null_fk` (`user_id`),
  CONSTRAINT `user_information_user_null_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_information`
--

LOCK TABLES `user_information` WRITE;
/*!40000 ALTER TABLE `user_information` DISABLE KEYS */;
INSERT INTO `user_information` VALUES
(1,'Enaium',NULL);
/*!40000 ALTER TABLE `user_information` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-24 10:17:02
