set names utf8;

truncate table `tbl_pay_product`;
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(1, 30, '月卡30元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(2, 10, '充值包10元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(3, 50, '充值包50元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(4, 100, '充值包100元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(5, 200, '充值包200元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(6, 300, '充值包300元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(7, 500, '充值包500元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(8, 1000, '充值包1000元');

truncate table `tbl_platform`;
replace into `tbl_platform`(`id`, `desc`) values(42, '米娱');
replace into `tbl_platform`(`id`, `desc`) values(43, '大麦助手');
replace into `tbl_platform`(`id`, `desc`) values(46, '185手游');

truncate table `tbl_channel`;
replace into `tbl_channel`(`id`, `desc`, `platform_id`) values('160237', '米娱',                         42);
replace into `tbl_channel`(`id`, `desc`, `platform_id`) values('160238', '大麦助手',                     43);
replace into `tbl_channel`(`id`, `desc`, `platform_id`) values('160251', '185手游安卓',                  46);
replace into `tbl_channel`(`id`, `desc`, `platform_id`) values('160252', '185手游越狱',                  46);
