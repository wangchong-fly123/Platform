-- -------------------
-- tbl_device
-- -------------------
ALTER TABLE `tbl_device`
ADD `uid` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'UID'
AFTER `phone`;
