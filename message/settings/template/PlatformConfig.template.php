<?php

final class PlatformConfig
{
    public static $access_key_id = 'LTAI2lGoslHCHvLlrassss';
    public static $access_key_secret = 'IE53iHgTy6UbYU8n3u734Ih6sBETQ6Bn';

    public static $signature = '我的游戏';

    public static $ali_message_type_list = array(
        'register'             => 'SMS_78565180',
        'find_password'        => 'SMS_78685181',
        'change_phone'         => 'SMS_78560180',
        'change_phone_confirm' => 'SMS_78545191',
        'customer_notify'      => 'SMS_85770009',
    );

    public static $ucpaas_message_type_list = array(
        'register'             => 'SMS_78565180',
        'find_password'        => 'SMS_78685181',
        'change_phone'         => 'SMS_78560180',
        'change_phone_confirm' => 'SMS_78545191',
        'customer_notify'      => 'SMS_85770009',
    );
    
    public static $allow_ip_list = array(
        '180.168.36.210',
        '112.65.46.8',
        '192.168.0.119',
        '119.29.240.105',
    );
    
    public static $clientid = 'xxxxx';
    public static $password = 'yyyyyy';

    public static $service_type = 'ali'; //ucpaas,ali
}
