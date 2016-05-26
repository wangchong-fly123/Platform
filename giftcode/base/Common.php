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
}
