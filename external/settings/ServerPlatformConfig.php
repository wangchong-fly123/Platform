<?php

final class ServerPlatformConfig
{
    public static $slave_key = '/qEOfXDgfGWQ5lZBfCtA/VZmgWwhbvSM/n7IagAFhHw=';
    public static $channel_change_switch = 0;
    public static $force_channel_change = 0;
    public static $channel_change_list = array(
            '500026' => '800002',
            '000000' => '800002',
    );
    public static $channel_download_list = array(
            '800002' => 'https://itunes.apple.com/cn/app/id1187917222?mt=8',
    );
    public static $gm_allow_ip_list = array(
            '180.168.36.210',
            '112.65.46.8',
    );

    // 游戏内绑定开关
    public static $in_game_bind_switch = 1;


    // 设备服务地址
    public static $device_service_url = 'http://device.enjoymi.com:9030/get_account_by_imei.php';

    // 短信服务地址
    public static $sms_service_url = 'http://message.enjoymi.com/sms_service.php';

    // 欢动通行证地址
    public static $passport_service_url = 'http://passport.enjoymi.com/internal/get_account_info_phone.php';

    
    // 账号转移配置  1:游戏内绑定,2:设备找回,3:双包转移,4:记录手机号和角色信息
    public static $channel_plan_list = array(
            '000000' => '2',
            '000001' => '1',
            '000002' => '2',
            '000003' => '3',
    );

    public static $official_platform_str = 'android_hdxxxx';

    public static $official_channel_str = '888888';

    public static $channel_pay_plugin = array(
            '000003' => '8',
    );

    public static $allow_ip_list = array(
        '117.121.57.82',
        '119.29.223.147',
    );

    public static $id_2_platform = array(
        21 => 'common_android',
        22 => 'android_papa',
        23 => 'appstore_ios',
        24 => 'escape_ios',
        25 => 'xy_ios',
        41 => 'android_ly',
        47 => 'escape_ly',
    );

    public static $platform_name_list = array(
        21 => '安卓全渠道',
        22 => '悟饭游戏厅',
        23 => 'iOS苹果商店',
        24 => 'iOS越狱',
        25 => 'iOS越狱(XY)',
        41 => '安卓联运',
        47 => '越狱联运',
    );

    public static $channel_name_list = array(
        '000002' => '机锋',
        '000003' => '当乐',
        '000005' => '安智市场',
        '000014' => '魅族应用商店',
        '000016' => '联想应用商店',
        '000020' => '可可游戏中心(OPPO)',
        '000023' => '360手机助手',
        '000066' => '小米应用商店',
        '000078' => '酷派应用商店',
        '000084' => '金立应用商店',
        '000108' => '4399手机开放平台',
        '000116' => '豌豆荚',
        '000247' => '拇指玩',
        '000255' => 'UC',
        '000323' => '泡椒',
        '000368' => '步步高应用商店(VIVO)',
        '000440' => '酷狗音乐',
        '000442' => 'PPS',
        '000458' => '美图秀秀',
        '000466' => '优酷',
        '000551' => '聚乐游戏',
        '000683' => '7k7k',
        '000997' => '狐狸助手',
        '001104' => '海马',
        '001201' => '果盘安卓',
        '001205' => '乐视手机',
        '110000' => '百度游戏',
        '110004' => '游龙',
        '111226' => '虫虫助手',
        '111314' => '葡萄',
        '160086' => '朋友玩',
        '160102' => '啪啪游戏厅',
        '160125' => '起点',
        '160136' => '腾讯应用宝(YSDK)',
        '160146' => 'TT语音',
        '160159' => '征游',
        '160160' => '华为游戏中心',
        '160162' => '小7手游(越狱)',
        '160198' => '小7手游（安卓）',
        '500003' => 'PP助手',
        '500004' => 'iTools',
        '500015' => '7659IOS',
        '500017' => '海马助手',
        '500020' => '爱思助手',
        '500026' => 'AppStore',
        '500030' => 'XY助手',
        '500035' => '果盘越狱',
        '800002' => 'IOS欢动',
        '800006' => 'IOS恺英分包',
        '800054' => 'ASO360',
        '000009' => '应用汇',
        '000065' => '沃商店',
        '000123' => '安卓pptv',
        '000243' => '七匣子',
        '000310' => '悠悠村',
        '000798' => '搜狗游戏中心',
        '111248' => '越狱pptv',
        '111290' => '手盟',
        '111323' => '猎宝网',
        '111346' => '努比亚',
        '160033' => '笨手机',
        '160070' => '顺网',
        '160116' => '好盟',
        '160140' => '乐游(魔格)',
        '160147' => '93PK',
        '160198' => '小7手游(安卓)',
        '160199' => 'efun',
        '160211' => '爱应用',
        '160227' => '怪猫',
        '160232' => '仙侠网络',
        '160240' => '西柚网络',
        '160268' => '游戏多',
        '160281' => '骑士助手',
        '160285' => '游戏Fan',
        '160287' => '凤凰网',
        '160305' => '游聚',
        '160326' => '冰穹互娱',
        '160336' => '72G渠道',
        '160346' => '菜鸟玩',
        '160362' => '东方二次元',
        '160378' => '耀星',
        '160394' => 'LINK',
        '400202' => '小鸡手柄',
        '800007' => '欢动',
        '800008' => 'TapTap',
        '800017' => '新游手柄',
    );

}
