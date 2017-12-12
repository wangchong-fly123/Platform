-- ---------
-- tbl_account_info
-- ---------
DROP TABLE IF EXISTS `tbl_account_info`;
CREATE TABLE `tbl_account_info` (
    `ACCOUNT` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '帐号',
    `SERVER_LIST` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '登录的区列表',
    PRIMARY KEY (`ACCOUNT`)
) ENGINE=InnoDB;
