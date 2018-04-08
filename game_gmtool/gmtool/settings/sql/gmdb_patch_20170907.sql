set names utf8;

ALTER TABLE `tbl_channel`
ADD `state` int NOT NULL DEFAULT 1 COMMENT '状态'
AFTER `platform_id`;
