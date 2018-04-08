-- -------------------
-- tbl_sgzj2_account
-- -------------------
CREATE TABLE `tbl_sgzj2_account` (
  `channel` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'IDFA',
  `uid` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'UID',
  `level` int NOT NULL DEFAULT 0 COMMENT 'LEVEL',
  PRIMARY KEY (`channel`, `uid`),
  KEY `index_channel` (`channel`),
  KEY `index_uid` (`uid`)
) ENGINE=InnoDB;
