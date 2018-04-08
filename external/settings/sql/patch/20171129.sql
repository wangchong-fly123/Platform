-- -----------
-- tbl_mail_bind
-- -----------
DROP TABLE IF EXISTS `tbl_mail_bind`;
CREATE TABLE `tbl_mail_bind` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `player_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'player_id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
