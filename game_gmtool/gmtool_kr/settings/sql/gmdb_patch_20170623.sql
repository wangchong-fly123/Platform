set names utf8;

-- -----------
-- tbl_spread
-- -----------
CREATE TABLE `tbl_spread` (
  `url` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '短链标识',
  `desc` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '描述',
  PRIMARY KEY (`url`)
) ENGINE=InnoDB;
