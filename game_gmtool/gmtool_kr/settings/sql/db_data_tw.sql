set names utf8;

truncate table `tbl_pay_product`;
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(1, 25, '月卡25元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(2, 6, '充值包6元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(3, 30, '充值包30元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(4, 60, '充值包60元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(5, 98, '充值包98元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(6, 168, '充值包168元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(7, 328, '充值包328元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(8, 648, '充值包648元');

truncate table `tbl_platform`;
replace into `tbl_platform`(`id`, `desc`) values(91, 'IOS台湾');
replace into `tbl_platform`(`id`, `desc`) values(92, 'Android台湾');

truncate table `tbl_channel`;
