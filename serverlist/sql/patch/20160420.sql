-- ---------------
-- tbl_zoneinfo_qihu_android
-- ---------------
CREATE TABLE `tbl_zoneinfo_qihu_android` (
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
