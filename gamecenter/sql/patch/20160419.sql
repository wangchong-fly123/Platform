alter table `tbl_zoneinfo`
add `STATUS` int(10) unsigned NOT NULL default 0 COMMENT '服务器状态'
after `TYPE`;
alter table `tbl_zoneinfo_banshu`
add `STATUS` int(10) unsigned NOT NULL default 0 COMMENT '服务器状态'
after `TYPE`;
alter table `tbl_zoneinfo_papa_test`
add `STATUS` int(10) unsigned NOT NULL default 0 COMMENT '服务器状态'
after `TYPE`;
alter table `tbl_zoneinfo_papa_android`
add `STATUS` int(10) unsigned NOT NULL default 0 COMMENT '服务器状态'
after `TYPE`;
alter table `tbl_zoneinfo_xy_ios`
add `STATUS` int(10) unsigned NOT NULL default 0 COMMENT '服务器状态'
after `TYPE`;
alter table `tbl_zoneinfo_xy_android`
add `STATUS` int(10) unsigned NOT NULL default 0 COMMENT '服务器状态'
after `TYPE`;
alter table `tbl_zoneinfo_xy_escape`
add `STATUS` int(10) unsigned NOT NULL default 0 COMMENT '服务器状态'
after `TYPE`;
