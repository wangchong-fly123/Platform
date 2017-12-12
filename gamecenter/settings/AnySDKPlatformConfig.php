<?php

final class AnySDKPlatformConfig
{
    public static $check_login_url = 'http://sdkcenter.enjoymi.com';
    public static $login_url_path = '/api/User/LoginOauth/';
    public static $allow_ip_list = array(
        '211.151.20.126',
        '211.151.20.127',
        '117.121.57.82',
        '119.29.223.147',
    );

    public static $login_url_default_port = 8002;
    public static $login_url_port = array(
        'papasdk' => '8003',
        'i4ios'   => '8004',
        'xyzs'    => '8004',
        'lssj'    => '8010',
    );
}
