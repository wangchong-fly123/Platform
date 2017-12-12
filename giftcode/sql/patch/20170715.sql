-- ---------------
-- tbl_giftcode_public
-- ---------------
ALTER TABLE `tbl_giftcode_public`
ADD `start_time` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间'
AFTER `player_id`;

ALTER TABLE `tbl_giftcode_public`
ADD `end_time` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '结束时间'
AFTER `start_time`;

-- ---------------
-- tbl_giftcode_unique
-- ---------------
ALTER TABLE `tbl_giftcode_unique`
ADD `start_time` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '开始时间'
AFTER `player_id`;

ALTER TABLE `tbl_giftcode_unique`
ADD `end_time` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '结束时间'
AFTER `start_time`;
