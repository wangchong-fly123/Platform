<?php

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
        $str_name = "tbl_account";
        $str_suffix = $hashcode % 32;
        $var = sprintf("%02u", $str_suffix);
        return $str_name.$var;
    }

    public static function getZoneInfoTableName($platform)
    {
        $table_name = "tbl_zoneinfo";

        if ($platform === "xy_ios" ||
            $platform === "papa_android") {
            $table_name .= '_'.$platform;
            return $table_name;
        } elseif ($platform === "0") {
            return $table_name;
        } else {
            return "";
        }
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
        $token = substr(str_replace(['/', '+', '='], '', base64_encode($bytes)), 0, $length);
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
        $ip = $_SERVER['REMOTE_ADDR'];
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
}
