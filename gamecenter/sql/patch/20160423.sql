DROP TABLE IF EXISTS `tbl_zoneinfo_qihu_android`;
DROP TABLE IF EXISTS `tbl_zoneinfo_xy_escape`;
DROP TABLE IF EXISTS `tbl_zoneinfo_xy_android`;
DROP TABLE IF EXISTS `tbl_zoneinfo_xy_ios`;
DROP TABLE IF EXISTS `tbl_zoneinfo_papa_android`;
DROP TABLE IF EXISTS `tbl_zoneinfo_papa_test`;

-- ---------------
-- tbl_zoneinfo_common_android
-- ---------------
CREATE TABLE `tbl_zoneinfo_common_android` (
    `GAME` int(10) unsigned NOT NULL default 0,
    `ZONE` int(10) unsigned NOT NULL default 0,
    `NAME` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '服务器名字',
    `IP` varchar(16) NOT NULL default '0.0.0.0',
    `PORT` int(10) unsigned NOT NULL default 0,
    `WEBPORT` int(10) unsigned NOT NULL default 0,
    `TYPE` int(10) unsigned NOT NULL default 0,
    `STATUS` int(10) unsigned NOT NULL default 0 COMMENT '服务器状态',
    `DESC` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '描述',
    PRIMARY KEY  (`GAME`, `ZONE`)
) ENGINE=InnoDB;

-- ---------------
-- tbl_zoneinfo_appstore_ios
-- ---------------
CREATE TABLE `tbl_zoneinfo_appstore_ios` (
    `GAME` int(10) unsigned NOT NULL default 0,
    `ZONE` int(10) unsigned NOT NULL default 0,
    `NAME` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '服务器名字',
    `IP` varchar(16) NOT NULL default '0.0.0.0',
    `PORT` int(10) unsigned NOT NULL default 0,
    `WEBPORT` int(10) unsigned NOT NULL default 0,
    `TYPE` int(10) unsigned NOT NULL default 0,
    `STATUS` int(10) unsigned NOT NULL default 0 COMMENT '服务器状态',
    `DESC` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '描述',
    PRIMARY KEY  (`GAME`, `ZONE`)
) ENGINE=InnoDB;

-- ---------------
-- tbl_zoneinfo_escape_ios
-- ---------------
CREATE TABLE `tbl_zoneinfo_escape_ios` (
    `GAME` int(10) unsigned NOT NULL default 0,
    `ZONE` int(10) unsigned NOT NULL default 0,
    `NAME` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '服务器名字',
    `IP` varchar(16) NOT NULL default '0.0.0.0',
    `PORT` int(10) unsigned NOT NULL default 0,
    `WEBPORT` int(10) unsigned NOT NULL default 0,
    `TYPE` int(10) unsigned NOT NULL default 0,
    `STATUS` int(10) unsigned NOT NULL default 0 COMMENT '服务器状态',
    `DESC` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '描述',
    PRIMARY KEY  (`GAME`, `ZONE`)
) ENGINE=InnoDB;
