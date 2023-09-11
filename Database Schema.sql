CREATE DATABASE  IF NOT EXISTS `rdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `rdb`;
-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: rdb
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `CategoryId` int NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(50) NOT NULL,
  `CategoryState` enum('DELETED','IN-SERVICE') NOT NULL DEFAULT 'IN-SERVICE',
  PRIMARY KEY (`CategoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Pizza','IN-SERVICE'),(2,'Salad','IN-SERVICE'),(3,'Pasta','IN-SERVICE'),(4,'Indian','IN-SERVICE'),(5,'Dessert','IN-SERVICE'),(6,'Burger','IN-SERVICE'),(7,'Sandwich','IN-SERVICE'),(8,'Soup','IN-SERVICE'),(9,'Chinese','IN-SERVICE'),(10,'Mexican','IN-SERVICE'),(11,'kkk','IN-SERVICE');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clearancetable`
--

DROP TABLE IF EXISTS `clearancetable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clearancetable` (
  `ClearanceId` int NOT NULL AUTO_INCREMENT,
  `CustomerId` int NOT NULL,
  `FeeCharged` float NOT NULL,
  `FeePaid` float NOT NULL,
  `ClearanceType` enum('INVOICE','CREDIT-CARD','CASH') NOT NULL,
  `WaiterId` int NOT NULL,
  `ReferToManager` enum('MANAGER','WAITER') DEFAULT 'WAITER',
  `ClearanceDateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ClearanceId`),
  KEY `CustomerId` (`CustomerId`),
  CONSTRAINT `clearancetable_ibfk_1` FOREIGN KEY (`CustomerId`) REFERENCES `customers` (`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clearancetable`
--

LOCK TABLES `clearancetable` WRITE;
/*!40000 ALTER TABLE `clearancetable` DISABLE KEYS */;
/*!40000 ALTER TABLE `clearancetable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `CustomerId` int NOT NULL AUTO_INCREMENT,
  `CustomerName` varchar(50) NOT NULL,
  `CurrentCost` float NOT NULL DEFAULT '0',
  `TableId` int NOT NULL,
  `CustomerStatus` enum('IN-PROGRESS','CLEARED') NOT NULL DEFAULT 'IN-PROGRESS',
  `DateArrived` date NOT NULL,
  `TimeArrived` time NOT NULL,
  PRIMARY KEY (`CustomerId`),
  KEY `TableId` (`TableId`),
  CONSTRAINT `customers_ibfk_3` FOREIGN KEY (`TableId`) REFERENCES `tables` (`TableId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (7,'Many',0,9,'IN-PROGRESS','2023-08-10','12:50:25'),(8,'Erlson T Madara',0,14,'IN-PROGRESS','2023-08-10','12:57:38'),(12,'Edwick Madara',0,10,'IN-PROGRESS','2023-08-18','19:50:33');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employeestable`
--

DROP TABLE IF EXISTS `employeestable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employeestable` (
  `EmployeeId` smallint unsigned NOT NULL AUTO_INCREMENT,
  `Position` enum('WAITER','MANAGER','CHEF') NOT NULL,
  `FirstName` varchar(30) NOT NULL,
  `Surname` varchar(30) NOT NULL,
  `EmployeePassword` varchar(100) NOT NULL,
  `Salary` float NOT NULL,
  `Address` varchar(100) NOT NULL,
  `Email` varchar(30) NOT NULL,
  `NatId` varchar(40) NOT NULL,
  `DateAdded` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `SignedIn` enum('ACTIVE','NOT ACTIVE') NOT NULL DEFAULT 'NOT ACTIVE',
  `LastSeen` datetime DEFAULT NULL,
  `DateLeft` datetime DEFAULT NULL,
  PRIMARY KEY (`EmployeeId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employeestable`
--

LOCK TABLES `employeestable` WRITE;
/*!40000 ALTER TABLE `employeestable` DISABLE KEYS */;
INSERT INTO `employeestable` VALUES (1,'WAITER','Nick','Fury','hahaha',1,'Chimanene, 100m 3939','nick@gmail.com','45-385884747 A CIT Z','2023-08-02 12:38:12','NOT ACTIVE',NULL,NULL),(2,'WAITER','Vision','Vision','mindstone',1000.9,'Chimanene, 100m 3939','vision@gmail.com','45-388687 B CIT Q','2023-08-02 12:38:12','NOT ACTIVE',NULL,NULL),(3,'MANAGER','Tony','Stark','richguy',20000.9,'New York, 100m 3939','ironman@gmail.com','64-585847 A CIT K','2023-08-02 12:38:12','NOT ACTIVE',NULL,NULL),(4,'CHEF','Steven','Rogers','assemble',5000,'Brooklyn, 100m 3939','captain@gmail.com','45-38384747 A CIT W','2023-08-02 12:38:12','NOT ACTIVE',NULL,NULL),(5,'CHEF','Thor','Asgard','godOfThunder',8000.9,'Valhala, 100m 3939','thor@gmail.com','45-35584747 A CIT U','2023-08-02 12:38:12','NOT ACTIVE',NULL,NULL),(6,'WAITER','Clint','Hawkeye','hawkeye',2000.9,'Virginia, 100m 3939','clint@gmail.com','55-385854747 A CIT PP','2023-08-02 12:38:12','NOT ACTIVE',NULL,NULL),(7,'WAITER','Bruce','Banner','green',4000.9,'New York, 100m 3939','hulk@gmail.com','67-38384747 A CIT O','2023-08-02 12:38:12','NOT ACTIVE',NULL,NULL),(8,'WAITER','Natasha','Romanoff','hotStuff',4000.9,'Russia, 100m 3939','blackwidow@gmail.com','38-38384747 A CIT I','2023-08-02 12:38:12','NOT ACTIVE',NULL,NULL),(9,'MANAGER','Erlson ',' Madara','bsrvnt',300,'35 Chimanemane Street, Zengeza 2, Chitungwiza, Harare','erlsontmadara@gmail.com','63-2230740 A 34 CIT M','2023-09-08 11:03:37','NOT ACTIVE',NULL,'2023-09-08 13:06:25');
/*!40000 ALTER TABLE `employeestable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `foodorders`
--

DROP TABLE IF EXISTS `foodorders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `foodorders` (
  `FoodOrderId` int NOT NULL AUTO_INCREMENT,
  `FoodId` int NOT NULL,
  `Quantity` int NOT NULL,
  `Specification` varchar(200) DEFAULT NULL,
  `OrderId` int NOT NULL,
  `Price` float NOT NULL,
  `FoodOrderStatus` enum('CANCELLED','CONFIRMED') DEFAULT 'CONFIRMED',
  PRIMARY KEY (`FoodOrderId`),
  KEY `OrderId` (`OrderId`),
  KEY `FoodId` (`FoodId`),
  CONSTRAINT `foodorders_ibfk_1` FOREIGN KEY (`OrderId`) REFERENCES `orderstable` (`OrderId`),
  CONSTRAINT `foodorders_ibfk_2` FOREIGN KEY (`FoodId`) REFERENCES `menu` (`FoodId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `foodorders`
--

LOCK TABLES `foodorders` WRITE;
/*!40000 ALTER TABLE `foodorders` DISABLE KEYS */;
INSERT INTO `foodorders` VALUES (1,32,1,'N/A',9,13.99,'CONFIRMED'),(2,36,1,'N/A',9,9.99,'CONFIRMED'),(3,37,2,'more salt',9,19.98,'CONFIRMED'),(4,11,2,'with a little less salad',9,17.98,'CONFIRMED'),(5,27,3,'with a lot more spice',10,32.97,'CONFIRMED'),(6,46,2,'N/A',9,13.98,'CONFIRMED'),(7,69,2,'N/A',10,17.98,'CONFIRMED'),(8,64,1,'N/A',11,7.99,'CONFIRMED'),(9,27,1,'N/A',11,10.99,'CONFIRMED'),(10,9,2,'add perroni',11,27.98,'CONFIRMED'),(11,19,2,'with some chilli',11,15.98,'CONFIRMED'),(12,24,1,'Extra cheese',11,11.99,'CONFIRMED'),(13,5,2,'N/A',12,21.98,'CONFIRMED'),(14,13,1,'N/A',11,10.99,'CONFIRMED'),(15,12,1,'N/A',11,9.99,'CONFIRMED'),(16,7,2,'N/A',13,33.98,'CONFIRMED'),(17,91,5,'N/A',13,49.95,'CONFIRMED'),(18,18,1,'N/A',13,9.99,'CONFIRMED'),(19,5,1,'N/A',13,10.99,'CONFIRMED'),(20,101,1,'N/A',14,300.99,'CONFIRMED');
/*!40000 ALTER TABLE `foodorders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `FoodId` int NOT NULL AUTO_INCREMENT,
  `FoodName` varchar(50) NOT NULL,
  `FoodDescription` varchar(255) NOT NULL,
  `FoodPrice` decimal(5,2) NOT NULL,
  `FoodRank` int NOT NULL DEFAULT '0',
  `CategoryId` int NOT NULL,
  `FoodStatus` enum('IN-STOCK','OUT-OF-ORDER') NOT NULL DEFAULT 'IN-STOCK',
  `picture` varchar(255) DEFAULT NULL,
  `MenuState` enum('DELETED','IN-SERVICE') NOT NULL DEFAULT 'IN-SERVICE',
  PRIMARY KEY (`FoodId`),
  KEY `CategoryId` (`CategoryId`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`CategoryId`) REFERENCES `categories` (`CategoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'Margherita Pizza','Tomato sauce, mozzarella, and basil',12.99,0,1,'IN-STOCK','pizza.jpg','IN-SERVICE'),(2,'Pepperoni Pizza','Tomato sauce, mozzarella, and pepperoni',13.99,0,1,'IN-STOCK','pizza.jpg','IN-SERVICE'),(3,'Hawaiian Pizza','Tomato sauce, mozzarella, ham, and pineapple',14.99,0,1,'IN-STOCK','pizza.jpg','IN-SERVICE'),(4,'Veggie Pizza','Tomato sauce, mozzarella, and assorted vegetables',11.99,0,1,'IN-STOCK','pizza.jpg','IN-SERVICE'),(5,'Cheese Pizza','Tomato sauce and extra cheese',10.99,0,1,'IN-STOCK','pizza.jpg','IN-SERVICE'),(6,'BBQ Chicken Pizza','BBQ sauce, mozzarella, chicken, and red onion',15.99,0,1,'IN-STOCK','pizza.jpg','IN-SERVICE'),(7,'Meat Lovers Pizza','Tomato sauce, mozzarella, and various meats',16.99,0,1,'IN-STOCK','pizza.jpg','IN-SERVICE'),(8,'Mushroom Pizza','Tomato sauce, mozzarella, and mushrooms',12.99,0,1,'IN-STOCK','pizza.jpg','IN-SERVICE'),(9,'Four Cheese Pizza','Tomato sauce and four types of cheese',13.99,0,1,'IN-STOCK','pizza.jpg','IN-SERVICE'),(10,'Seafood Pizza','Tomato sauce ,mozzarella ,and assorted seafood',17.99,0,1,'IN-STOCK','pizza.jpg','IN-SERVICE'),(11,'Caesar Salad','Romaine lettuce ,croutons ,parmesan cheese ,and caesar dressing',8.99,0,2,'OUT-OF-ORDER','salad.jpg','IN-SERVICE'),(12,'Greek Salad','Mixed greens ,tomatoes ,cucumbers ,olives ,feta cheese ,and greek dressing',9.99,0,2,'IN-STOCK','salad.jpg','IN-SERVICE'),(13,'Cobb Salad','Mixed greens ,chicken ,bacon ,egg ,avocado ,cheese ,and ranch dressing',10.99,0,2,'IN-STOCK','salad.jpg','IN-SERVICE'),(14,'Fruit Salad','Assorted fresh fruits with yogurt dressing',7.99,0,2,'IN-STOCK','salad.jpg','IN-SERVICE'),(15,'Waldorf Salad','Apples ,celery ,walnuts ,grapes ,and mayonnaise dressing',8.99,0,2,'IN-STOCK','salad.jpg','IN-SERVICE'),(16,'Spinach Salad','Spinach leaves ,strawberries ,almonds ,goat cheese ,and balsamic dressing',9.99,0,2,'IN-STOCK','salad.jpg','IN-SERVICE'),(17,'Taco Salad','Lettuce ,ground beef ,cheese ,tomatoes ,sour cream ,salsa ,and tortilla chips',11.99,0,2,'IN-STOCK','salad.jpg','IN-SERVICE'),(18,'Chicken Salad','Chicken breast ,celery ,mayonnaise ,and herbs served with bread or lettuce wraps',9.99,0,2,'IN-STOCK','salad.jpg','IN-SERVICE'),(19,'Potato Salad','Potatoes ,eggs ,onion ,celery ,mayonnaise ,and mustard dressing',7.99,0,2,'IN-STOCK','salad.jpg','IN-SERVICE'),(20,'Quinoa Salad','Quinoa grains ,chickpeas ,tomatoes ,cucumber ,parsley ,and lemon dressing',8.99,0,2,'IN-STOCK','salad.jpg','IN-SERVICE'),(21,'Spaghetti Bolognese','Spaghetti with meat sauce and parmesan cheese',12.99,0,3,'IN-STOCK','pasta.jpg','IN-SERVICE'),(22,'Lasagna','Layers of pasta ,cheese ,meat sauce ,and bechamel sauce baked in the oven',12.99,0,3,'IN-STOCK','pasta.jpg','IN-SERVICE'),(23,'Macaroni and Cheese','Macaroni pasta with creamy cheese sauce and breadcrumbs',9.99,0,3,'IN-STOCK','pasta.jpg','IN-SERVICE'),(24,'Fettuccine Alfredo','Fettuccine pasta with butter ,cream ,and parmesan cheese',11.99,0,3,'IN-STOCK','pasta.jpg','IN-SERVICE'),(25,'Penne Arrabbiata','Penne pasta with spicy tomato sauce and parsley',9.99,0,3,'IN-STOCK','pasta.jpg','IN-SERVICE'),(26,'Ravioli','Pasta pockets filled with cheese ,meat ,or vegetables and served with sauce',11.99,0,3,'IN-STOCK','pasta.jpg','IN-SERVICE'),(27,'Carbonara','Spaghetti with bacon ,egg ,cream ,and parmesan cheese',10.99,0,3,'IN-STOCK','pasta.jpg','IN-SERVICE'),(28,'Pesto Pasta','Pasta of your choice with basil pesto sauce and pine nuts',10.99,0,3,'IN-STOCK','pasta.jpg','IN-SERVICE'),(29,'Gnocchi','Potato dumplings with tomato sauce and cheese',10.99,0,3,'IN-STOCK','pasta.jpg','IN-SERVICE'),(30,'Linguine with Clams','Linguine pasta with clams in white wine sauce',13.99,0,3,'IN-STOCK','pasta.jpg','IN-SERVICE'),(31,'Chicken Tikka Masala','Chicken pieces cooked in a creamy tomato sauce with spices and rice',13.99,0,4,'IN-STOCK','indian.jpg','IN-SERVICE'),(32,'Butter Chicken','Chicken pieces cooked in a rich buttery sauce with spices and rice',13.99,0,4,'IN-STOCK','indian.jpg','IN-SERVICE'),(33,'Palak Paneer','Spinach puree with cottage cheese cubes and rice',11.99,0,4,'IN-STOCK','indian.jpg','IN-SERVICE'),(34,'Lamb Rogan Josh','Lamb chunks cooked in a spicy curry sauce and rice',14.99,0,4,'IN-STOCK','indian.jpg','IN-SERVICE'),(35,'Dal Makhani','Black lentils cooked with butter ,cream ,and spices and rice or naan bread',10.99,0,4,'IN-STOCK','indian.jpg','IN-SERVICE'),(36,'Aloo Gobi','Potatoes and cauliflower cooked with spices and rice or naan bread',9.99,0,4,'IN-STOCK','indian.jpg','IN-SERVICE'),(37,'Chana Masala','Chickpeas cooked with tomatoes ,onions ,and spices and rice or naan bread',9.99,0,4,'IN-STOCK','indian.jpg','IN-SERVICE'),(38,'Samosa','Fried pastry triangles filled with potatoes ,peas ,and spices served with chutney',6.99,0,4,'IN-STOCK','indian.jpg','IN-SERVICE'),(39,'Naan Bread','Flatbread baked in a clay oven and brushed with butter or garlic',2.99,0,4,'IN-STOCK','indian.jpg','IN-SERVICE'),(40,'Gulab Jamun','Deep-fried milk balls soaked in sugar syrup',5.99,0,4,'IN-STOCK','indian.jpg','IN-SERVICE'),(41,'Chocolate Cake','Moist chocolate cake with chocolate frosting and whipped cream',6.99,0,5,'OUT-OF-ORDER','dessert.jpg','IN-SERVICE'),(42,'Cheesecake','Creamy cheese cake with graham cracker crust and fruit topping',7.99,0,5,'IN-STOCK','dessert.jpg','IN-SERVICE'),(43,'Apple Pie','Flaky crust filled with sweet apple filling and topped with whipped cream',5.99,0,5,'IN-STOCK','dessert.jpg','IN-SERVICE'),(44,'Brownie','Fudgy chocolate brownie with nuts and chocolate chips',4.99,0,5,'IN-STOCK','dessert.jpg','IN-SERVICE'),(45,'Ice Cream','Vanilla ,chocolate ,or strawberry ice cream with toppings of your choice',4.99,0,5,'IN-STOCK','dessert.jpg','IN-SERVICE'),(46,'Carrot Cake','Spiced carrot cake with cream cheese frosting and walnuts',6.99,0,5,'IN-STOCK','dessert.jpg','IN-SERVICE'),(47,'Tiramisu','Italian dessert with layers of coffee-soaked ladyfingers and mascarpone cream',7.99,0,5,'IN-STOCK','dessert.jpg','IN-SERVICE'),(48,'Pancake','Fluffy pancakes with butter ,maple syrup ,and fruits',6.99,0,5,'IN-STOCK','dessert.jpg','IN-SERVICE'),(49,'Creme Brulee','Custard dessert with caramelized sugar crust',6.99,0,5,'IN-STOCK','dessert.jpg','IN-SERVICE'),(50,'Donut','Fried dough ring with glaze or filling of your choice',3.99,0,5,'IN-STOCK','dessert.jpg','IN-SERVICE'),(51,'Classic Burger','Beef patty with lettuce ,tomato ,onion ,cheese ,and ketchup on a bun',9.99,0,6,'IN-STOCK','burger.jpg','IN-SERVICE'),(52,'Bacon Cheeseburger','Beef patty with bacon ,cheese ,lettuce ,tomato ,onion ,and mayo on a bun',10.99,0,6,'IN-STOCK','burger.jpg','IN-SERVICE'),(53,'Veggie Burger','Vegetable patty with lettuce ,tomato ,onion ,cheese ,and mustard on a bun',8.99,0,6,'IN-STOCK','burger.jpg','IN-SERVICE'),(54,'Mushroom Swiss Burger','Beef patty with mushrooms ,swiss cheese ,lettuce ,tomato ,and mayo on a bun',10.99,0,6,'IN-STOCK','burger.jpg','IN-SERVICE'),(55,'Chicken Burger','Chicken breast with lettuce ,tomato ,onion ,cheese ,and BBQ sauce on a bun',9.99,0,6,'IN-STOCK','burger.jpg','IN-SERVICE'),(56,'Fish Burger','Fried fish fillet with lettuce ,tomato ,onion ,cheese ,and tartar sauce on a bun',9.99,0,6,'IN-STOCK','burger.jpg','IN-SERVICE'),(57,'Double Cheeseburger','Two beef patties with double cheese ,lettuce ,tomato ,onion ,and ketchup on a bun',11.99,0,6,'IN-STOCK','burger.jpg','IN-SERVICE'),(58,'Spicy Burger','Beef patty with jalapenos, pepper jack cheese, lettuce, tomato, onion, and hot sauce on a bun',10.99,0,6,'IN-STOCK','burger.jpg','IN-SERVICE'),(59,'Turkey Burger','Turkey patty with lettuce, tomato, onion, cheese, and cranberry sauce on a bun',9.99,0,6,'IN-STOCK','burger.jpg','IN-SERVICE'),(60,'Black Bean Burger','Black bean patty with lettuce, tomato, onion, cheese, and salsa on a bun',8.99,0,6,'IN-STOCK','burger.jpg','IN-SERVICE'),(61,'Ham and Cheese Sandwich','Sliced ham and cheese with lettuce ,tomato ,and mayo on bread of your choice',7.99,0,7,'IN-STOCK','sandwich.jpg','IN-SERVICE'),(62,'Turkey and Cranberry Sandwich','Sliced turkey and cranberry sauce with lettuce ,cheese ,and mayo on bread of your choice',7.99,0,7,'IN-STOCK','sandwich.jpg','IN-SERVICE'),(63,'BLT Sandwich','Bacon ,lettuce ,and tomato with mayo on toasted bread of your choice',6.99,0,7,'IN-STOCK','sandwich.jpg','IN-SERVICE'),(64,'Chicken Salad Sandwich','Chicken salad with celery ,mayonnaise ,and herbs on bread of your choice',7.99,0,7,'IN-STOCK','sandwich.jpg','IN-SERVICE'),(65,'Tuna Salad Sandwich','Tuna salad with celery ,mayonnaise ,and relish on bread of your choice',7.99,0,7,'IN-STOCK','sandwich.jpg','IN-SERVICE'),(66,'Egg Salad Sandwich','Egg salad with mayonnaise ,mustard ,and parsley on bread of your choice',6.99,0,7,'IN-STOCK','sandwich.jpg','IN-SERVICE'),(67,'Grilled Cheese Sandwich','Melted cheese on buttered bread of your choice',5.99,0,7,'IN-STOCK','sandwich.jpg','IN-SERVICE'),(68,'Peanut Butter and Jelly Sandwich','Peanut butter and jelly on bread of your choice',4.99,0,7,'IN-STOCK','sandwich.jpg','IN-SERVICE'),(69,'Club Sandwich','Three layers of bread with ham ,turkey ,bacon ,cheese ,lettuce ,tomato ,and mayo',8.99,0,7,'IN-STOCK','sandwich.jpg','IN-SERVICE'),(70,'Reuben Sandwich','Corned beef ,swiss cheese ,sauerkraut ,and thousand island dressing on rye bread',8.99,0,7,'IN-STOCK','sandwich.jpg','IN-SERVICE'),(71,'Tomato Soup','Creamy tomato soup with basil and croutons',5.99,0,8,'IN-STOCK','soup.jpg','IN-SERVICE'),(72,'Chicken Noodle Soup','Chicken broth with noodles ,chicken ,carrots ,celery ,and parsley',6.99,0,8,'IN-STOCK','soup.jpg','IN-SERVICE'),(73,'Minestrone Soup','Vegetable broth with beans ,pasta ,tomatoes ,and vegetables',5.99,0,8,'IN-STOCK','soup.jpg','IN-SERVICE'),(74,'Potato Leek Soup','Pureed potato and leek soup with cream and chives',6.99,0,8,'IN-STOCK','soup.jpg','IN-SERVICE'),(75,'French Onion Soup','Beef broth with caramelized onions ,bread ,and melted cheese',7.99,0,8,'IN-STOCK','soup.jpg','IN-SERVICE'),(76,'Mushroom Soup','Creamy mushroom soup with garlic and thyme',6.99,0,8,'IN-STOCK','soup.jpg','IN-SERVICE'),(77,'Broccoli Cheddar Soup','Creamy broccoli and cheddar cheese soup with bacon bits',6.99,0,8,'IN-STOCK','soup.jpg','IN-SERVICE'),(78,'Butternut Squash Soup','Pureed butternut squash soup with cream and nutmeg',6.99,0,8,'IN-STOCK','soup.jpg','IN-SERVICE'),(79,'Lentil Soup','Hearty lentil soup with carrots ,celery ,onion ,and spices',5.99,0,8,'IN-STOCK','soup.jpg','IN-SERVICE'),(80,'Clam Chowder','Creamy clam chowder with potatoes ,bacon ,and parsley',7.99,0,8,'IN-STOCK','soup.jpg','IN-SERVICE'),(81,'Sweet and Sour Chicken','Fried chicken pieces with pineapple ,peppers ,and sweet and sour sauce',11.99,0,9,'IN-STOCK','chinese.jpg','IN-SERVICE'),(82,'Beef and Broccoli','Stir-fried beef and broccoli with garlic and soy sauce',12.99,0,9,'IN-STOCK','chinese.jpg','IN-SERVICE'),(83,'Vegetable Fried Rice','Rice fried with eggs ,carrots ,peas ,corn ,and soy sauce',8.99,0,9,'IN-STOCK','chinese.jpg','IN-SERVICE'),(84,'Spring Rolls','Crispy rolls filled with cabbage ,carrots ,and vermicelli served with sweet chili sauce',6.99,0,9,'IN-STOCK','chinese.jpg','IN-SERVICE'),(85,'Kung Pao Chicken','Spicy chicken stir-fry with peanuts ,chilies ,and scallions',11.99,0,9,'IN-STOCK','chinese.jpg','IN-SERVICE'),(86,'Lo Mein','Soft noodles with vegetables and meat or seafood of your choice',10.99,0,9,'IN-STOCK','chinese.jpg','IN-SERVICE'),(87,'General Tso\'s Chicken','Fried chicken pieces with a sweet and spicy sauce',11.99,0,9,'IN-STOCK','chinese.jpg','IN-SERVICE'),(88,'Egg Drop Soup','Chicken broth with beaten eggs and scallions',4.99,0,9,'IN-STOCK','chinese.jpg','IN-SERVICE'),(89,'Dumplings','Steamed or fried dumplings filled with meat or vegetables served with dipping sauce',7.99,0,9,'IN-STOCK','chinese.jpg','IN-SERVICE'),(90,'Moo Shu Pork','Shredded pork with cabbage ,mushrooms ,and eggs wrapped in thin pancakes',12.99,0,9,'IN-STOCK','chinese.jpg','IN-SERVICE'),(91,'Tacos','Corn or flour tortillas with meat ,cheese ,lettuce ,tomato ,and salsa',9.99,0,10,'IN-STOCK','mexican.jpg','IN-SERVICE'),(92,'Burritos','Flour tortillas with rice ,beans ,meat ,cheese ,sour cream ,and salsa',10.99,0,10,'IN-STOCK','mexican.jpg','IN-SERVICE'),(93,'Nachos','Tortilla chips with cheese ,beans ,meat ,jalapenos ,sour cream ,and salsa',8.99,0,10,'IN-STOCK','mexican.jpg','IN-SERVICE'),(94,'Quesadillas','Grilled cheese tortillas with meat or vegetables and salsa',8.99,0,10,'IN-STOCK','mexican.jpg','IN-SERVICE'),(95,'Enchiladas','Corn tortillas filled with meat or cheese and covered with red or green sauce',11.99,0,10,'IN-STOCK','mexican.jpg','IN-SERVICE'),(96,'Fajitas','Sizzling strips of meat or vegetables with peppers ,onions ,and tortillas',12.99,0,10,'IN-STOCK','mexican.jpg','IN-SERVICE'),(97,'Chili Con Carne','Spicy stew of beef ,beans ,tomatoes ,and chili peppers',9.99,0,10,'IN-STOCK','mexican.jpg','IN-SERVICE'),(98,'Churros','Fried dough sticks coated with sugar and cinnamon served with chocolate sauce',5.99,0,10,'IN-STOCK','mexican.jpg','IN-SERVICE'),(99,'Flan','Caramel custard dessert',5.99,0,10,'IN-STOCK','mexican.jpg','IN-SERVICE'),(100,'Guacamole','Mashed avocado with onion, tomato, cilantro, and lime juice',6.99,0,10,'IN-STOCK','mexican.jpg','IN-SERVICE'),(101,'Aero Pizza','Pay Up',300.99,0,1,'IN-STOCK',NULL,'IN-SERVICE'),(102,'Mubora','vegetables with a Zimbabwean Twist',10.50,0,11,'IN-STOCK',NULL,'IN-SERVICE');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderstable`
--

DROP TABLE IF EXISTS `orderstable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderstable` (
  `OrderId` int NOT NULL AUTO_INCREMENT,
  `CustomerId` int NOT NULL,
  `EmployeeId` varchar(10) NOT NULL,
  `TableId` int NOT NULL,
  `Charge` float NOT NULL DEFAULT '0',
  `DateInit` date NOT NULL,
  `TimeInit` time NOT NULL,
  `OrderStatus` enum('CURRENT','IN-PROGRESS','FINISHED','CANCELLED') NOT NULL DEFAULT 'CURRENT',
  PRIMARY KEY (`OrderId`),
  KEY `CustomerId` (`CustomerId`),
  KEY `TableId` (`TableId`),
  CONSTRAINT `orderstable_ibfk_1` FOREIGN KEY (`CustomerId`) REFERENCES `customers` (`CustomerId`),
  CONSTRAINT `orderstable_ibfk_2` FOREIGN KEY (`TableId`) REFERENCES `tables` (`TableId`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderstable`
--

LOCK TABLES `orderstable` WRITE;
/*!40000 ALTER TABLE `orderstable` DISABLE KEYS */;
INSERT INTO `orderstable` VALUES (9,7,'1',9,0,'2023-08-11','18:08:49','CANCELLED'),(10,8,'1',14,0,'2023-08-12','18:32:13','IN-PROGRESS'),(11,7,'1',9,0,'2023-08-13','20:37:18','IN-PROGRESS'),(12,12,'1',10,0,'2023-08-20','11:37:58','FINISHED'),(13,7,'1',9,0,'2023-08-22','19:13:18','CURRENT'),(14,12,'1',10,0,'2023-09-08','16:03:51','CURRENT');
/*!40000 ALTER TABLE `orderstable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tableclass`
--

DROP TABLE IF EXISTS `tableclass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tableclass` (
  `ClassId` smallint NOT NULL AUTO_INCREMENT,
  `ClassName` varchar(1) NOT NULL DEFAULT 'F',
  `ClassFee` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ClassId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tableclass`
--

LOCK TABLES `tableclass` WRITE;
/*!40000 ALTER TABLE `tableclass` DISABLE KEYS */;
INSERT INTO `tableclass` VALUES (7,'A',200),(8,'B',150),(9,'C',100),(10,'D',50),(11,'E',23),(12,'F',0);
/*!40000 ALTER TABLE `tableclass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tables`
--

DROP TABLE IF EXISTS `tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tables` (
  `TableId` int NOT NULL AUTO_INCREMENT,
  `ClassId` smallint NOT NULL,
  `TableSits` smallint NOT NULL DEFAULT '2',
  `TableState` enum('IN-SERVICE','OUT-OF-SERVICE') NOT NULL DEFAULT 'IN-SERVICE',
  PRIMARY KEY (`TableId`),
  KEY `ClassId` (`ClassId`),
  CONSTRAINT `tables_ibfk_2` FOREIGN KEY (`ClassId`) REFERENCES `tableclass` (`ClassId`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tables`
--

LOCK TABLES `tables` WRITE;
/*!40000 ALTER TABLE `tables` DISABLE KEYS */;
INSERT INTO `tables` VALUES (9,8,4,'IN-SERVICE'),(10,9,3,'IN-SERVICE'),(11,12,2,'IN-SERVICE'),(12,10,2,'IN-SERVICE'),(13,10,6,'IN-SERVICE'),(14,8,2,'IN-SERVICE'),(15,9,4,'IN-SERVICE'),(16,11,2,'IN-SERVICE'),(17,10,4,'IN-SERVICE'),(23,9,4,'IN-SERVICE'),(25,7,2,'IN-SERVICE'),(26,12,4,'IN-SERVICE'),(27,7,3,'IN-SERVICE');
/*!40000 ALTER TABLE `tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timetable`
--

DROP TABLE IF EXISTS `timetable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timetable` (
  `tinme` date NOT NULL,
  `daate` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timetable`
--

LOCK TABLES `timetable` WRITE;
/*!40000 ALTER TABLE `timetable` DISABLE KEYS */;
INSERT INTO `timetable` VALUES ('2023-08-06','10:12:59');
/*!40000 ALTER TABLE `timetable` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-11 13:18:17
