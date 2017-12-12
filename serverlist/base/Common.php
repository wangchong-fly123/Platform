<?php

require_once Config::getSettingsDir().'PlatformListConfig.php';

final class Common
{
    public static function getHashCode($str)
    {
        $hash = 0;
        $n = strlen($str);
        for ($i = 0; $i <$n; $i++)
        {
            $hash += ($hash <<5 ) + ord($str[$i]);
        }
        if ($hash < 0) {
            $hash = sprintf('%u', $hash);
        }
        return $hash % 701819;
    }

    public static function getRealTableName($hashcode)
    {
        $str_name = "tbl_account_info";
        $str_suffix = abs($hashcode) % 128;
        $var = sprintf("%03u", $str_suffix);
        return $str_name.$var;
    }

    public static function getZoneInfoTableName($platform)
    {
        $table_name = "tbl_zoneinfo";

        if (strpos($platform, '@') !== false) {
            if (isset(PlatformListConfig::$beta_platform_list[$platform])) {
                return $table_name.'_'.
                    PlatformListConfig::$beta_platform_list[$platform];
            } else {
                $platform_array = explode('@', $platform);
                $platform = $platform_array[0];
            }
        }

        if (isset(PlatformListConfig::$android_common_platform_list[$platform])) {
            return $table_name.'_'.
                PlatformListConfig::$android_common_platform_list[$platform];

        } elseif (isset(PlatformListConfig::$ios_appstore_platform_list[$platform])) {
            return $table_name.'_'.
                PlatformListConfig::$ios_appstore_platform_list[$platform];

        } elseif (isset(PlatformListConfig::$ios_escape_platform_list[$platform])) {
            return $table_name.'_'.
                PlatformListConfig::$ios_escape_platform_list[$platform];

        } elseif (isset(PlatformListConfig::$android_single_platform_list[$platform])) {
            return $table_name.'_'.
                PlatformListConfig::$android_single_platform_list[$platform];

        } else {
            if ($platform === "0") {
                return $table_name;
            }
        }

        return "";
    }

    public static function getZoneInfoTableNameById($platform_id)
    {
        $table_name = "tbl_zoneinfo";

        if (isset(PlatformListConfig::$platform_list_id[$platform_id])) {
            return $table_name.'_'.
                PlatformListConfig::$platform_list_id[$platform_id];
        } else {
            if ($platform_id == 0) {
                return $table_name;
            }
        }
        return "";
    }

    public static function encodePassword($password)
    {
        define('CONSTKEY', 'hhuuaann');
        $password .= CONSTKEY;
        $mpw = md5($password);
        return substr($mpw, 5, 20);
    }

    public static function getActiveTableNameByGame($game)
    {
        if($game > 9999)
        {
            return "";
        }
        else
        {
            $var = sprintf("%04d", $game);
            return "tbl_activecode".$var;
        }
    }

    public static function createToken($length)
    {
        $bytes = openssl_random_pseudo_bytes($length * 2);
        $token = substr(str_replace(array('/', '+', '='), '', base64_encode($bytes)), 0, $length);
        return $token;
    }

    public static function createNumericCode($length)
    {
        $password = '';
        for ($i = 0; $i < $length; $i++)
        {
            $password .= rand(0, 9);
        }

        return $password;
    }

    public static function execUrl($url)
    {
        $ch = curl_init();
        $timeout = 300;
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Expect:'));
        $handles = curl_exec($ch);
        curl_close($ch);
        return $handles;
    }

    public static function createSign($secret_key, $url, $params=array())
    {
        $query_string = '';
        $sign_string = $url;

        $params['ts'] = time();
        ksort($params);
        foreach ($params as $key => $value) {
            $query_string .=
                rawurlencode($key).'='.
                rawurlencode($value).'&';
            $sign_string .= $key.'='.$value;
        }
        $sign = sha1($sign_string.$secret_key);
        $request_url = $url.'?'.$query_string."sign=".$sign;
        return $request_url;
    }

    public static function httpRequest($url, $params=array(), $method='get')
    {
        $query_string = '';
        foreach ($params as $key => $value) {
            $query_string .=
                rawurlencode($key).'='.
                rawurlencode($value).'&';
        }
        substr($query_string, 0, -1);

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        if (strtolower($method) === 'get') {
            // get method
            if (strlen($query_string) > 0) {
                curl_setopt($ch, CURLOPT_URL, $url.'?'.$query_string);
            } else {
                curl_setopt($ch, CURLOPT_URL, $url);
            }
        } else {
            // post method
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $query_string);
        }

        $output = curl_exec($ch);
        if ($output === false) {
            error_log(curl_error($ch));
            curl_close($ch);
            return false;
        }
        curl_close($ch);

        return $output;
    }

    public static function logPayRequest($server_params, $request_params)
    {
        $log_file = Config::getLogDir().
            'anysdk-pay.'.date('Ymd').'.log';

        $now = time();
        $ip = self::getClientIp();
        $port = $_SERVER['REMOTE_PORT'];
        $url = $server_params['HTTP_HOST'].
            $server_params['DOCUMENT_URI'];
        $request_string = '';
        foreach ($request_params as $key => $value) {
            $request_string .= $key.'='.$value.'&';
        }
        $request_string = substr($request_string, 0, -1);
        $log_string = "$now|$ip:$port|$url|$request_string";

        file_put_contents($log_file, $log_string."\n", FILE_APPEND);
    }

    public static function logGameResponse($game_result)
    {
        $log_file = Config::getLogDir().
            'anysdk-pay.'.date('Ymd').'.log';

        $now = time();
        $log_string = "$now|$game_result";

        file_put_contents($log_file, $log_string."\n", FILE_APPEND);
    }

    public static function checkRequestValid($secret_key, $server_params,
                                      $request_params)
    {
        if (isset($request_params['sign']) === false ||
            isset($request_params['ts']) === false) {
            return false;
        }
        $sign = $request_params['sign'];
        $ts = $request_params['ts'];

        // check ts is in 15 min
        $now = time();
        if (abs($now - $ts) > 900) {
            return false;
        }

        // get request url
        $addr = $server_params['HTTP_HOST'];
        $uri = $server_params['DOCUMENT_URI'];
        $url = $addr.$uri;

        // remove sign from get_params
        unset($request_params['sign']);

        // check sign is invalid
        $sign_string = $url;

        ksort($request_params);
        foreach ($request_params as $key => $value) {
            $sign_string .= $key.'='.$value;
        }
        $calc_sign = sha1($sign_string.$secret_key);
        if ($calc_sign !== $sign) {
            return false;
        }

        return true;
    }

    public static function getClientIp()
    {
        $ip = 'unknown';

        if (getenv('HTTP_X_FORWARDED_FOR')) {
            // 使用透明代理、欺骗性代理的情况
            $ip = getenv('HTTP_X_FORWARDED_FOR');

        } elseif (getenv('REMOTE_ADDR')) {
            // 没有代理、使用普通匿名代理和高匿代理的情况
            $ip = getenv('REMOTE_ADDR');

        }

        // 处理多层代理的情况
        if (strpos($ip, ',') !== false) {
            // 输出第一个IP

            $ip = reset(explode(',', $ip));
        }

        return $ip;
    }
}
