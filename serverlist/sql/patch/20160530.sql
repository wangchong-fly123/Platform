alter table `tbl_zoneinfo`
add `DISABLE_GIFTCODE` int(10) unsigned NOT NULL default 0 COMMENT '禁止礼包码'
after `TIPS`;
alter table `tbl_zoneinfo_banshu`
add `DISABLE_GIFTCODE` int(10) unsigned NOT NULL default 0 COMMENT '禁止礼包码'
after `TIPS`;
alter table `tbl_zoneinfo_common_android`
add `DISABLE_GIFTCODE` int(10) unsigned NOT NULL default 0 COMMENT '禁止礼包码'
after `TIPS`;
alter table `tbl_zoneinfo_appstore_ios`
add `DISABLE_GIFTCODE` int(10) unsigned NOT NULL default 0 COMMENT '禁止礼包码'
after `TIPS`;
alter table `tbl_zoneinfo_escape_ios`
add `DISABLE_GIFTCODE` int(10) unsigned NOT NULL default 0 COMMENT '禁止礼包码'
after `TIPS`;
alter table `tbl_zoneinfo_android_papa`
add `DISABLE_GIFTCODE` int(10) unsigned NOT NULL default 0 COMMENT '禁止礼包码'
after `TIPS`;
alter table `tbl_zoneinfo_test`
add `DISABLE_GIFTCODE` int(10) unsigned NOT NULL default 0 COMMENT '禁止礼包码'
after `TIPS`;
alter table `tbl_zoneinfo_test_2`
add `DISABLE_GIFTCODE` int(10) unsigned NOT NULL default 0 COMMENT '禁止礼包码'
after `TIPS`;
