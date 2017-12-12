<?php

require_once Config::getSettingsDir().'AnySDKPlatformConfig.php';
require_once Config::getSettingsDir().'TmallPlatformConfig.php';

final class PayNoticeService
{
    private $redis_ = null;

    public function __construct()
    {
    }

    public function error($error_type, $error_code = -1)
    {
        header('Content-type: application/json');
        echo json_encode(array($error_type => "error,$error_code"));
        exit();
    }

    public function response($response)
    {
        header('Content-type: application/json');
        echo json_encode($response);
        exit();
    }

    public function init()
    {
        if (ServerConfig::init() === false) {
            $this->error("login", -1);
        }
    }

    public function checkAnySDKSever($remote_ip)
    {
        if (!in_array($remote_ip, AnySDKPlatformConfig::$allow_ip_list)) {
            return false;
        }
        return true;
    }

    public function checkSeverIp($remote_ip)
    {
        if (!in_array($remote_ip, TmallPlatformConfig::$allow_ip_list)) {
            return false;
        }
        return true;
    }

    public function payNotice($params=array(), $slave_url)
    {
        $output = Common::httpRequest($slave_url, $params, 'post');
        echo $output;
        Common::logGameResponse($slave_url.'|'.$output);
        exit();
    }

    public function checkRequestValid($server_params,
            $request_params)
    {
        if (TmallPlatformConfig::$close_pay == 1) {
            return false;
        }
        $secret_key = TmallPlatformConfig::$secret_key;

        if (isset($request_params['sign']) === false) {
            return false;
        } 
        $sign = $request_params['sign'];

        // get request url
        $addr = $server_params['HTTP_HOST'];
        $uri = $server_params['DOCUMENT_URI'];
        $url = $addr.$uri;

        // remove sign from get_params
        unset($request_params['sign']);

        // check sign is invalid
        $sign_string = '';

        ksort($request_params);
        foreach ($request_params as $key => $value) {
            if ($value != '') {
                $sign_string .= $key.''.$value;
            }
        }   
        $calc_sign = md5($sign_string.$secret_key);
        if ($calc_sign !== $sign) {
            return false;
        }   

        return true;
    }

    public function payResponse($error_no)
    {
        echo $error_no;
        exit();
    }

    public function tmallPayNotice($params=array(), $slave_url)
    {
        $output = Common::httpRequest($slave_url, $params, 'post');
        echo $output;
        Common::logGameResponse($slave_url.'|'.$output);
        exit();
    }
}
