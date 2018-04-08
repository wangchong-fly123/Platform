CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `order_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `order_time` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `order_money` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `channel_product_id` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `uid` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `productid` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `serverid` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `guid` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `order_expand` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `prepay_id` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `status` varchar(64) COLLATE utf8_bin DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
