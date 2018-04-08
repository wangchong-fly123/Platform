/*
Navicat MySQL Data Transfer

Source Server         : 103
Source Server Version : 50630
Source Host           : localhost:3306
Source Database       : sanguo_web

Target Server Type    : MYSQL
Target Server Version : 50630
File Encoding         : 65001

Date: 2017-05-23 17:03:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for app_hero_categories
-- ----------------------------
DROP TABLE IF EXISTS `app_hero_categories`;
CREATE TABLE `app_hero_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `image` varchar(128) DEFAULT NULL,
  `order_num` int(11) DEFAULT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `tree` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of app_hero_categories
-- ----------------------------
INSERT INTO `app_hero_categories` VALUES ('2', '英雄列表', '', '1', null, '2', '1', '2', '0', '1');

-- ----------------------------
-- Table structure for app_Hero_categories
-- ----------------------------
DROP TABLE IF EXISTS `app_Hero_categories`;
CREATE TABLE `app_Hero_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `image` varchar(128) DEFAULT NULL,
  `order_num` int(11) DEFAULT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `tree` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of app_Hero_categories
-- ----------------------------

-- ----------------------------
-- Table structure for app_hero_items
-- ----------------------------
DROP TABLE IF EXISTS `app_hero_items`;
CREATE TABLE `app_hero_items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `hero_name` varchar(128) NOT NULL,
  `head` varchar(128) DEFAULT NULL,
  `bg_image` varchar(128) DEFAULT NULL,
  `attribute_image` varchar(128) DEFAULT NULL,
  `hero_intro` varchar(1024) DEFAULT NULL,
  `skill_intro` text NOT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `time` int(11) DEFAULT '0',
  `views` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of app_hero_items
-- ----------------------------
INSERT INTO `app_hero_items` VALUES ('2', '2', '诸葛亮', '/uploads/hero/hero01-149696b13d.jpg', '/uploads/hero/hero-info03-6f1feb836a.png', '/uploads/hero/hero-info02-1-472d169845.png', '<p>五虎上将之二，勇猛刚强、喝退百万曹军，圆眼一旦怒睁，便是敌军魂断矛下之时！</p>', '<p>狂风弑化身狂风向前横扫目标，对目标造成伤害。</p><p>狂风弑化身狂风向前横扫目标，对目标造成伤害。</p><p>狂风弑化身狂风向前横扫目标，对目标造成伤害。</p>', null, '1493024321', '0', '1');
INSERT INTO `app_hero_items` VALUES ('3', '2', '张飞', '/uploads/hero/hero02-1-93f7eab26c.jpg', '/uploads/hero/hero-info01-20ede6c06a.png', '/uploads/hero/hero-info02-7a2f0baa9d.png', '<p>五虎上将之二，勇猛刚强、喝退百万曹军，圆眼一旦怒睁，便是敌军魂断矛下之时！</p><p>五虎上将之二，勇猛刚强、喝退百万曹军，圆眼一旦怒睁，便是敌军魂断矛下之时！</p>', '<p>狂风弑化身狂风向前横扫目标，对目标造成伤害。</p><p>狂风弑化身狂风向前横扫目标，对目标造成伤害。</p><p>狂风弑化身狂风向前横扫目标，对目标造成伤害。</p><p>狂风弑化身狂风向前横扫目标，对目标造成伤害。</p><p>狂风弑化身狂风向前横扫目标，对目标造成伤害。</p>', null, '1493024715', '0', '1');

-- ----------------------------
-- Table structure for app_Hero_items
-- ----------------------------
DROP TABLE IF EXISTS `app_Hero_items`;
CREATE TABLE `app_Hero_items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(128) NOT NULL,
  `image` varchar(128) DEFAULT NULL,
  `short` varchar(1024) DEFAULT NULL,
  `text` text NOT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `time` int(11) DEFAULT '0',
  `views` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of app_Hero_items
-- ----------------------------

-- ----------------------------
-- Table structure for easyii_admins
-- ----------------------------
DROP TABLE IF EXISTS `easyii_admins`;
CREATE TABLE `easyii_admins` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(64) NOT NULL,
  `auth_key` varchar(128) NOT NULL,
  `access_token` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `access_token` (`access_token`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_admins
-- ----------------------------
INSERT INTO `easyii_admins` VALUES ('1', 'admin', 'e180a39c55c6ef0e5dd12303a149335a58a25788', 'pUn61xzY8TXUDEgUdnpDcCnmPD5z6WhN', null);

-- ----------------------------
-- Table structure for easyii_article_categories
-- ----------------------------
DROP TABLE IF EXISTS `easyii_article_categories`;
CREATE TABLE `easyii_article_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `image` varchar(128) DEFAULT NULL,
  `order_num` int(11) DEFAULT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `tree` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_article_categories
-- ----------------------------
INSERT INTO `easyii_article_categories` VALUES ('4', '公告', '', '2', null, '4', '1', '2', '0', '1');
INSERT INTO `easyii_article_categories` VALUES ('3', '活动', '', '1', null, '3', '1', '2', '0', '1');
INSERT INTO `easyii_article_categories` VALUES ('5', '新闻', '', '3', null, '5', '1', '2', '0', '1');
INSERT INTO `easyii_article_categories` VALUES ('6', '游戏攻略', '', '4', null, '6', '1', '6', '0', '1');
INSERT INTO `easyii_article_categories` VALUES ('13', '首页最新活动——三张图', '', '7', null, '13', '1', '2', '0', '1');
INSERT INTO `easyii_article_categories` VALUES ('12', '玩法', '', '4', null, '6', '4', '5', '1', '1');
INSERT INTO `easyii_article_categories` VALUES ('11', '新手', '', '4', null, '6', '2', '3', '1', '1');
INSERT INTO `easyii_article_categories` VALUES ('14', '视频', '', '5', null, '14', '1', '6', '0', '1');
INSERT INTO `easyii_article_categories` VALUES ('15', '新手', '', '5', null, '14', '2', '3', '1', '1');
INSERT INTO `easyii_article_categories` VALUES ('16', '玩法', '', '5', null, '14', '4', '5', '1', '1');
INSERT INTO `easyii_article_categories` VALUES ('17', '副页面左侧——三张图', '', '6', null, '17', '1', '2', '0', '1');

-- ----------------------------
-- Table structure for easyii_article_items
-- ----------------------------
DROP TABLE IF EXISTS `easyii_article_items`;
CREATE TABLE `easyii_article_items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(128) NOT NULL,
  `image` varchar(128) DEFAULT NULL,
  `short` varchar(1024) DEFAULT NULL,
  `text` text NOT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `time` int(11) DEFAULT '0',
  `views` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_article_items
-- ----------------------------
INSERT INTO `easyii_article_items` VALUES ('14', '5', '新闻1', '', '', '<p>地方氛围富兰克林付款了可</p>', '1-3', '1493026020', '0', '1');
INSERT INTO `easyii_article_items` VALUES ('15', '5', '新闻2', '', '', '<p>反反复复凤飞飞凤飞飞反反复复凤飞飞凤飞飞</p>', '2-3', '1493026028', '0', '1');
INSERT INTO `easyii_article_items` VALUES ('10', '11', '新手攻略1', '', '', '<p>顶顶顶顶顶顶顶顶顶顶大的</p>', '1', '1492764535', '0', '1');
INSERT INTO `easyii_article_items` VALUES ('11', '11', '新手攻略2', '', '', '<p>发发发发发发发发发发发</p>', '2', '1492764547', '0', '1');
INSERT INTO `easyii_article_items` VALUES ('12', '12', '玩法1', '', '', '<p>分发发发发发发发发发发发</p>', '1-2', '1492764560', '0', '1');
INSERT INTO `easyii_article_items` VALUES ('13', '12', '玩法2', '', '', '<p>发发发发发发发发发发发</p>', '2-2', '1492764566', '0', '1');
INSERT INTO `easyii_article_items` VALUES ('16', '4', '公告1', '', '', '<p>方法反反复复发反反复复凤飞飞凤飞飞</p>', '1-4', '1493026044', '0', '1');
INSERT INTO `easyii_article_items` VALUES ('17', '4', '公告2', '', '', '<p>伐伐方法反反复复发反反复复凤飞飞凤飞飞</p>', '2-4', '1493026054', '0', '1');
INSERT INTO `easyii_article_items` VALUES ('18', '3', '活动1', '', '', '<strong class=\"red\">活动一：累充送豪礼第一轮</strong>\r\n					<p>活动时间：3月20日-4月20日</p>\r\n					<p>活动范围：除新区外所有区服</p>\r\n					<p>活动时间：3月20日-4月20日</p>\r\n					<p>活动范围：除新区外所有区服</p>\r\n					<strong class=\"red\">活动二：累充送豪礼第一轮</strong>\r\n					<p>活动时间：3月20日-4月20日</p>\r\n					<p>活动范围：除新区外所有区服</p>\r\n					<p>活动时间：3月20日-4月20日</p>\r\n					<p>活动范围：除新区外所有区服</p>\r\n					<strong class=\"red\">活动二：累充送豪礼第一轮</strong>\r\n					<p>活动时间：3月20日-4月20日</p>\r\n					<p>活动范围：除新区外所有区服</p>\r\n					<p>活动时间：3月20日-4月20日</p>\r\n					<p>活动范围：除新区外所有区服</p>\r\n					<strong class=\"red\">活动二：累充送豪礼第一轮</strong>\r\n					<p>活动时间：3月20日-4月20日</p>\r\n					<p>活动范围：除新区外所有区服</p>\r\n					<p>活动时间：3月20日-4月20日</p>\r\n					<p>活动范围：除新区外所有区服</p>\r\n					<strong class=\"red\">活动二：累充送豪礼第一轮</strong>\r\n					<p>活动时间：3月20日-4月20日</p>\r\n					<p>活动范围：除新区外所有区服</p>\r\n					<p>活动时间：3月20日-4月20日</p>\r\n					<p>活动范围：除新区外所有区服</p>\r\n					<strong class=\"red\">活动二：累充送豪礼第一轮</strong>\r\n					<p>活动时间：3月20日-4月20日</p>\r\n					<p>活动范围：除新区外所有区服</p>\r\n					<p>活动时间：3月20日-4月20日</p>\r\n					<p>活动范围：除新区外所有区服</p>', '1-5', '1493026082', '0', '1');
INSERT INTO `easyii_article_items` VALUES ('19', '3', '活动2', '', '', '<p>啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊</p>', '2-5', '1493026091', '0', '1');
INSERT INTO `easyii_article_items` VALUES ('20', '13', '1', '/uploads/article/activity03-eed6e005fe.png', '/site/article/13', '<p>1</p>', '1-6', '1493352109', '0', '1');
INSERT INTO `easyii_article_items` VALUES ('21', '13', '2', '/uploads/article/activity02-2b7679dabd.png', '/site/article/18', '<p>1</p>', '2-6', '1493362060', '0', '1');
INSERT INTO `easyii_article_items` VALUES ('22', '13', '3', '/uploads/article/activity01-2eeccf1801.png', '/site/article/19', '<p>1</p>', '3', '1493362026', '0', '1');
INSERT INTO `easyii_article_items` VALUES ('23', '15', '三国新手视频2', '', '<iframe height=125 width=270 src=\'http://player.youku.com/embed/XMjczMzc1NjQwMA==\' frameborder=0 \'allowfullscreen\'></iframe>', '<p>1</p>', '2-8', '1493366839', '0', '1');
INSERT INTO `easyii_article_items` VALUES ('24', '15', '三国新手视频1', '', '<iframe height=125 width=270 src=\'http://player.youku.com/embed/XMjczMzc1NjQwMA==\' frameborder=0 \'allowfullscreen\'></iframe>', '<p>1</p>', '1-8', '1493366876', '0', '1');
INSERT INTO `easyii_article_items` VALUES ('25', '16', '三国玩法视频2', '', '<iframe height=125 width=270 src=\'http://player.youku.com/embed/XMjczMzc1NjQwMA==\' frameborder=0 \'allowfullscreen\'></iframe>', '<p>1</p>', '2-9', '1493366888', '0', '1');
INSERT INTO `easyii_article_items` VALUES ('26', '16', '三国玩法视频1', '', '<iframe height=125 width=270 src=\'http://player.youku.com/embed/XMjczMzc1NjQwMA==\' frameborder=0 \'allowfullscreen\'></iframe>', '<p>1</p>', '1-9', '1493366905', '0', '1');
INSERT INTO `easyii_article_items` VALUES ('29', '17', '3', '/uploads/article/activity03-687674b66a.png', '/site/article/13', '<p>3</p>', '3-2', '1493695609', '0', '1');
INSERT INTO `easyii_article_items` VALUES ('28', '17', '2', '/uploads/article/activity02-1bb0ee8365.png', '/site/article/13', '<p>1</p>', '2-7', '1493695595', '0', '1');
INSERT INTO `easyii_article_items` VALUES ('27', '17', '1', '/uploads/article/activity01-0f11e4717c.png', '/site/article/13', '<p>1</p>', '1-7', '1493695587', '0', '1');

-- ----------------------------
-- Table structure for easyii_carousel
-- ----------------------------
DROP TABLE IF EXISTS `easyii_carousel`;
CREATE TABLE `easyii_carousel` (
  `carousel_id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(128) NOT NULL,
  `link` varchar(255) NOT NULL,
  `title` varchar(128) DEFAULT NULL,
  `text` text,
  `order_num` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`carousel_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_carousel
-- ----------------------------

-- ----------------------------
-- Table structure for easyii_catalog_categories
-- ----------------------------
DROP TABLE IF EXISTS `easyii_catalog_categories`;
CREATE TABLE `easyii_catalog_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `image` varchar(128) DEFAULT NULL,
  `fields` text NOT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `tree` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `order_num` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_catalog_categories
-- ----------------------------
INSERT INTO `easyii_catalog_categories` VALUES ('1', '游戏攻略', '', '[]', null, '1', '1', '2', '0', '1', '1');

-- ----------------------------
-- Table structure for easyii_catalog_item_data
-- ----------------------------
DROP TABLE IF EXISTS `easyii_catalog_item_data`;
CREATE TABLE `easyii_catalog_item_data` (
  `data_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) DEFAULT NULL,
  `name` varchar(128) NOT NULL,
  `value` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`data_id`),
  KEY `item_id_name` (`item_id`,`name`),
  KEY `value` (`value`(300))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_catalog_item_data
-- ----------------------------

-- ----------------------------
-- Table structure for easyii_catalog_items
-- ----------------------------
DROP TABLE IF EXISTS `easyii_catalog_items`;
CREATE TABLE `easyii_catalog_items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(128) NOT NULL,
  `description` text,
  `available` int(11) DEFAULT '1',
  `price` float DEFAULT '0',
  `discount` int(11) DEFAULT '0',
  `data` text NOT NULL,
  `image` varchar(128) DEFAULT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `time` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_catalog_items
-- ----------------------------

-- ----------------------------
-- Table structure for easyii_faq
-- ----------------------------
DROP TABLE IF EXISTS `easyii_faq`;
CREATE TABLE `easyii_faq` (
  `faq_id` int(11) NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `order_num` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`faq_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_faq
-- ----------------------------

-- ----------------------------
-- Table structure for easyii_feedback
-- ----------------------------
DROP TABLE IF EXISTS `easyii_feedback`;
CREATE TABLE `easyii_feedback` (
  `feedback_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `email` varchar(128) NOT NULL,
  `phone` varchar(64) DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `text` text NOT NULL,
  `answer_subject` varchar(128) DEFAULT NULL,
  `answer_text` text,
  `time` int(11) DEFAULT '0',
  `ip` varchar(16) NOT NULL,
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`feedback_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_feedback
-- ----------------------------

-- ----------------------------
-- Table structure for easyii_files
-- ----------------------------
DROP TABLE IF EXISTS `easyii_files`;
CREATE TABLE `easyii_files` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `file` varchar(255) NOT NULL,
  `size` int(11) NOT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `downloads` int(11) DEFAULT '0',
  `time` int(11) DEFAULT '0',
  `order_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`file_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_files
-- ----------------------------

-- ----------------------------
-- Table structure for easyii_gallery_categories
-- ----------------------------
DROP TABLE IF EXISTS `easyii_gallery_categories`;
CREATE TABLE `easyii_gallery_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `image` varchar(128) DEFAULT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `tree` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `order_num` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_gallery_categories
-- ----------------------------
INSERT INTO `easyii_gallery_categories` VALUES ('3', 'pc首页-游戏特色三张banner', '', 'pc-banner', '3', '1', '2', '0', '2', '1');
INSERT INTO `easyii_gallery_categories` VALUES ('2', 'pc首页-英雄介绍 亮点抢先看 三张图', '', 'pc', '2', '1', '2', '0', '1', '1');
INSERT INTO `easyii_gallery_categories` VALUES ('4', 'mobile-滚动图', '', 'mobile', '4', '1', '2', '0', '3', '1');

-- ----------------------------
-- Table structure for easyii_guestbook
-- ----------------------------
DROP TABLE IF EXISTS `easyii_guestbook`;
CREATE TABLE `easyii_guestbook` (
  `guestbook_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `title` varchar(128) DEFAULT NULL,
  `text` text NOT NULL,
  `answer` text,
  `email` varchar(128) DEFAULT NULL,
  `time` int(11) DEFAULT '0',
  `ip` varchar(16) NOT NULL,
  `new` tinyint(1) DEFAULT '0',
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`guestbook_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_guestbook
-- ----------------------------

-- ----------------------------
-- Table structure for easyii_loginform
-- ----------------------------
DROP TABLE IF EXISTS `easyii_loginform`;
CREATE TABLE `easyii_loginform` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `user_agent` varchar(1024) NOT NULL,
  `time` int(11) DEFAULT '0',
  `success` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`log_id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_loginform
-- ----------------------------
INSERT INTO `easyii_loginform` VALUES ('1', 'root', '******', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1492404932', '1');
INSERT INTO `easyii_loginform` VALUES ('2', 'root', 'root', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1492406128', '0');
INSERT INTO `easyii_loginform` VALUES ('3', 'root', 'admin', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1492406134', '0');
INSERT INTO `easyii_loginform` VALUES ('4', 'root', 'root', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1492406137', '0');
INSERT INTO `easyii_loginform` VALUES ('5', 'root', '******', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1492406187', '1');
INSERT INTO `easyii_loginform` VALUES ('6', 'admin', '******', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1492406211', '1');
INSERT INTO `easyii_loginform` VALUES ('7', 'admin', '******', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1492406247', '1');
INSERT INTO `easyii_loginform` VALUES ('8', 'root', '******', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1492416153', '1');
INSERT INTO `easyii_loginform` VALUES ('9', 'admin', '******', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1492416182', '1');
INSERT INTO `easyii_loginform` VALUES ('10', 'admin', '******', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1492416735', '1');
INSERT INTO `easyii_loginform` VALUES ('11', 'admin', '******', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1492759084', '1');
INSERT INTO `easyii_loginform` VALUES ('12', 'root', '******', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1492759107', '1');
INSERT INTO `easyii_loginform` VALUES ('13', 'admin', '******', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1492760782', '1');
INSERT INTO `easyii_loginform` VALUES ('14', 'admin', '******', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1492761120', '1');
INSERT INTO `easyii_loginform` VALUES ('15', 'root', '******', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1492767061', '1');
INSERT INTO `easyii_loginform` VALUES ('16', 'root', 'csm_admin', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1493003795', '0');
INSERT INTO `easyii_loginform` VALUES ('17', 'root', '******', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1493003799', '1');
INSERT INTO `easyii_loginform` VALUES ('18', 'root', '******', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1493351180', '1');
INSERT INTO `easyii_loginform` VALUES ('19', 'root', '******', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1493695488', '1');
INSERT INTO `easyii_loginform` VALUES ('20', 'root', '******', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1493805244', '1');
INSERT INTO `easyii_loginform` VALUES ('21', 'admin', '******', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1493868929', '1');
INSERT INTO `easyii_loginform` VALUES ('22', 'admin', '******', '180.168.36.210', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.3; .NET4.0C; .NET4.0E)', '1493870233', '1');
INSERT INTO `easyii_loginform` VALUES ('23', 'admin', '******', '180.168.36.210', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/5.0.2.1000 Chrome/47.0.2526.73 Safari/537.36', '1493870796', '1');
INSERT INTO `easyii_loginform` VALUES ('24', 'admin', '******', '223.104.5.194', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Mobile/14E304 QQ/6.7.1.416 V1_IPH_SQ_6.7.1_1_APP_A Pixel/1080 Core/UIWebView NetType/4G QBWebViewType/1', '1493873977', '1');
INSERT INTO `easyii_loginform` VALUES ('25', 'admin', '******', '180.168.36.210', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.3; .NET4.0C; .NET4.0E)', '1493878599', '1');
INSERT INTO `easyii_loginform` VALUES ('26', 'root', '******', '116.226.84.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36', '1494490304', '1');
INSERT INTO `easyii_loginform` VALUES ('27', 'root', '******', '116.226.179.33', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36', '1495009562', '1');

-- ----------------------------
-- Table structure for easyii_migration
-- ----------------------------
DROP TABLE IF EXISTS `easyii_migration`;
CREATE TABLE `easyii_migration` (
  `version` varchar(180) COLLATE utf8_bin NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of easyii_migration
-- ----------------------------
INSERT INTO `easyii_migration` VALUES ('m000000_000000_base', '1492404931');
INSERT INTO `easyii_migration` VALUES ('m000000_000000_install', '1492404931');

-- ----------------------------
-- Table structure for easyii_modules
-- ----------------------------
DROP TABLE IF EXISTS `easyii_modules`;
CREATE TABLE `easyii_modules` (
  `module_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `class` varchar(128) NOT NULL,
  `title` varchar(128) NOT NULL,
  `icon` varchar(32) NOT NULL,
  `settings` text NOT NULL,
  `notice` int(11) DEFAULT '0',
  `order_num` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`module_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_modules
-- ----------------------------
INSERT INTO `easyii_modules` VALUES ('1', 'article', 'yii\\easyii\\modules\\article\\ArticleModule', 'Articles', 'pencil', '{\"categoryThumb\":true,\"articleThumb\":true,\"enablePhotos\":true,\"enableShort\":true,\"shortMaxLength\":255,\"enableTags\":true,\"itemsInFolder\":false}', '0', '65', '1');
INSERT INTO `easyii_modules` VALUES ('2', 'carousel', 'yii\\easyii\\modules\\carousel\\CarouselModule', 'Carousel', 'picture', '{\"enableTitle\":true,\"enableText\":true}', '0', '40', '0');
INSERT INTO `easyii_modules` VALUES ('3', 'catalog', 'yii\\easyii\\modules\\catalog\\CatalogModule', 'Catalog', 'list-alt', '{\"categoryThumb\":true,\"itemsInFolder\":false,\"itemThumb\":true,\"itemPhotos\":true,\"itemDescription\":true,\"itemSale\":true}', '0', '100', '0');
INSERT INTO `easyii_modules` VALUES ('4', 'faq', 'yii\\easyii\\modules\\faq\\FaqModule', 'FAQ', 'question-sign', '[]', '0', '45', '0');
INSERT INTO `easyii_modules` VALUES ('5', 'feedback', 'yii\\easyii\\modules\\feedback\\FeedbackModule', 'Feedback', 'earphone', '{\"mailAdminOnNewFeedback\":true,\"subjectOnNewFeedback\":\"New feedback\",\"templateOnNewFeedback\":\"@easyii\\/modules\\/feedback\\/mail\\/en\\/new_feedback\",\"answerTemplate\":\"@easyii\\/modules\\/feedback\\/mail\\/en\\/answer\",\"answerSubject\":\"Answer on your feedback message\",\"answerHeader\":\"Hello,\",\"answerFooter\":\"Best regards.\",\"enableTitle\":false,\"enablePhone\":true,\"enableCaptcha\":false}', '0', '60', '0');
INSERT INTO `easyii_modules` VALUES ('6', 'file', 'yii\\easyii\\modules\\file\\FileModule', 'Files', 'floppy-disk', '[]', '0', '30', '0');
INSERT INTO `easyii_modules` VALUES ('7', 'gallery', 'yii\\easyii\\modules\\gallery\\GalleryModule', 'Photo Gallery', 'camera', '{\"categoryThumb\":true,\"itemsInFolder\":false}', '0', '90', '1');
INSERT INTO `easyii_modules` VALUES ('8', 'guestbook', 'yii\\easyii\\modules\\guestbook\\GuestbookModule', 'Guestbook', 'book', '{\"enableTitle\":false,\"enableEmail\":true,\"preModerate\":false,\"enableCaptcha\":false,\"mailAdminOnNewPost\":true,\"subjectOnNewPost\":\"New message in the guestbook.\",\"templateOnNewPost\":\"@easyii\\/modules\\/guestbook\\/mail\\/en\\/new_post\",\"frontendGuestbookRoute\":\"\\/guestbook\",\"subjectNotifyUser\":\"Your post in the guestbook answered\",\"templateNotifyUser\":\"@easyii\\/modules\\/guestbook\\/mail\\/en\\/notify_user\"}', '0', '80', '0');
INSERT INTO `easyii_modules` VALUES ('9', 'news', 'yii\\easyii\\modules\\news\\NewsModule', 'News', 'bullhorn', '{\"enableThumb\":true,\"enablePhotos\":true,\"enableShort\":true,\"shortMaxLength\":256,\"enableTags\":true}', '0', '70', '0');
INSERT INTO `easyii_modules` VALUES ('10', 'page', 'yii\\easyii\\modules\\page\\PageModule', 'Pages', 'file', '[]', '0', '50', '0');
INSERT INTO `easyii_modules` VALUES ('11', 'shopcart', 'yii\\easyii\\modules\\shopcart\\ShopcartModule', 'Orders', 'shopping-cart', '{\"mailAdminOnNewOrder\":true,\"subjectOnNewOrder\":\"New order\",\"templateOnNewOrder\":\"@easyii\\/modules\\/shopcart\\/mail\\/en\\/new_order\",\"subjectNotifyUser\":\"Your order status changed\",\"templateNotifyUser\":\"@easyii\\/modules\\/shopcart\\/mail\\/en\\/notify_user\",\"frontendShopcartRoute\":\"\\/shopcart\\/order\",\"enablePhone\":true,\"enableEmail\":true}', '0', '120', '0');
INSERT INTO `easyii_modules` VALUES ('12', 'subscribe', 'yii\\easyii\\modules\\subscribe\\SubscribeModule', 'E-mail subscribe', 'envelope', '[]', '0', '10', '0');
INSERT INTO `easyii_modules` VALUES ('13', 'text', 'yii\\easyii\\modules\\text\\TextModule', 'Text blocks', 'font', '[]', '0', '20', '0');
INSERT INTO `easyii_modules` VALUES ('14', 'hero', 'app\\modules\\hero\\HeroModule', 'hero', 'pencil', '{\"categoryThumb\":true,\"articleThumb\":true,\"enablePhotos\":true,\"enableShort\":true,\"shortMaxLength\":\"255\",\"enableTags\":true,\"itemsInFolder\":false}', '0', '121', '1');

-- ----------------------------
-- Table structure for easyii_news
-- ----------------------------
DROP TABLE IF EXISTS `easyii_news`;
CREATE TABLE `easyii_news` (
  `news_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `image` varchar(128) DEFAULT NULL,
  `short` varchar(1024) DEFAULT NULL,
  `text` text NOT NULL,
  `slug` varchar(128) DEFAULT NULL,
  `time` int(11) DEFAULT '0',
  `views` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`news_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_news
-- ----------------------------

-- ----------------------------
-- Table structure for easyii_pages
-- ----------------------------
DROP TABLE IF EXISTS `easyii_pages`;
CREATE TABLE `easyii_pages` (
  `page_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `text` text NOT NULL,
  `slug` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_pages
-- ----------------------------

-- ----------------------------
-- Table structure for easyii_photos
-- ----------------------------
DROP TABLE IF EXISTS `easyii_photos`;
CREATE TABLE `easyii_photos` (
  `photo_id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(128) NOT NULL,
  `item_id` int(11) NOT NULL,
  `image` varchar(128) NOT NULL,
  `description` varchar(1024) NOT NULL,
  `order_num` int(11) NOT NULL,
  PRIMARY KEY (`photo_id`),
  KEY `model_item` (`class`,`item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_photos
-- ----------------------------
INSERT INTO `easyii_photos` VALUES ('3', 'yii\\easyii\\modules\\gallery\\models\\Category', '2', '/uploads/photos/banner01-1bca7d913b.jpg', '2', '2');
INSERT INTO `easyii_photos` VALUES ('2', 'yii\\easyii\\modules\\gallery\\models\\Category', '2', '/uploads/photos/banner01-5405ffdfe4.jpg', '1', '1');
INSERT INTO `easyii_photos` VALUES ('5', 'yii\\easyii\\modules\\gallery\\models\\Category', '2', '/uploads/photos/banner01-afeec7b8dc.jpg', '3', '3');
INSERT INTO `easyii_photos` VALUES ('6', 'yii\\easyii\\modules\\gallery\\models\\Category', '3', '/uploads/photos/banner02-4837b7864f.jpg', '1', '4');
INSERT INTO `easyii_photos` VALUES ('11', 'yii\\easyii\\modules\\gallery\\models\\Category', '4', '/uploads/photos/banner-9e93e5ae7d.jpg', '1', '8');
INSERT INTO `easyii_photos` VALUES ('8', 'yii\\easyii\\modules\\gallery\\models\\Category', '3', '/uploads/photos/banner02-ec8e11257c.jpg', '2', '6');
INSERT INTO `easyii_photos` VALUES ('10', 'yii\\easyii\\modules\\gallery\\models\\Category', '3', '/uploads/photos/banner02-d7b194921b.jpg', '3', '7');
INSERT INTO `easyii_photos` VALUES ('12', 'yii\\easyii\\modules\\gallery\\models\\Category', '4', '/uploads/photos/banner-5a2f55a2af.jpg', '2', '9');

-- ----------------------------
-- Table structure for easyii_seotext
-- ----------------------------
DROP TABLE IF EXISTS `easyii_seotext`;
CREATE TABLE `easyii_seotext` (
  `seotext_id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(128) NOT NULL,
  `item_id` int(11) NOT NULL,
  `h1` varchar(128) DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `keywords` varchar(128) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`seotext_id`),
  UNIQUE KEY `model_item` (`class`,`item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_seotext
-- ----------------------------

-- ----------------------------
-- Table structure for easyii_settings
-- ----------------------------
DROP TABLE IF EXISTS `easyii_settings`;
CREATE TABLE `easyii_settings` (
  `setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `title` varchar(128) NOT NULL,
  `value` varchar(1024) NOT NULL,
  `visibility` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`setting_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_settings
-- ----------------------------
INSERT INTO `easyii_settings` VALUES ('1', 'easyii_version', 'EasyiiCMS version', '0.9', '0');
INSERT INTO `easyii_settings` VALUES ('2', 'recaptcha_key', 'ReCaptcha key', '', '1');
INSERT INTO `easyii_settings` VALUES ('3', 'password_salt', 'Password salt', 'sHyZxS8nvziMQJl4IYOQw6SkotNDhxyw', '0');
INSERT INTO `easyii_settings` VALUES ('4', 'root_auth_key', 'Root authorization key', 'IzVdRN4pj8mHyGBoNk9igWwQmmzmTDMn', '0');
INSERT INTO `easyii_settings` VALUES ('5', 'root_password', 'Root password', '74ac32d6d53b67280d84d547ba8e0b28fefb3a2d', '1');
INSERT INTO `easyii_settings` VALUES ('6', 'auth_time', 'Auth time', '86400', '1');
INSERT INTO `easyii_settings` VALUES ('7', 'robot_email', 'Robot E-mail', 'cms@cms.com', '1');
INSERT INTO `easyii_settings` VALUES ('8', 'admin_email', 'Admin E-mail', 'cms@cms.com', '2');
INSERT INTO `easyii_settings` VALUES ('9', 'recaptcha_secret', 'ReCaptcha secret', '', '1');
INSERT INTO `easyii_settings` VALUES ('10', 'toolbar_position', 'Frontend toolbar position (\"top\" or \"bottom\")', 'top', '1');

-- ----------------------------
-- Table structure for easyii_shopcart_goods
-- ----------------------------
DROP TABLE IF EXISTS `easyii_shopcart_goods`;
CREATE TABLE `easyii_shopcart_goods` (
  `good_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `options` varchar(255) NOT NULL,
  `price` float DEFAULT '0',
  `discount` int(11) DEFAULT '0',
  PRIMARY KEY (`good_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_shopcart_goods
-- ----------------------------

-- ----------------------------
-- Table structure for easyii_shopcart_orders
-- ----------------------------
DROP TABLE IF EXISTS `easyii_shopcart_orders`;
CREATE TABLE `easyii_shopcart_orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(64) NOT NULL,
  `email` varchar(128) NOT NULL,
  `comment` varchar(1024) NOT NULL,
  `remark` varchar(1024) NOT NULL,
  `access_token` varchar(32) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `time` int(11) DEFAULT '0',
  `new` tinyint(1) DEFAULT '0',
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`order_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_shopcart_orders
-- ----------------------------

-- ----------------------------
-- Table structure for easyii_subscribe_history
-- ----------------------------
DROP TABLE IF EXISTS `easyii_subscribe_history`;
CREATE TABLE `easyii_subscribe_history` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(128) NOT NULL,
  `body` text NOT NULL,
  `sent` int(11) DEFAULT '0',
  `time` int(11) DEFAULT '0',
  PRIMARY KEY (`history_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_subscribe_history
-- ----------------------------

-- ----------------------------
-- Table structure for easyii_subscribe_subscribers
-- ----------------------------
DROP TABLE IF EXISTS `easyii_subscribe_subscribers`;
CREATE TABLE `easyii_subscribe_subscribers` (
  `subscriber_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(128) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `time` int(11) DEFAULT '0',
  PRIMARY KEY (`subscriber_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_subscribe_subscribers
-- ----------------------------

-- ----------------------------
-- Table structure for easyii_tags
-- ----------------------------
DROP TABLE IF EXISTS `easyii_tags`;
CREATE TABLE `easyii_tags` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `frequency` int(11) DEFAULT '0',
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_tags
-- ----------------------------

-- ----------------------------
-- Table structure for easyii_tags_assign
-- ----------------------------
DROP TABLE IF EXISTS `easyii_tags_assign`;
CREATE TABLE `easyii_tags_assign` (
  `class` varchar(128) NOT NULL,
  `item_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  KEY `class` (`class`),
  KEY `item_tag` (`item_id`,`tag_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_tags_assign
-- ----------------------------

-- ----------------------------
-- Table structure for easyii_texts
-- ----------------------------
DROP TABLE IF EXISTS `easyii_texts`;
CREATE TABLE `easyii_texts` (
  `text_id` int(11) NOT NULL AUTO_INCREMENT,
  `text` text NOT NULL,
  `slug` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`text_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of easyii_texts
-- ----------------------------


CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `order_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `order_time` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `order_money` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `channel_product_id` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `uid` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `productid` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `serverid` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `guid` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `order_expand` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `prepay_id` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `status` varchar(64) COLLATE utf8_bin DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
