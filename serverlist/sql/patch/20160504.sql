alter table `tbl_zoneinfo`
add `TIPS` int(10) unsigned NOT NULL default 0 COMMENT '服务器标签'
after `STATUS`;
alter table `tbl_zoneinfo_banshu`
add `TIPS` int(10) unsigned NOT NULL default 0 COMMENT '服务器标签'
after `STATUS`;
alter table `tbl_zoneinfo_common_android`
add `TIPS` int(10) unsigned NOT NULL default 0 COMMENT '服务器标签'
after `STATUS`;
alter table `tbl_zoneinfo_appstore_ios`
add `TIPS` int(10) unsigned NOT NULL default 0 COMMENT '服务器标签'
after `STATUS`;
alter table `tbl_zoneinfo_escape_ios`
add `TIPS` int(10) unsigned NOT NULL default 0 COMMENT '服务器标签'
after `STATUS`;
