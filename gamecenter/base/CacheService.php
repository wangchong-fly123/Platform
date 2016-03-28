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

    public function getCacheInfo($file)
    {
        if (ServerConfig::$cache_switch == 0) {
            return null;
        }
        $expire = ServerConfig::$cache_timeout;     //time out
        if (file_exists($file) && time() < filemtime($file) + $expire) {
            return unserialize(file_get_contents($file));
        } else {
            return null;
        }
    }

    public function setCacheInfo($file, $content)
    {
        if (ServerConfig::$cache_switch == 0) {
            return;
        }
        $output = serialize($content);
        $fp = fopen($file, "w");
        fwrite($fp, $output);
        fclose($fp);
    }
}
