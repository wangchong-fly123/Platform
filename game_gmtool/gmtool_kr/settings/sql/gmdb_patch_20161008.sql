set names utf8;

ALTER TABLE `tbl_account`
ADD `platform_id` int NOT NULL COMMENT '平台ID'
AFTER `account_type`;

ALTER TABLE `tbl_channel`
ADD `platform_id` int NOT NULL COMMENT '平台ID'
AFTER `desc`;
