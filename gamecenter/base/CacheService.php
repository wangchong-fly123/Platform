<?php

final class CacheService
{
    private $dbh_ = null;

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

    public function writeCache($key, $value, $timeout = 60)
    {   
        if (ServerConfig::$cache_switch == 0) {
            return false;
        }

        $redis = $this->getRedis();
        $result = $redis->set($key, $value);
        $redis->expire($uid, $timeout);
        return $result;
    }

    public function getCache($key)
    {   
        if (ServerConfig::$cache_switch == 0) {
            return false;
        }

        $redis = $this->getRedis();
        if ($redis->exists($key) === true) {
            return $redis->get($uid);
        }
        return false;
    }

}
