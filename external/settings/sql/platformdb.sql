-- -----------
-- tbl_account_white
-- -----------
DROP TABLE IF EXISTS `tbl_account_white`;
CREATE TABLE `tbl_account_white` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户UID',
  PRIMARY KEY (`id`),
  UNIQUE KEY unq_uid(`uid`)
) ENGINE=InnoDB;

-- -----------
-- tbl_account_change
-- -----------
DROP TABLE IF EXISTS `tbl_account_change`;
CREATE TABLE `tbl_account_change` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `channel` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '渠道ID',
  `uid` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户UID',
  `server_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '服务器ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- -----------
-- tbl_gm_account
-- -----------
DROP TABLE IF EXISTS `tbl_gm_account`;
CREATE TABLE `tbl_gm_account` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `account` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户账号',
  PRIMARY KEY (`id`),
  UNIQUE KEY unq_uid(`account`)
) ENGINE=InnoDB;

-- -----------
-- tbl_device_change
-- -----------
DROP TABLE IF EXISTS `tbl_device_change`;
CREATE TABLE `tbl_device_change` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `imei` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'IMEI',
  `channel` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '渠道ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

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

-- -----------
-- tbl_phone_change
-- -----------
DROP TABLE IF EXISTS `tbl_phone_change`;
CREATE TABLE `tbl_phone_change` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `phone` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'PHONE',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- -----------
-- tbl_mail_bind
-- -----------
DROP TABLE IF EXISTS `tbl_mail_bind`;
CREATE TABLE `tbl_mail_bind` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `player_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'player_id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
