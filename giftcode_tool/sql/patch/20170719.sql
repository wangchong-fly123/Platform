alter TABLE tbl_giftcode_unique add `start_time` varchar(60) COLLATE utf8_bin NOT NULL;
alter TABLE tbl_giftcode_public add `start_time` varchar(60) COLLATE utf8_bin NOT NULL;
alter TABLE tbl_giftcode_unique add `end_time` varchar(60) COLLATE utf8_bin NOT NULL;
alter TABLE tbl_giftcode_public add `end_time` varchar(60) COLLATE utf8_bin NOT NULL;
