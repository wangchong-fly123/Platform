-- -------------------
-- tbl_talkingdata_ad_click
-- -------------------
DROP TABLE IF EXISTS `tbl_talkingdata_ad_click`;
CREATE TABLE `tbl_talkingdata_ad_click` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `appkey` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'APPKEY',
  `spread_url` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '推广活动唯一标识',
  `spread_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '推广活动名称',
  `ua` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '点击广告的设备UA信息',
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '点击广告的设备IP信息',
  `click_time` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '点击广告的时间',
  `adnet_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '推广渠道名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- -------------------
-- tbl_talkingdata_ad_active
-- -------------------
DROP TABLE IF EXISTS `tbl_talkingdata_ad_active`;
CREATE TABLE `tbl_talkingdata_ad_active` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `appkey` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'APPKEY',
  `event_time` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '应用激活时间',
  `os_version` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '设备的系统版本',
  `device_type` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '设备的类型',
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
  `adnet_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '推广渠道名称',
  `channel_package_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '应用中集成的分包ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- -------------------
-- tbl_talkingdata_ad_register
-- -------------------
DROP TABLE IF EXISTS `tbl_talkingdata_ad_register`;
CREATE TABLE `tbl_talkingdata_ad_register` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `appkey` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'APPKEY',
  `event_time` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '应用激活时间',
  `os_version` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '设备的系统版本',
  `device_type` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '设备的类型',
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
  `adnet_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '推广渠道名称',
  `channel_package_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '应用中集成的分包ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- -------------------
-- tbl_talkingdata_ad_create_role
-- -------------------
DROP TABLE IF EXISTS `tbl_talkingdata_ad_create_role`;
CREATE TABLE `tbl_talkingdata_ad_create_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `appkey` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'APPKEY',
  `role_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '角色名',
  `account_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'Account ID',
  `event_time` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '事件时间',
  `os_version` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '设备的系统版本',
  `device_type` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '设备的类型',
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
  `adnet_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '推广渠道名称',
  `deeplink` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'deeplink',
  `channel_package_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '应用中集成的分包ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- -------------------
-- tbl_talkingdata_ad_pay
-- -------------------
DROP TABLE IF EXISTS `tbl_talkingdata_ad_pay`;
CREATE TABLE `tbl_talkingdata_ad_pay` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `appkey` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'APPKEY',
  `order_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '订单号',
  `amount` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '订单价',
  `currency_type` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '货币类型',
  `account_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'Account ID',
  `event_time` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '事件时间',
  `os_version` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '设备的系统版本',
  `device_type` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '设备的类型',
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
  `adnet_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '推广渠道名称',
  `deeplink` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'deeplink',
  `channel_package_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '应用中集成的分包ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY unq_ua(`order_id`)
) ENGINE=InnoDB;

