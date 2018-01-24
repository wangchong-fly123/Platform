<?php

final class Util
{
    private static $error_cb = null;

    public static function setErrorCallback($error_cb)
    {
        self::$error_cb = $error_cb;
    }

    public static function ClientErrorCallback($error_message, $error_code)
    {
        $ret = array(
            'result' => array(
                'error_code' => $error_code,
                'error_message'=> $error_message,
            ),
        );

        header('Content-type: application/json');
        echo json_encode($ret);
        exit();
    }

    public static function error($error_message, $error_code = -1)
    {
        if (self::$error_cb !== null) {
            call_user_func(self::$error_cb,
                $error_message, $error_code);
        } else {
            $ret = array(
                'error_code' => $error_code,
                'error_message'=> $error_message,
            );
            header('Content-type: application/json');
            echo json_encode($ret);
            exit();
        }
    }

    public static function response($response)
    {
        header('Content-type: application/json');
        echo json_encode($response);
        exit();
    }

    public static function httpRequest($url, $params=array(),
                                       $method='get', $timeout=10)
    {
        $query_string = '';
        foreach ($params as $key => $value) {
            $query_string .=
                rawurlencode($key).'='.
                rawurlencode($value).'&';
        }
        $query_string = substr($query_string, 0, -1);

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, $timeout);

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

    public static function signedHttpRequest($addr, $secret_key,
                                             $uri, $params=array(),
                                             $method = 'get', $timeout=10)
    {
        $url = $addr.$uri;
        $sign_string = $url;

        $params['ts'] = time();
        ksort($params);
        foreach ($params as $key => $value) {
            $sign_string .= $key.'='.$value;
        }
        $sign = sha1($sign_string.$secret_key);
        $params['sign'] = $sign;

        return self::httpRequest($url, $params, $method, $timeout);
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

    public static function checkInternalIp($ip)
    {
        $ip_list = array(
            '180.168.36.210',
            '112.65.46.8',
            '119.29.2.84',
            );
        return in_array($ip, $ip_list);
    }
}
