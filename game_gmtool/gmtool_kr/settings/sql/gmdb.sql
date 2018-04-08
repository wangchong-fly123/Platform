set names utf8;

-- -----------
-- tbl_account
-- -----------
DROP TABLE IF EXISTS `tbl_account`;
CREATE TABLE `tbl_account` (
  `account` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '帐号',
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '密码',
  `account_type` int NOT NULL COMMENT '帐号类型',
  `platform_id` int NOT NULL COMMENT '平台ID',
  `exclude_channel` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '排除渠道',
  `cps` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'CPS标识',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB;

INSERT INTO `tbl_account` VALUES
('enjoymi', '07d783911d3536efef232dc519179d1a2edea97d', 0, 0, '', '');

-- -----------
-- tbl_channel
-- -----------
DROP TABLE IF EXISTS `tbl_channel`;
CREATE TABLE `tbl_channel` (
  `id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '渠道编号',
  `desc` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '描述',
  `platform_id` int NOT NULL COMMENT '平台ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- ----------
-- tbl_op_log
-- ----------
DROP TABLE IF EXISTS `tbl_op_log`;
CREATE TABLE `tbl_op_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `timestamp` bigint NOT NULL COMMENT '时间戳',
  `account` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '帐号',
  `log` varchar(10240) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '日志',
  PRIMARY KEY(`id`),
  KEY idx_timestamp(`timestamp`),
  KEY idx_account(`account`)
) ENGINE=InnoDB;

-- ---------------
-- tbl_pay_product
-- ---------------
DROP TABLE IF EXISTS `tbl_pay_product`;
CREATE TABLE `tbl_pay_product` (
  `id` int NOT NULL COMMENT '商品编号',
  `amount` int NOT NULL COMMENT '价格',
  `desc` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '描述',
  PRIMARY KEY(`id`)
) ENGINE=InnoDB;

-- ------------
-- tbl_platform
-- ------------
DROP TABLE IF EXISTS `tbl_platform`;
CREATE TABLE `tbl_platform` (
  `id` int NOT NULL COMMENT '平台编号',
  `desc` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- ----------
-- tbl_server
-- ----------
DROP TABLE IF EXISTS `tbl_server`;
CREATE TABLE `tbl_server` (
  `id` int NOT NULL COMMENT '服务器编号',
  `platform_id` int NOT NULL COMMENT '平台ID',
  `server_id` int NOT NULL COMMENT '服务器ID',
  `desc` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '描述',
  `addr` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '地址',
  `secret_key` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '密钥',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
set names utf8;

-- -----------
-- tbl_spread
-- -----------
CREATE TABLE `tbl_spread` (
  `url` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '短链标识',
  `desc` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '描述',
  PRIMARY KEY (`url`)
) ENGINE=InnoDB;
