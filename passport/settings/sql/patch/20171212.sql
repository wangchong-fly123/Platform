
ALTER TABLE `tbl_account`
ADD `last_login_time` bigint NOT NULL DEFAULT 0 COMMENT '上次登录时间'
AFTER `id_num`;
