-- -----------
-- tbl_wfc_account
-- -----------
CREATE TABLE `tbl_wfc_account` (
  `account` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '帐号',
  `server_info` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '区服信息',
  `id` int NOT NULL COMMENT '编号',
  `round_win_times` int NOT NULL COMMENT '胜利轮次',
  `is_out` int NOT NULL COMMENT '是否被淘汰',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

