set names utf8;

ALTER TABLE `tbl_account`
ADD `exclude_channel` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '排除渠道'
AFTER `platform_id`;
