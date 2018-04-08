-- -----------
-- tbl_device_change
-- -----------
DROP TABLE IF EXISTS `tbl_device_change`;
CREATE TABLE `tbl_device_change` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `imei` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'IMEI',
  `channel` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'ÇþµÀID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
