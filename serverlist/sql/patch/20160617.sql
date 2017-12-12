alter table `tbl_zoneinfo`
add `START_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `DISABLE_GIFTCODE`;
alter table `tbl_zoneinfo`
add `END_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `START_TIME`;

alter table `tbl_zoneinfo_banshu`
add `START_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `DISABLE_GIFTCODE`;
alter table `tbl_zoneinfo_banshu`
add `END_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `START_TIME`;

alter table `tbl_zoneinfo_common_android`
add `START_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `DISABLE_GIFTCODE`;
alter table `tbl_zoneinfo_common_android`
add `END_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `START_TIME`;

alter table `tbl_zoneinfo_appstore_ios`
add `START_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `DISABLE_GIFTCODE`;
alter table `tbl_zoneinfo_appstore_ios`
add `END_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `START_TIME`;

alter table `tbl_zoneinfo_escape_ios`
add `START_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `DISABLE_GIFTCODE`;
alter table `tbl_zoneinfo_escape_ios`
add `END_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `START_TIME`;

alter table `tbl_zoneinfo_android_papa`
add `START_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `DISABLE_GIFTCODE`;
alter table `tbl_zoneinfo_android_papa`
add `END_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `START_TIME`;

alter table `tbl_zoneinfo_test`
add `START_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `DISABLE_GIFTCODE`;
alter table `tbl_zoneinfo_test`
add `END_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `START_TIME`;

alter table `tbl_zoneinfo_test_2`
add `START_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `DISABLE_GIFTCODE`;
alter table `tbl_zoneinfo_test_2`
add `END_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `START_TIME`;

alter table `tbl_zoneinfo_test_3`
add `START_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `DISABLE_GIFTCODE`;
alter table `tbl_zoneinfo_test_3`
add `END_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `START_TIME`;

alter table `tbl_zoneinfo_test_4`
add `START_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `DISABLE_GIFTCODE`;
alter table `tbl_zoneinfo_test_4`
add `END_TIME` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间(YYYY-mm-dd HH::ii:ss)'
after `START_TIME`;
