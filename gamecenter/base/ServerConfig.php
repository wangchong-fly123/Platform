<?php

final class ServerConfig
{
    public static $db_host;
    public static $db_port;
    public static $db_name;
    public static $db_user;
    public static $db_password;
    public static $cache_switch;
    public static $cache_timeout;
    public static $redis_host;
    public static $redis_port;
    public static $redis_password;

    public static function init()
    {
        $file_path = Config::getSettingsDir().'config.ini';
        $array = array();
        $array = parse_ini_file($file_path);
        if(count($array) < 3) {
            error_log('config.ini info error, please check it!!!');
            return false;
        }

        self::$db_host = $array["dbHost"];
        self::$db_port = $array["dbPort"];
        self::$db_name = $array["dbName"];
        self::$db_user = $array["dbUser"];
        self::$db_password = $array["dbPwd"];
        self::$cache_switch = $array["cacheSwitch"];
        self::$cache_timeout = $array["cacheTimeout"];
        self::$redis_host = $array["redisHost"];
        self::$redis_port = $array["redisPort"];
        self::$redis_password = $array["redisPwd"];
        return true;
    }
}
