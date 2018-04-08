<?php

final class Config
{
    private static $lib_dir;
    private static $settings_dir;

    public static function init()
    {
        date_default_timezone_set('Asia/Shanghai');

        self::$lib_dir = realpath(__DIR__).'/';
        self::$settings_dir = realpath(__DIR__.'/../settings').'/';

        spl_autoload_register(__NAMESPACE__.'Config::autoload');
    }

    public static function getSettingsDir()
    {
        return self::$settings_dir;
    }

    private static function autoload($class_name)
    {
        include self::$lib_dir.$class_name.'.php';
    }
}
