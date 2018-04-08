-- -------------------
-- tbl_sgzj2_device
-- -------------------
CREATE TABLE `tbl_sgzj2_device` (
  `account` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '账号',
  `device_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '设备ID',
  `record_time` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '时间',
  `game_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '游戏',
  `imei` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'IMEI',
  `uid` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'UID',
  PRIMARY KEY (`account`, `device_id`)
) ENGINE=InnoDB;
