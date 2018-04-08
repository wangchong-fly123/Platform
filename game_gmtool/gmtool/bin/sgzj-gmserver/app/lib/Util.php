<?php

final class Util
{
    private static function createCurlHandler($url, $params,
                                              $method, $timeout)
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

        return $ch;
    }

    public static function httpRequest($url, $params=array(),
                                       $method='get', $timeout=10)
    {
        $ch = self::createCurlHandler($url, $params, $method, $timeout);
        $output = curl_exec($ch);
        if ($output === false) {
            error_log(curl_error($ch));
            curl_close($ch);
            return false;
        }
        curl_close($ch);

        return $output;
    }

    public static function multiHttpRequest($request_list)
    {
        $mh = curl_multi_init();
        $ch_list = array();
        $output_list = array();

        foreach ($request_list as $request) {
            $url = $request['url'];
            if (isset($request['params'])) {
                $params = $request['params']; 
            } else {
                $params = array();
            }
            if (isset($request['method'])) {
                $method = $request['method'];
            } else {
                $method = 'get';
            }
            if (isset($request['timeout'])) {
                $timeout = $request['timeout'];
            } else {
                $timeout = 100;
            }

            $ch = self::createCurlHandler(
                $url, $params, $method, $timeout);
            array_push($ch_list, $ch);
        }

        foreach ($ch_list as $ch) {
            curl_multi_add_handle($mh, $ch);
        }

        $running_task = null;
        do {
            curl_multi_exec($mh, $running_task);
            curl_multi_select($mh);
        } while ($running_task > 0);

        foreach ($ch_list as $ch) {
            $output = curl_multi_getcontent($ch);
            array_push($output_list, $output);
            curl_multi_remove_handle($mh, $ch);
            curl_close($ch);
        }
        curl_multi_close($mh);

        return $output_list;
    }

    private static function signHttpParams($addr, $secret_key, $uri, $params)
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

        return $params;
    }

    public static function signedHttpRequest($addr, $secret_key,
                                             $uri, $params=array(),
                                             $method = 'get', $timeout=10)
    {
        $url = $addr.$uri;
        $signed_params = self::signHttpParams(
            $addr, $secret_key, $uri, $params);

        return self::httpRequest(
            $url, $signed_params, $method, $timeout);
    }

    public static function multiSignedHttpRequest($request_list)
    {
        foreach ($request_list as &$request) {
            $request['url'] = $request['addr'].$request['uri'];
            if (isset($request['params']) === false) {
                $request['params'] = array();
            }
            $request['params'] = self::signHttpParams(
                $request['addr'], $request['secret_key'],
                $request['uri'], $request['params']);
        }

        return self::multiHttpRequest($request_list);
    }

    public static function dateToUnixTimestamp($date)
    {
        $year = substr($date, 0, 4);
        $month = substr($date, 4, 2);
        $day = substr($date, 6, 2);

        return mktime(0, 0, 0, $month, $day, $year);
    }

    public static function getDBHandler($config_ini_file)
    {
        // parse config ini file
        $config = parse_ini_file($config_ini_file);
        if ($config === false) {
            return false;
        }

        // connect db
        $db_host = $config['host'];
        $db_port = $config['port'];
        $db_name = $config['dbname'];
        $db_user = $config['username'];
        $db_password = $config['password'];
        $db_source = "mysql:host=$db_host;port=$db_port;".
                     "dbname=$db_name;charset=utf8";
        $dbh = new PDO($db_source, $db_user, $db_password);

        return $dbh;
    }

    public static function getServerInfo($dbh, $platform_id, $server_id)
    {
        $sth = $dbh->prepare(
            'select '.
            '`platform_id`, '.
            '`server_id`, '.
            '`desc`, '.
            '`addr`, '.
            '`secret_key` '.
            'from `tbl_server` '.
            'where `platform_id` = :platform_id '.
            'and `server_id` = :server_id');
        $sth->bindValue(':platform_id', $platform_id, PDO::PARAM_INT);
        $sth->bindValue(':server_id', $server_id, PDO::PARAM_INT);
        if ($sth->execute() === false) {
            return false;
        }

        return $sth->fetch(PDO::FETCH_ASSOC);
    }

    public static function getPlatformServerInfo($dbh, $platform_id)
    {
        $sth = $dbh->prepare(
            'select '.
            '`platform_id`, '.
            '`server_id`, '.
            '`desc`, '.
            '`addr`, '.
            '`secret_key` '.
            'from `tbl_server` '.
            'where `platform_id` = :platform_id ');
        $sth->bindValue(':platform_id', $platform_id, PDO::PARAM_INT);
        if ($sth->execute() === false) {
            return false;
        }

        return $sth->fetchAll(PDO::FETCH_ASSOC);
    }
}
