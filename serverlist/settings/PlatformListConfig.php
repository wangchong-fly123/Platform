<?php

final class PlatformListConfig
{
    //安卓通用
    public static $android_common_platform_list = array(
        'android_yyb' => 'common_android',
        'android_yyb_ad1' => 'common_android',
        'android_yyb_ad2' => 'common_android',
        'android_yyb_ad3' => 'common_android',
        'android_weixin' => 'test_2',
        'android_mi' => 'common_android',
        'android_qihu360' => 'common_android',
        'android_coolpad' => 'common_android',
        'android_huawei' => 'common_android',
        'android_nearme' => 'common_android',
        'android_vivo' => 'common_android',
        'android_iqiyi' => 'common_android',
        'android_uc' => 'common_android',
        'android_haima' => 'common_android',
        'android_bd' => 'common_android',
        'android_am' => 'common_android',
        'android_meizu' => 'common_android',
        'android_lenovo' => 'common_android',
        'android_meitu' => 'test_2',
        'android_xunlei' => 'test_2',
        'android_m4399' => 'common_android',
        'android_anzhi' => 'common_android',
        'android_letvs' => 'common_android',
        'android_kugou' => 'common_android',
        'android_wdj' => 'common_android',
        'android_mzw' => 'common_android',
        'android_pj' => 'common_android',
        'android_qike' => 'common_android',
        'android_dl' => 'common_android',
        'android_xinyou' => 'test_2',
        'android_yq' => 'common_android',
        'android_htc' => 'common_android',
        'android_gfan' => 'common_android',
        'android_youlong' => 'common_android',
        'android_tt' => 'common_android',
        'android_youku' => 'common_android',
        'android_qidian' => 'common_android',
        'android_putao' => 'common_android',
        'android_zy43997' => 'common_android',
        'android_guopan' => 'common_android',
        'android_n7659' => 'common_android',
        'android_cczs' => 'common_android',
    );
    //IOS appstore
    public static $ios_appstore_platform_list = array(
        'ios_apple' => 'appstore_ios',
        'ios_Backup1' => 'test_2',
        'ios_backup_AA' => 'test_3',
        'ios_audit' => 'audit',
    );
    //IOS 越狱
    public static $ios_escape_platform_list = array(
        'ios_i4' => 'escape_ios',
        'ios_pp' => 'test_2',
        'ios_n7659' => 'escape_ios',
        'ios_itools' => 'escape_ios',
        'ios_huli' => 'test_2',
        'ios_xyzs' => 'xy_ios',
        'ios_guopan' => 'escape_ios',
        'ios_tongbu' => 'test_2',
        'ios_x7sy' => 'escape_ios',
    );
    //安卓独立
    public static $android_single_platform_list = array(
        'android_papa' => 'android_papa',
	'test_android' => 'test_3',
	'test_ios' => 'test_3',
	'enjoymi' => 'test_3',
    );

    //外网真实测试环境
    public static $beta_platform_list = array(
        'android_iqiyi@0.12.0.0(12)' => 'test_2',
        'ios_xyzs@0.12.1.2(50)' => 'test_2',
        'ios_i4@0.12.1.2(50)' => 'test_2',
        'ios_n7659@0.12.1.2(50)' => 'test_2',
        'ios_itools@0.12.1.2(50)' => 'test_2',
        'ios_guopan@0.12.1.2(50)' => 'test_2',
        'ios_x7sy@0.12.1.2(50)' => 'test_2',
        'ios_tongbu@0.12.1.2(50)' => 'test_2',
    );

    public static $platform_list_id = array(
        13 => 'test_2',
        21 => 'common_android',
        22 => 'android_papa',
        23 => 'appstore_ios',
        24 => 'escape_ios',
        25 => 'xy_ios',
    );
}
