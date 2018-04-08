-- -------------------
-- tbl_talkingdata_ad_active
-- -------------------
ALTER TABLE `tbl_talkingdata_ad_active`
ADD `idfa` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'IDFA'
AFTER `device_type`;

-- -------------------
-- tbl_talkingdata_ad_register
-- -------------------
ALTER TABLE `tbl_talkingdata_ad_register`
ADD `account_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'ACCOUNTID'
AFTER `appkey`;
ALTER TABLE `tbl_talkingdata_ad_register`
ADD `idfa` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'IDFA'
AFTER `device_type`;
ALTER TABLE `tbl_talkingdata_ad_register`
ADD `deeplink` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'DEEPLINK'
AFTER `adnet_name`;

-- -------------------
-- tbl_talkingdata_ad_login
-- -------------------
DROP TABLE IF EXISTS `tbl_talkingdata_ad_login`;
CREATE TABLE `tbl_talkingdata_ad_login` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `appkey` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'APPKEY',
  `account_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'ACCOUNTID',
  `event_time` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '应用激活时间',
  `os_version` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '设备的系统版本',
  `device_type` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '设备的类型',
  `idfa` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'IDFA',
  `mac` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'android设备id',
  `advertising_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'android设备id',
  `android_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'android设备id',
  `imei` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'IMEI',
  `tdid` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'TDID',
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '激活IP',
  `spread_url` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '推广活动唯一标识',
  `spread_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '推广活动名称',
  `ua` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '点击广告的设备UA信息',
  `click_ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '点击广告的设备IP信息',
  `click_time` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '点击广告的时间',
  `appstore_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'APPSTOREID',
  `adnet_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '推广渠道名称',
  `deeplink` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'DEEPLINK',
  `channel_package_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '应用中集成的分包ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- -------------------
-- tbl_talkingdata_ad_create_role
-- -------------------
ALTER TABLE `tbl_talkingdata_ad_create_role`
ADD `idfa` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'IDFA'
AFTER `device_type`;

-- -------------------
-- tbl_talkingdata_ad_pay
-- -------------------
ALTER TABLE `tbl_talkingdata_ad_pay`
ADD `idfa` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'IDFA'
AFTER `device_type`;
