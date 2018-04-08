set names utf8;

CREATE TABLE `tbl_pay_product` (
  `id` int NOT NULL COMMENT '商品编号',
  `amount` int NOT NULL COMMENT '价格',
  `desc` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '描述',
  PRIMARY KEY(`id`)
) ENGINE=InnoDB;
