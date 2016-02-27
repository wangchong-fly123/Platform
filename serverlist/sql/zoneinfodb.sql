
-- ---------------
-- tbl_zoneinfo
-- ---------------
DROP TABLE IF EXISTS `tbl_zoneinfo`;
CREATE TABLE `tbl_zoneinfo` (
    `GAME` int(10) unsigned NOT NULL default 0,
    `ZONE` int(10) unsigned NOT NULL default 0,
    `NAME` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '服务器名字',
    `IP` varchar(16) NOT NULL default '0.0.0.0',
    `PORT` int(10) unsigned NOT NULL default 0,
    `WEBPORT` int(10) unsigned NOT NULL default 0,
    `TYPE` int(10) unsigned NOT NULL default 0,
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
    `IP` varchar(16) NOT NULL default '0.0.0.0',
    `PORT` int(10) unsigned NOT NULL default 0,
    `WEBPORT` int(10) unsigned NOT NULL default 0,
    `TYPE` int(10) unsigned NOT NULL default 0,
    `DESC` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '描述',
    PRIMARY KEY  (`GAME`, `ZONE`)
) ENGINE=InnoDB;

-- ---------------
-- tbl_zoneinfo_papa_android
-- ---------------
DROP TABLE IF EXISTS `tbl_zoneinfo_papa_android`;
CREATE TABLE `tbl_zoneinfo_papa_android` (
    `GAME` int(10) unsigned NOT NULL default 0,
    `ZONE` int(10) unsigned NOT NULL default 0,
    `NAME` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '服务器名字',
    `IP` varchar(16) NOT NULL default '0.0.0.0',
    `PORT` int(10) unsigned NOT NULL default 0,
    `WEBPORT` int(10) unsigned NOT NULL default 0,
    `TYPE` int(10) unsigned NOT NULL default 0,
    `DESC` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '描述',
    PRIMARY KEY  (`GAME`, `ZONE`)
) ENGINE=InnoDB;

-- ---------------
-- tbl_zoneinfo_xy_ios
-- ---------------
DROP TABLE IF EXISTS `tbl_zoneinfo_xy_ios`;
CREATE TABLE `tbl_zoneinfo_xy_ios` (
    `GAME` int(10) unsigned NOT NULL default 0,
    `ZONE` int(10) unsigned NOT NULL default 0,
    `NAME` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '服务器名字',
    `IP` varchar(16) NOT NULL default '0.0.0.0',
    `PORT` int(10) unsigned NOT NULL default 0,
    `WEBPORT` int(10) unsigned NOT NULL default 0,
    `TYPE` int(10) unsigned NOT NULL default 0,
    `DESC` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '描述',
    PRIMARY KEY  (`GAME`, `ZONE`)
) ENGINE=InnoDB;

-- ---------------
-- tbl_zoneinfo_xy_android
-- ---------------
DROP TABLE IF EXISTS `tbl_zoneinfo_xy_android`;
CREATE TABLE `tbl_zoneinfo_xy_android` (
    `GAME` int(10) unsigned NOT NULL default 0,
    `ZONE` int(10) unsigned NOT NULL default 0,
    `NAME` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '服务器名字',
    `IP` varchar(16) NOT NULL default '0.0.0.0',
    `PORT` int(10) unsigned NOT NULL default 0,
    `WEBPORT` int(10) unsigned NOT NULL default 0,
    `TYPE` int(10) unsigned NOT NULL default 0,
    `DESC` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '描述',
    PRIMARY KEY  (`GAME`, `ZONE`)
) ENGINE=InnoDB;

-- ---------------
-- tbl_zoneinfo_xy_escape
-- ---------------
DROP TABLE IF EXISTS `tbl_zoneinfo_xy_escape`;
CREATE TABLE `tbl_zoneinfo_xy_escape` (
    `GAME` int(10) unsigned NOT NULL default 0,
    `ZONE` int(10) unsigned NOT NULL default 0,
    `NAME` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '服务器名字',
    `IP` varchar(16) NOT NULL default '0.0.0.0',
    `PORT` int(10) unsigned NOT NULL default 0,
    `WEBPORT` int(10) unsigned NOT NULL default 0,
    `TYPE` int(10) unsigned NOT NULL default 0,
    `DESC` varchar(33) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL default '' COMMENT '描述',
    PRIMARY KEY  (`GAME`, `ZONE`)
) ENGINE=InnoDB;
