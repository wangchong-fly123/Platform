set names utf8;

truncate table `tbl_pay_product`;
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(1, 7, '月卡7美元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(2, 1, '充值包1美元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(3, 5, '充值包5美元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(4, 10, '充值包10美元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(5, 15, '充值包15美元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(6, 30, '充值包30美元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(7, 50, '充值包50美元');
replace into `tbl_pay_product`(`id`, `amount`, `desc`) values(8, 100, '充值包100美元');

truncate table `tbl_platform`;
replace into `tbl_platform`(`id`, `desc`) values(81, 'IOS新马');
replace into `tbl_platform`(`id`, `desc`) values(82, 'Android新马');

truncate table `tbl_channel`;
replace into `tbl_channel`(`id`, `desc`, `platform_id`) values('800003', 'IOS新马',      81);
replace into `tbl_channel`(`id`, `desc`, `platform_id`) values('800005', 'Android新马',  82);
replace into `tbl_channel`(`id`, `desc`, `platform_id`) values('800014', 'IOS新马分包1', 81);
