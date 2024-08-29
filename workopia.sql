/*
Navicat MySQL Data Transfer

Source Server         : home
Source Server Version : 80030
Source Host           : localhost:3306
Source Database       : workopia

Target Server Type    : MYSQL
Target Server Version : 80030
File Encoding         : 65001

Date: 2024-08-29 22:03:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `listings`
-- ----------------------------
DROP TABLE IF EXISTS `listings`;
CREATE TABLE `listings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext,
  `salary` varchar(45) DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `company` varchar(45) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `requirements` longtext,
  `benefits` longtext,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_listings_users_idx` (`user_id`),
  CONSTRAINT `fk_listings_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of listings
-- ----------------------------
INSERT INTO `listings` VALUES ('1', '1', 'Software Engineer', 'We are seeking a skilled software engineer to develop high-quality software solutions', '90000', 'development, coding, java, python', 'Tech Solutions Inc.', '123 Main St', 'Albany', 'NY', '348-334-3949', 'info@techsolutions.com', 'Bachelors degree in Computer Science or related field, 3+ years of software development experience', 'Healthcare, 401(k) matching, flexible work hours', '2023-11-18 14:04:36');
INSERT INTO `listings` VALUES ('2', '2', 'Marketing Specialist', 'Lorem ipsum dolor sit amet consectetur adipiscing elit varius vestibulum dui, suspendisse netus hac etiam fringilla fermentum', '80000', 'marketing, advertising', 'Marketing Pros', '123 Market St', 'San Francisco', 'CA', '454-344-3344', 'info@marketingpros.com', 'Bachelors degree in Marketing or related field, experience in digital marketing', 'Health and dental insurance, paid time off, remote work options', '2023-11-18 14:06:33');
INSERT INTO `listings` VALUES ('3', '3', 'Web Developer', 'Join our team as a Web Developer and create amazing web applications', '85000', 'web development, programming', 'WebTech Solutions', '789 Web Ave', 'Chicago', 'IL', '456-876-5432', 'info@webtechsolutions.com', 'Bachelors degree in Computer Science or related field, proficiency in HTML, CSS, JavaScript', 'Competitive salary, professional development opportunities, friendly work environment', '2023-11-18 14:08:44');
INSERT INTO `listings` VALUES ('4', '1', 'Data Analyst', 'We are hiring a Data Analyst to analyze and interpret data for insights', '75000', 'data analysis, statistics', 'Data Insights LLC', '101 Data St', 'Chicago', 'IL', '444-555-5555', 'info@datainsights.com', 'Bachelors degree in Data Science or related field, strong analytical skills', 'Health benefits, remote work options, casual dress code', '2023-11-18 14:11:55');
INSERT INTO `listings` VALUES ('5', '2', 'Graphic Designer', 'Join our creative team as a Graphic Designer and bring ideas to life', '70000', 'graphic design, creative', 'CreativeWorks Inc', '234 Design Blvd', 'Albany', 'NY', '499-321-9876', 'info@creativeworks.com', 'Bachelors degree in Graphic Design or related field, proficiency in Adobe Creative Suite', 'Flexible work hours, creative work environment, opportunities for growth', '2023-11-18 14:13:35');
INSERT INTO `listings` VALUES ('7', '1', 'Frontend Web Developer', 'This is a frontend position working with React', '70000', 'frontend, development', 'Traversy Media', '10 main st', 'Boston', 'MA', '555-555-5555', 'info@test.com', 'Bachelors degree', '401K and Health insurance', '2023-11-21 14:07:24');
INSERT INTO `listings` VALUES ('28', '9', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test@gmail.com', 'test', 'test', '2024-08-29 20:26:00');

-- ----------------------------
-- Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', 'John Doe', 'user1@gmail.com', '$2y$10$UkdJDaWLRHPVwOu3lb9XW.FZWZmFaLM0BJbaj0/7dvPIqs7sdDlvK', 'Boston', 'MA', '2023-11-18 13:55:59');
INSERT INTO `users` VALUES ('2', 'Jane Doe', 'user2@gmail.com', '$2y$10$UkdJDaWLRHPVwOu3lb9XW.FZWZmFaLM0BJbaj0/7dvPIqs7sdDlvK', 'San Francisco', 'CA', '2023-11-18 13:58:26');
INSERT INTO `users` VALUES ('3', 'Steve Smith', 'user3@gmail.com', '$2y$10$UkdJDaWLRHPVwOu3lb9XW.FZWZmFaLM0BJbaj0/7dvPIqs7sdDlvK', 'Chicago', 'IL', '2023-11-18 13:59:13');
INSERT INTO `users` VALUES ('7', 'Humayun Ahmed', 'humayun@gmail.com', '$2y$10$Kwj8QDWVu90ks3DAu1qfS.ExoWh.pno98S8KkUwDPfhE9zg7IL7XK', 'karachi', 'sindh', '2024-08-22 20:43:50');
INSERT INTO `users` VALUES ('8', 'Ahmed', 'iamhumayun4@gmail.com', '$2y$10$0iKCyPPE73xX1gQTM8xXBu4i4KRE4CRLYbzmlCjund0OcxxVxI3ji', 'karachi', 'sindh', '2024-08-22 20:44:48');
INSERT INTO `users` VALUES ('9', 'Humayun Ahmed', 'iamhumayun4555@gmail.com', '$2y$10$ceAHKfKjN0/8S388LOT6/Owz4VxtivMnxY.9rLql54wdYV4V9OERS', 'karachi', 'sindh', '2024-08-27 20:33:48');
