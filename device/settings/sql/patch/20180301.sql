-- -------------------
-- tbl_device
-- -------------------
ALTER TABLE `tbl_device`
ADD `phone` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'PHONE'
AFTER `idfa`;
