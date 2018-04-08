set names utf8;

ALTER TABLE `tbl_account`
ADD `cps` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'CPS标识'
AFTER `exclude_channel`;
