-- -----------
-- tbl_account
-- -----------
DROP TABLE IF EXISTS `tbl_account`;
CREATE TABLE `tbl_account` (
  `uid` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `account` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '帐号',
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '密码',
  `account_type` int NOT NULL COMMENT '账号类型:0-普通账号1-游客账号',
  `register_type` int NOT NULL COMMENT '注册类型:0-快速注册1-手机注册2-游客注册',
  `mobile_phone` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin COMMENT '手机号',
  `email` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin COMMENT '邮箱',
  `create_time` bigint NOT NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`uid`),
  UNIQUE KEY unq_account(`account`),
  UNIQUE KEY unq_mobile_phone(`mobile_phone`),
  UNIQUE KEY unq_email(`email`)
) ENGINE=InnoDB AUTO_INCREMENT = 100000000;
