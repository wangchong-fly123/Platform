-- -----------
-- tbl_account_phone
-- -----------
DROP TABLE IF EXISTS `tbl_account_phone`;
CREATE TABLE `tbl_account_phone` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `platform` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'IMEI',
  `channel` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'ÇþµÀID',
  `uid` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'UID',
  `phone` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'PHONE',
  `server_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'SERVER_ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
