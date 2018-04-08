-- -------------------
-- tbl_device
-- -------------------
ALTER TABLE `tbl_device`
ADD `imei` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'IMEI'
AFTER `game_id`;
