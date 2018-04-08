-- -------------------
-- tbl_device
-- -------------------
ALTER TABLE `tbl_device`
ADD `game_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'сно╥'
AFTER `record_time`;
