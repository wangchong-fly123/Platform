-- -------------------
-- tbl_device
-- -------------------
DROP TABLE IF EXISTS `tbl_device`;
CREATE TABLE `tbl_device` (
  `account` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '账号',
  `device_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '设备ID',
  `record_time` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '时间',
  `game_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '游戏',
  `imei` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'IMEI',
  `idfa` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'IDFA',
  `phone` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'PHONE',
  `uid` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'UID',
  PRIMARY KEY (`account`, `device_id`),
  KEY `index_device_id` (`device_id`),
  KEY `index_idfa` (`idfa`)
) ENGINE=InnoDB;

-- -------------------
-- tbl_sgzj2_device
-- -------------------
DROP TABLE IF EXISTS `tbl_sgzj2_device`;
CREATE TABLE `tbl_sgzj2_device` (
  `account` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '账号',
  `device_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '设备ID',
  `record_time` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '时间',
  `game_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '游戏',
  `imei` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'IMEI',
  `idfa` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'IDFA',
  `uid` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'UID',
  PRIMARY KEY (`account`, `device_id`),
  KEY `index_device_id` (`device_id`)
) ENGINE=InnoDB;

-- -------------------
-- tbl_sgzj2_account
-- -------------------
DROP TABLE IF EXISTS `tbl_sgzj2_account`;
CREATE TABLE `tbl_sgzj2_account` (
  `channel` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'IDFA',
  `uid` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'UID',
  `level` int NOT NULL DEFAULT 0 COMMENT 'LEVEL',
  PRIMARY KEY (`channel`, `uid`),
  KEY `index_channel` (`channel`),
  KEY `index_uid` (`uid`)
) ENGINE=InnoDB;
