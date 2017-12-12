<?php

require_once Config::getSettingsDir().'AnySDKPlatformConfig.php';

final class LoginTokenService
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

    public function getRedis()
    {  
        if ($this->redis_ != null) {
            return $this->redis_;
        } 

        $redis_host = ServerConfig::$redis_host;
        $redis_port = ServerConfig::$redis_port;
        $redis_password = ServerConfig::$redis_password;

        $this->redis_ = new Redis();
        $result = $this->redis_->connect($redis_host, $redis_port);
        if ($result === false) {
            return null;
        }
        if (strlen($redis_password) > 0) {
            if ($this->redis_->auth($redis_password) === false) {
                return null;
            }
        }

        return $this->redis_;
    }

    public function writeToken($uid, $token)
    {   
        $redis = $this->getRedis();
        $result = $redis->set($uid, $token);
        $redis->expire($uid, 3600);
        return $result;
    }

    public function checkToken($uid, $token)
    {   
        $redis = $this->getRedis();
        if ($redis->exists($uid) === true) {
            if ($redis->get($uid) == $token) {
                return true;
            }
        }
        return false;
    }

    public function accessToken($params=array(), $channel)
    {
        $url = AnySDKPlatformConfig::$check_login_url;
        if (isset(AnySDKPlatformConfig::$login_url_port[$channel])) {
            $url .= ':'.AnySDKPlatformConfig::$login_url_port[$channel].
                AnySDKPlatformConfig::$login_url_path;
        } else {
            $url .= ':'.AnySDKPlatformConfig::$login_url_default_port.
                AnySDKPlatformConfig::$login_url_path;
        }
        $output = Common::httpRequest($url, $params, 'post');
        $ret = json_decode($output, true);
        if ($ret === null) {
            error_log($output);

            echo json_encode($ret);
            return false;
        } 

        if (isset($ret['status']) === false ||
            $ret['status'] != 'ok' ||
            isset($ret['common']) === false ||
            isset($ret['common']['uid']) === false) {
            error_log("any_sdk_platform: check_login failed: $output");

            echo json_encode($ret);
            return false;
        } 

        $save_uid = $ret['common']['channel'].'_'.$ret['common']['uid'];
        $token = Common::createToken(32);
        $this->writeToken($save_uid, $token);

        $ret['ext']['uid'] = $ret['common']['uid'];
        $ret['ext']['token'] = $token;
        $ret['ext']['channel'] = $ret['common']['channel'];

        echo json_encode($ret);
        return true;
    }
}
