-- -------------------
-- tbl_weixin_ad_click
-- -------------------
DROP TABLE IF EXISTS `tbl_weixin_ad_click`;
CREATE TABLE `tbl_weixin_ad_click` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `muid` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '设备ID',
  `appid` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '应用ID',
  `advertiser_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '广告主账户ID',
  `app_type` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '应用类型',
  `click_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '点击ID',
  `click_time` bigint NOT NULL DEFAULT 0 COMMENT '点击时间',
  `activite_time` bigint NOT NULL DEFAULT 0 COMMENT '激活时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY unq_muid_appid_advertiser_id(`muid`, `appid`, `advertiser_id`),
  KEY idx_click_id(`click_id`)
) ENGINE=InnoDB;
