-- -----------
-- tbl_phone_change
-- -----------
DROP TABLE IF EXISTS `tbl_phone_change`;
CREATE TABLE `tbl_phone_change` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `phone` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'PHONE',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
