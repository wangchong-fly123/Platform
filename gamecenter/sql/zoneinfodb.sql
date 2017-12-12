
-- ---------------
-- tbl_zoneinfo
-- ---------------
DROP TABLE IF EXISTS `tbl_zoneinfo`;
CREATE TABLE `tbl_zoneinfo` (
    `GAME` int(10) unsigned NOT NULL default 0,
    `ZONE` int(10) unsigned NOT NULL default 0,
    `NAME` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '服务器名字',
    `IP` varchar(48) NOT NULL default '0.0.0.0',
    `PORT` int(10) unsigned NOT NULL default 0,
    `WEBPORT` int(10) unsigned NOT NULL default 0,
    `TYPE` int(10) unsigned NOT NULL default 0,
    `STATUS` int(10) unsigned NOT NULL default 0 COMMENT '服务器状态',
    `TIPS` int(10) unsigned NOT NULL default 0 COMMENT '服务器标签',
    `DISABLE_GIFTCODE` int(10) unsigned NOT NULL default 0 COMMENT '禁止礼包码',
    `START_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)',
    `END_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '结束时间(YYYY-mm-dd HH::ii:ss)',
    `DESC` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '描述',
    PRIMARY KEY  (`GAME`, `ZONE`)
) ENGINE=InnoDB;

-- ---------------
-- tbl_zoneinfo_banshu
-- ---------------
DROP TABLE IF EXISTS `tbl_zoneinfo_banshu`;
CREATE TABLE `tbl_zoneinfo_banshu` (
    `GAME` int(10) unsigned NOT NULL default 0,
    `ZONE` int(10) unsigned NOT NULL default 0,
    `NAME` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '服务器名字',
    `IP` varchar(48) NOT NULL default '0.0.0.0',
    `PORT` int(10) unsigned NOT NULL default 0,
    `WEBPORT` int(10) unsigned NOT NULL default 0,
    `TYPE` int(10) unsigned NOT NULL default 0,
    `STATUS` int(10) unsigned NOT NULL default 0 COMMENT '服务器状态',
    `TIPS` int(10) unsigned NOT NULL default 0 COMMENT '服务器标签',
    `DISABLE_GIFTCODE` int(10) unsigned NOT NULL default 0 COMMENT '禁止礼包码',
    `START_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)',
    `END_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '结束时间(YYYY-mm-dd HH::ii:ss)',
    `DESC` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '描述',
    PRIMARY KEY  (`GAME`, `ZONE`)
) ENGINE=InnoDB;

-- ---------------
-- tbl_zoneinfo_common_android
-- ---------------
DROP TABLE IF EXISTS `tbl_zoneinfo_common_android`;
CREATE TABLE `tbl_zoneinfo_common_android` (
    `GAME` int(10) unsigned NOT NULL default 0,
    `ZONE` int(10) unsigned NOT NULL default 0,
    `NAME` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '服务器名字',
    `IP` varchar(48) NOT NULL default '0.0.0.0',
    `PORT` int(10) unsigned NOT NULL default 0,
    `WEBPORT` int(10) unsigned NOT NULL default 0,
    `TYPE` int(10) unsigned NOT NULL default 0,
    `STATUS` int(10) unsigned NOT NULL default 0 COMMENT '服务器状态',
    `TIPS` int(10) unsigned NOT NULL default 0 COMMENT '服务器标签',
    `DISABLE_GIFTCODE` int(10) unsigned NOT NULL default 0 COMMENT '禁止礼包码',
    `START_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)',
    `END_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '结束时间(YYYY-mm-dd HH::ii:ss)',
    `DESC` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '描述',
    PRIMARY KEY  (`GAME`, `ZONE`)
) ENGINE=InnoDB;

-- ---------------
-- tbl_zoneinfo_appstore_ios
-- ---------------
DROP TABLE IF EXISTS `tbl_zoneinfo_appstore_ios`;
CREATE TABLE `tbl_zoneinfo_appstore_ios` (
    `GAME` int(10) unsigned NOT NULL default 0,
    `ZONE` int(10) unsigned NOT NULL default 0,
    `NAME` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '服务器名字',
    `IP` varchar(48) NOT NULL default '0.0.0.0',
    `PORT` int(10) unsigned NOT NULL default 0,
    `WEBPORT` int(10) unsigned NOT NULL default 0,
    `TYPE` int(10) unsigned NOT NULL default 0,
    `STATUS` int(10) unsigned NOT NULL default 0 COMMENT '服务器状态',
    `TIPS` int(10) unsigned NOT NULL default 0 COMMENT '服务器标签',
    `DISABLE_GIFTCODE` int(10) unsigned NOT NULL default 0 COMMENT '禁止礼包码',
    `START_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)',
    `END_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '结束时间(YYYY-mm-dd HH::ii:ss)',
    `DESC` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '描述',
    PRIMARY KEY  (`GAME`, `ZONE`)
) ENGINE=InnoDB;

-- ---------------
-- tbl_zoneinfo_escape_ios
-- ---------------
DROP TABLE IF EXISTS `tbl_zoneinfo_escape_ios`;
CREATE TABLE `tbl_zoneinfo_escape_ios` (
    `GAME` int(10) unsigned NOT NULL default 0,
    `ZONE` int(10) unsigned NOT NULL default 0,
    `NAME` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '服务器名字',
    `IP` varchar(48) NOT NULL default '0.0.0.0',
    `PORT` int(10) unsigned NOT NULL default 0,
    `WEBPORT` int(10) unsigned NOT NULL default 0,
    `TYPE` int(10) unsigned NOT NULL default 0,
    `STATUS` int(10) unsigned NOT NULL default 0 COMMENT '服务器状态',
    `TIPS` int(10) unsigned NOT NULL default 0 COMMENT '服务器标签',
    `DISABLE_GIFTCODE` int(10) unsigned NOT NULL default 0 COMMENT '禁止礼包码',
    `START_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)',
    `END_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '结束时间(YYYY-mm-dd HH::ii:ss)',
    `DESC` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '描述',
    PRIMARY KEY  (`GAME`, `ZONE`)
) ENGINE=InnoDB;

-- ---------
-- tbl_account_info
-- ---------
DROP TABLE IF EXISTS `tbl_account_info`;
CREATE TABLE `tbl_account_info` (
    `ACCOUNT` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '帐号',
    `SERVER_LIST` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '登录的区列表',
    PRIMARY KEY (`ACCOUNT`)
) ENGINE=InnoDB;
