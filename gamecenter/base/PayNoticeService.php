<?php

require_once Config::getSettingsDir().'AnySDKPlatformConfig.php';

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

    public function payNotice($params=array(), $slave_url)
    {
        $output = Common::httpRequest($slave_url, $params, 'post');
        echo $output;
        Common::logGameResponse($slave_url.'|'.$output);
        exit();
    }
}
