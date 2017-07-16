/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50508
Source Host           : 127.0.0.1:3306
Source Database       : db_movie

Target Server Type    : MYSQL
Target Server Version : 50508
File Encoding         : 65001

Date: 2017-07-16 10:15:41
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `adminId` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `adminName` varchar(20) NOT NULL COMMENT '管理员名',
  `password` varchar(40) NOT NULL COMMENT '密码',
  `email` varchar(20) NOT NULL COMMENT '电子邮箱',
  `mobile` varchar(20) NOT NULL COMMENT '电话',
  `extra` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`adminId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', '21232f297a57a5a743894a0e4a801fc3', '123456@gmail.com', '1332342155', '超级管理');

-- ----------------------------
-- Table structure for cinema
-- ----------------------------
DROP TABLE IF EXISTS `cinema`;
CREATE TABLE `cinema` (
  `cinemaId` int(10) NOT NULL AUTO_INCREMENT,
  `number` varchar(40) NOT NULL COMMENT '电影院编号',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '电影院名字',
  `address` varchar(100) NOT NULL DEFAULT '' COMMENT '电影院地址',
  PRIMARY KEY (`cinemaId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cinema
-- ----------------------------
INSERT INTO `cinema` VALUES ('2', 'cs0010003', 'MC影城（奥莱店）', '湖南省长沙市雨花区奥特莱斯');
INSERT INTO `cinema` VALUES ('3', 'ah312039', '万达影城（合肥蜀山区）', '安徽省合肥市蜀山区');
INSERT INTO `cinema` VALUES ('5', 'sh263871263', '中影', '皇后大道东');
INSERT INTO `cinema` VALUES ('8', 'bj7364728', '大地影院', '北京中南海');

-- ----------------------------
-- Table structure for movie
-- ----------------------------
DROP TABLE IF EXISTS `movie`;
CREATE TABLE `movie` (
  `movieId` int(10) NOT NULL AUTO_INCREMENT,
  `number` varchar(40) NOT NULL COMMENT '电影编号',
  `name` varchar(40) NOT NULL COMMENT '电影名称',
  `time` varchar(4) NOT NULL COMMENT '电影时长',
  `status` varchar(1) NOT NULL DEFAULT '0' COMMENT '电影状态   0:未上映  1:正在上映  2:已下线',
  `introduce` varchar(100) NOT NULL COMMENT '电影简介',
  PRIMARY KEY (`movieId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of movie
-- ----------------------------
INSERT INTO `movie` VALUES ('4', 'japan2317', '嫌疑人X的献身', '151', '0', '好看的电影');
INSERT INTO `movie` VALUES ('5', 'us373273', '速度与激情7', '134', '2', '音乐很好听音乐很好听音乐很好听音乐很好听音乐很好听音乐很好听音乐很好听');
INSERT INTO `movie` VALUES ('6', 'china637261', '追凶者也', '2000', '0', 'enen');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `orderId` int(10) NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `userId` int(10) NOT NULL COMMENT '用户编号',
  `scheduleId` int(10) NOT NULL COMMENT '电影编号',
  `amount` int(3) NOT NULL COMMENT '数量',
  `address` varchar(40) NOT NULL COMMENT '用户住址',
  `mobile` varchar(20) NOT NULL COMMENT '用户电话',
  `status` varchar(1) NOT NULL DEFAULT '0' COMMENT '订单状态 1:待处理  2:已确认   3:已完成  0:已取消  -1:已删除',
  `extra` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`orderId`),
  KEY `用户id` (`userId`),
  KEY `scheduleId` (`scheduleId`),
  CONSTRAINT `用户id` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON UPDATE CASCADE,
  CONSTRAINT `scheduleId` FOREIGN KEY (`scheduleId`) REFERENCES `schedule` (`scheduleId`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('26', '1', '1', '22', '长沙', '162723221', '1', 'ss');
INSERT INTO `orders` VALUES ('27', '1', '3', '2', '长沙理工大学', '1728334', '2', '无');
INSERT INTO `orders` VALUES ('28', '1', '4', '1', '长沙理工', '172837362', '1', '无');
INSERT INTO `orders` VALUES ('29', '1', '3', '10', '中南大学', '273821121', '1', '略');
INSERT INTO `orders` VALUES ('30', '1', '3', '10', '长沙理工', '1723662', '2', '略');
INSERT INTO `orders` VALUES ('31', '1', '3', '3', '长沙理工', '172637261', '1', '略');
INSERT INTO `orders` VALUES ('32', '1', '1', '3', '湖南师范', '162736271', '1', '嗯');
INSERT INTO `orders` VALUES ('33', '1', '3', '4', '长沙理工', '162712', '1', '无');

-- ----------------------------
-- Table structure for schedule
-- ----------------------------
DROP TABLE IF EXISTS `schedule`;
CREATE TABLE `schedule` (
  `scheduleId` int(10) NOT NULL AUTO_INCREMENT,
  `cinemaId` int(10) NOT NULL COMMENT '电影院编号',
  `movieId` int(10) NOT NULL COMMENT '电影编号',
  `startTime` datetime NOT NULL COMMENT '开始时间',
  `money` varchar(10) DEFAULT NULL,
  `seat` int(4) NOT NULL COMMENT '座位数',
  `reservation` int(4) NOT NULL DEFAULT '0' COMMENT '预订数',
  PRIMARY KEY (`scheduleId`),
  KEY `电影院编号` (`cinemaId`),
  KEY `电影编号` (`movieId`),
  CONSTRAINT `电影编号` FOREIGN KEY (`movieId`) REFERENCES `movie` (`movieId`) ON UPDATE CASCADE,
  CONSTRAINT `电影院编号` FOREIGN KEY (`cinemaId`) REFERENCES `cinema` (`cinemaId`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of schedule
-- ----------------------------
INSERT INTO `schedule` VALUES ('1', '2', '4', '2017-06-24 10:16:52', null, '122', '25');
INSERT INTO `schedule` VALUES ('3', '8', '5', '2017-06-29 01:05:00', null, '222', '29');
INSERT INTO `schedule` VALUES ('4', '2', '4', '2017-06-30 09:25:00', null, '11', '1');
INSERT INTO `schedule` VALUES ('5', '2', '4', '2017-07-01 08:25:00', null, '123', '0');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userId` int(10) NOT NULL AUTO_INCREMENT,
  `userName` varchar(40) NOT NULL COMMENT '用户名',
  `password` varchar(40) NOT NULL COMMENT '密码',
  `email` varchar(20) NOT NULL COMMENT '电子邮箱',
  `mobile` varchar(20) NOT NULL COMMENT '电话',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'user', 'ee11cbb19052e40b07aac0ca060c23ee', 'dhsaj@qq.com', '31212312333');
INSERT INTO `user` VALUES ('4', 'userr', '7dc715960b177f323db34eacd63048f7', 'qeuoi@qq.com', '21273');
INSERT INTO `user` VALUES ('5', 'userrr', '21232f297a57a5a743894a0e4a801fc3', 'a', 'a');
