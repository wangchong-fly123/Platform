-- -------------------
-- tbl_talkingdata_ad_click
-- -------------------
ALTER TABLE `tbl_talkingdata_ad_click`
ADD `appstore_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'APPSTOREID'
AFTER `adnet_name`;

-- -------------------
-- tbl_talkingdata_ad_active
-- -------------------
ALTER TABLE `tbl_talkingdata_ad_active`
ADD `appstore_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'APPSTOREID'
AFTER `adnet_name`;

-- -------------------
-- tbl_talkingdata_ad_register
-- -------------------
ALTER TABLE `tbl_talkingdata_ad_register`
ADD `appstore_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'APPSTOREID'
AFTER `adnet_name`;

-- -------------------
-- tbl_talkingdata_ad_create_role
-- -------------------
ALTER TABLE `tbl_talkingdata_ad_create_role`
ADD `appstore_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'APPSTOREID'
AFTER `adnet_name`;

-- -------------------
-- tbl_talkingdata_ad_pay
-- -------------------
ALTER TABLE `tbl_talkingdata_ad_pay`
ADD `appstore_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'APPSTOREID'
AFTER `adnet_name`;
