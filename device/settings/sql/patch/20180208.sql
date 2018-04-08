-- -------------------
-- tbl_sgzj2_device
-- -------------------
ALTER TABLE `tbl_sgzj2_device`
ADD `idfa` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'IDFA'
AFTER `imei`;
