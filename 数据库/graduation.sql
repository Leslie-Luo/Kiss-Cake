/*
 Navicat Premium Data Transfer

 Source Server         : Localhost
 Source Server Type    : MySQL
 Source Server Version : 50638
 Source Host           : localhost:3306
 Source Schema         : graduation

 Target Server Type    : MySQL
 Target Server Version : 50638
 File Encoding         : 65001

 Date: 09/04/2018 10:06:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `username` varchar(32) COLLATE utf8_bin NOT NULL,
  `phone` text COLLATE utf8_bin NOT NULL,
  `city` int(11) NOT NULL COMMENT '市',
  `district` int(11) NOT NULL COMMENT '区',
  `address` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '具体地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of address
-- ----------------------------
BEGIN;
INSERT INTO `address` VALUES (2, 1, 'Leslie', '18144207352', 4, 3, '天益街83号');
INSERT INTO `address` VALUES (3, 1, '大块头TVT', '18144207352', 4, 3, '天益街83号');
COMMIT;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) COLLATE utf8_bin NOT NULL,
  `password` varchar(32) COLLATE utf8_bin NOT NULL,
  `type` varchar(11) COLLATE utf8_bin NOT NULL DEFAULT 'admin',
  `region` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of admin
-- ----------------------------
BEGIN;
INSERT INTO `admin` VALUES (1, 'Admin', '453e41d218e071ccfb2d1c99ce23906a', 'Surper', 0);
INSERT INTO `admin` VALUES (2, 'Leslie', '453e41d218e071ccfb2d1c99ce23906a', 'Surper', 0);
INSERT INTO `admin` VALUES (3, 'shanghai', '453e41d218e071ccfb2d1c99ce23906a', 'admin', 1);
INSERT INTO `admin` VALUES (4, 'nanjing', '453e41d218e071ccfb2d1c99ce23906a', 'admin', 2);
INSERT INTO `admin` VALUES (5, 'shenzhen', '453e41d218e071ccfb2d1c99ce23906a', 'admin', 3);
INSERT INTO `admin` VALUES (6, 'beijing', '453e41d218e071ccfb2d1c99ce23906a', 'admin', 4);
INSERT INTO `admin` VALUES (7, 'chengdu', '453e41d218e071ccfb2d1c99ce23906a', 'admin', 5);
INSERT INTO `admin` VALUES (8, 'hangzhou', 'e10adc3949ba59abbe56e057f20f883e', 'admin', 6);
COMMIT;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `banner` varchar(322) NOT NULL,
  `infodata` varchar(322) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article
-- ----------------------------
BEGIN;
INSERT INTO `article` VALUES (1, 'image/1515481463/banner-0.jpg,image/1515481463/banner-1.jpg,image/1515481463/banner-2.jpg,image/1515481463/banner-3.jpg', 'image/1515481463/CakeInfoData-0.jpg,image/1515481463/CakeInfoData-1.jpg,image/1515481463/CakeInfoData-2.jpg,image/1515481463/CakeInfoData-3.jpg');
INSERT INTO `article` VALUES (2, 'image/1515505482/banner-0.jpg,image/1515505482/banner-1.jpg,image/1515505482/banner-2.jpg', 'image/1515505482/CakeInfoData-0.jpg,image/1515505482/CakeInfoData-1.jpg,image/1515505482/CakeInfoData-2.jpg,image/1515505482/CakeInfoData-3.jpg');
INSERT INTO `article` VALUES (3, 'image/1515986757/banner-0.jpg,image/1515986757/banner-1.jpg,image/1515986757/banner-2.jpg', 'image/1515986757/CakeInfoData-0.jpg,image/1515986757/CakeInfoData-1.jpg,image/1515986757/CakeInfoData-2.jpg,image/1515986757/CakeInfoData-3.jpg,image/1515986757/CakeInfoData-4.jpg');
INSERT INTO `article` VALUES (4, 'image/1516073419/banner-0.jpg,image/1516073419/banner-1.jpg,image/1516073419/banner-2.jpg', 'image/1516073419/CakeInfoData-0.jpg,image/1516073419/CakeInfoData-1.jpg,image/1516073419/CakeInfoData-2.jpg,image/1516073419/CakeInfoData-3.jpg,image/1516073419/CakeInfoData-4.jpg');
INSERT INTO `article` VALUES (5, 'image/1517324871/banner-0.jpg,image/1517324871/banner-1.jpg,image/1517324871/banner-2.jpg', 'image/1517324871/CakeInfoData-0.jpg,image/1517324871/CakeInfoData-1.jpg');
INSERT INTO `article` VALUES (6, 'image/1518162191/banner-0.jpg,image/1518162191/banner-1.jpg,image/1518162191/banner-2.jpg,image/1518162191/banner-3.jpg', 'image/1518162191/CakeInfoData-0.jpg,image/1518162191/CakeInfoData-1.jpg,image/1518162191/CakeInfoData-2.jpg,image/1518162191/CakeInfoData-3.jpg,image/1518162191/CakeInfoData-4.jpg');
INSERT INTO `article` VALUES (7, 'image/1518165247/banner-0.jpg,image/1518165247/banner-1.jpg,image/1518165247/banner-2.jpg,image/1518165247/banner-3.jpg', 'image/1518165247/CakeInfoData-0.jpg,image/1518165247/CakeInfoData-1.jpg,image/1518165247/CakeInfoData-2.jpg,image/1518165247/CakeInfoData-3.jpg,image/1518165247/CakeInfoData-4.jpg,image/1518165247/CakeInfoData-5.jpg');
INSERT INTO `article` VALUES (8, 'image/1520302978/banner-0.jpg,image/1520302978/banner-1.jpg,image/1520302978/banner-2.jpg,image/1520302978/banner-3.jpg', 'image/1520302978/CakeInfoData-0.jpg,image/1520302978/CakeInfoData-1.jpg,image/1520302978/CakeInfoData-2.jpg,image/1520302978/CakeInfoData-3.jpg');
INSERT INTO `article` VALUES (9, 'image/1520479299/banner-0.jpg,image/1520479299/banner-1.jpg,image/1520479299/banner-2.jpg,image/1520479299/banner-3.jpg', 'image/1520479299/CakeInfoData-0.jpg,image/1520479299/CakeInfoData-1.jpg,image/1520479299/CakeInfoData-2.jpg,image/1520479299/CakeInfoData-3.jpg,image/1520479299/CakeInfoData-4.jpg');
COMMIT;

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(322) NOT NULL,
  `cakeID` varchar(11) NOT NULL,
  `name` varchar(322) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of banner
-- ----------------------------
BEGIN;
INSERT INTO `banner` VALUES (2, 'image/banner/1520299683.png', '4', '花格');
INSERT INTO `banner` VALUES (3, 'image/banner/1520299920.png', '6', '风乍起');
INSERT INTO `banner` VALUES (5, 'image/banner/1520302639.png', '7', '杏仁克鲁兹');
COMMIT;

-- ----------------------------
-- Table structure for cakeorder
-- ----------------------------
DROP TABLE IF EXISTS `cakeorder`;
CREATE TABLE `cakeorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `foods` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '购买商品',
  `spec` varchar(32) COLLATE utf8_bin NOT NULL,
  `num` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '数量',
  `city` int(11) NOT NULL COMMENT '城市',
  `district` int(11) NOT NULL COMMENT '区域',
  `address` varchar(322) COLLATE utf8_bin NOT NULL COMMENT '具体地址',
  `total` int(11) NOT NULL COMMENT '总价',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `state` int(11) NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of cakeorder
-- ----------------------------
BEGIN;
INSERT INTO `cakeorder` VALUES (1, 1, '7', '2', '1', 4, 3, '天益街83号', 298, '2018-03-14 15:03:22', 0);
INSERT INTO `cakeorder` VALUES (2, 1, '2,3,4', '3,2,3', '1,1,2', 4, 3, '天益街83号', 1573, '2018-03-14 15:03:19', 1);
INSERT INTO `cakeorder` VALUES (3, 1, '6,2', '1,2', '1,1', 4, 3, '天益街83号', 596, '2018-03-14 19:03:51', 0);
INSERT INTO `cakeorder` VALUES (4, 1, '2', '5', '1', 1, 1, '18144207352', 398, '2018-03-15 10:03:41', 0);
COMMIT;

-- ----------------------------
-- Table structure for foods
-- ----------------------------
DROP TABLE IF EXISTS `foods`;
CREATE TABLE `foods` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8_bin NOT NULL,
  `type` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '种类',
  `default_price` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '单价',
  `taste` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '口味',
  `tag` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '标签',
  `spec` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '规格（大小/价格）',
  `iconimg` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '主图片地址',
  `online` int(1) NOT NULL DEFAULT '0',
  `articleid` int(11) NOT NULL,
  `catalog` int(32) NOT NULL COMMENT '文件目录',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of foods
-- ----------------------------
BEGIN;
INSERT INTO `foods` VALUES (1, '黑森林', '1', '48-16', '8,7,5,9,42', '13,10,14', '47-15,48-16,49-17,52-18', 'image/1515481463/iconimg-0.jpg', 0, 1, 1515481463);
INSERT INTO `foods` VALUES (2, '芒果奶油蛋糕', '1', '19-16', '5,42,7', '12,10', '19-16,47-17,48-18', 'image/1515505482/iconimg-0.png', 0, 2, 1515505482);
INSERT INTO `foods` VALUES (3, '新卡', '1', '47-15', '5,43,7', '13,10,11', '47-15,53-16,49-17,50-18', 'image/1515986757/iconimg-0.jpg', 0, 3, 0);
INSERT INTO `foods` VALUES (4, '花格', '1', '20-16', '5,42', '11,13,10', '19-15,20-16,21-17,54-18', 'image/1516073419/iconimg-0.jpg', 0, 4, 0);
INSERT INTO `foods` VALUES (5, '黑白巧克力慕斯（彼尔德）', '1', '19-15', '5,6,8', '12,13,14', '19-15,20-16', 'image/1517324871/iconimg-0.jpg', 0, 5, 0);
INSERT INTO `foods` VALUES (6, '风乍起', '1', '48-15', '5,8,6', '11,12,13', '48-15', 'image/1518162191/iconimg-0.jpg', 0, 6, 0);
INSERT INTO `foods` VALUES (7, '杏仁克鲁兹', '1', '20-16', '5,9,7', '10,11,13', '19-15,20-16,21-17,54-18', 'image/1518165247/iconimg-0.jpg', 0, 7, 0);
INSERT INTO `foods` VALUES (8, '心语心愿', '1', '20-16', '8,42,5', '12,11,10', '20-16,21-17,54-18', 'image/1520302978/iconimg-0.jpg', 0, 8, 0);
INSERT INTO `foods` VALUES (9, '榴莲飘飘', '1', '20-16', '42,8,5,6', '13,11', '19-15,20-16,21-17,54-18', 'image/1520479299/iconimg-0.jpg', 0, 9, 0);
COMMIT;

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `taste` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `tag` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of type
-- ----------------------------
BEGIN;
INSERT INTO `type` VALUES (1, '蛋糕', NULL, NULL, NULL, NULL);
INSERT INTO `type` VALUES (2, '冰淇淋', NULL, NULL, NULL, NULL);
INSERT INTO `type` VALUES (3, '小切块', NULL, NULL, NULL, NULL);
INSERT INTO `type` VALUES (4, '常温蛋糕', NULL, NULL, NULL, NULL);
INSERT INTO `type` VALUES (5, NULL, '全脂奶油', NULL, NULL, NULL);
INSERT INTO `type` VALUES (6, NULL, '慕斯', NULL, NULL, NULL);
INSERT INTO `type` VALUES (7, NULL, '乳酪', NULL, NULL, NULL);
INSERT INTO `type` VALUES (8, NULL, '巧克力', NULL, NULL, NULL);
INSERT INTO `type` VALUES (9, NULL, '坚果', NULL, NULL, NULL);
INSERT INTO `type` VALUES (10, NULL, NULL, '新品', NULL, NULL);
INSERT INTO `type` VALUES (11, NULL, NULL, '人气', NULL, NULL);
INSERT INTO `type` VALUES (12, NULL, NULL, '情侣', NULL, NULL);
INSERT INTO `type` VALUES (13, NULL, NULL, '聚会', NULL, NULL);
INSERT INTO `type` VALUES (14, NULL, NULL, '童趣', NULL, NULL);
INSERT INTO `type` VALUES (15, NULL, NULL, NULL, 1, NULL);
INSERT INTO `type` VALUES (16, NULL, NULL, NULL, 2, NULL);
INSERT INTO `type` VALUES (17, NULL, NULL, NULL, 3, NULL);
INSERT INTO `type` VALUES (18, NULL, NULL, NULL, 5, NULL);
INSERT INTO `type` VALUES (19, NULL, NULL, NULL, NULL, 198);
INSERT INTO `type` VALUES (20, NULL, NULL, NULL, NULL, 298);
INSERT INTO `type` VALUES (21, NULL, NULL, NULL, NULL, 458);
INSERT INTO `type` VALUES (22, NULL, NULL, NULL, NULL, 790);
INSERT INTO `type` VALUES (41, NULL, NULL, NULL, NULL, 55);
INSERT INTO `type` VALUES (42, NULL, '水果', NULL, NULL, NULL);
INSERT INTO `type` VALUES (43, NULL, '咖啡', NULL, NULL, NULL);
INSERT INTO `type` VALUES (44, NULL, '冰淇淋', NULL, NULL, NULL);
INSERT INTO `type` VALUES (46, NULL, NULL, NULL, NULL, 990);
INSERT INTO `type` VALUES (47, NULL, NULL, NULL, NULL, 268);
INSERT INTO `type` VALUES (48, NULL, NULL, NULL, NULL, 398);
INSERT INTO `type` VALUES (49, NULL, NULL, NULL, NULL, 598);
INSERT INTO `type` VALUES (50, NULL, NULL, NULL, NULL, 958);
INSERT INTO `type` VALUES (53, NULL, NULL, NULL, NULL, 389);
INSERT INTO `type` VALUES (54, NULL, NULL, NULL, NULL, 750);
INSERT INTO `type` VALUES (55, NULL, NULL, '长辈', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(32) COLLATE utf8_bin NOT NULL,
  `phone` varchar(11) COLLATE utf8_bin NOT NULL,
  `email` varchar(32) COLLATE utf8_bin NOT NULL,
  `header` varchar(322) COLLATE utf8_bin DEFAULT '1' COMMENT '头像',
  `regtime` date NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (1, 'Leslie', '453e41d218e071ccfb2d1c99ce23906a', '18144207352', '921110219@qq.com', 'image/header/1520905443.png', '2018-03-05');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
