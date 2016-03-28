<?php

final class Config
{
    private static $lib_dir;
    private static $bin_dir;
    private static $settings_dir;
    private static $log_dir;

    public static function init()
    {  
        date_default_timezone_set('Asia/Shanghai');

        self::$lib_dir = realpath(__DIR__).'/';
        self::$bin_dir = realpath(__DIR__.'/..').'/';
        self::$settings_dir = realpath(__DIR__.'/../settings').'/';
        self::$log_dir = realpath(__DIR__.'/../bin/log').'/';

        spl_autoload_register(__NAMESPACE__.'Config::autoload');
    }   

    public static function getBinDir()
    {   
        return self::$bin_dir;
    }   

    public static function getSettingsDir()
    {   
        return self::$settings_dir;
    }

    public static function getLogDir()
    {   
        return self::$log_dir;
    }   

    private static function autoload($class_name)
    {   
        include self::$lib_dir.$class_name.'.php';
    }   
}

