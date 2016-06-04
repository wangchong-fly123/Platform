<?php

final class ServerConfig
{
    public $app_secret_key;

    public $db_host;
    public $db_port;
    public $db_name;
    public $db_user;
    public $db_password;

    public $redis_host;
    public $redis_port;
    public $redis_db;
    public $redis_password;

    public function init()
    {
        $config_file = Config::getSettingsDir().'config.ini';
        $ret = parse_ini_file($config_file, true);
        if ($ret === false) {
            return false;
        }

        // app_secret_key
        if (isset($ret['app']['secret_key']) === false) {
            error_log('config /app/secret_key not found');
            return false;
        }
        $this->app_secret_key = $ret['app']['secret_key'];

        // db_host
        if (isset($ret['db']['host']) === false) {
            error_log('config /db/host not found');
            return false;
        }
        $this->db_host = $ret['db']['host'];

        // db_port
        if (isset($ret['db']['port']) === false) {
            error_log('config /db/port not found');
            return false;
        }
        $this->db_port = $ret['db']['port'];

        // db_name
        if (isset($ret['db']['name']) === false) {
            error_log('config /db/name not found');
            return false;
        }
        $this->db_name = $ret['db']['name'];

        // db_user
        if (isset($ret['db']['user']) === false) {
            error_log('config /db/user not found');
            return false;
        }
        $this->db_user = $ret['db']['user'];

        // db_password
        if (isset($ret['db']['password']) === false) {
            error_log('config /db/password not found');
            return false;
        }
        $this->db_password = $ret['db']['password'];

        // redis_host
        if (isset($ret['redis']['host']) === false) {
            error_log('config /redis/host not found');
            return false;
        }
        $this->redis_host = $ret['redis']['host'];

        // redis_port
        if (isset($ret['redis']['port']) === false) {
            error_log('config /redis/port not found');
            return false;
        }
        $this->redis_port = $ret['redis']['port'];

        // redis_db
        if (isset($ret['redis']['db']) === false) {
            error_log('config /redis/db not found');
            return false;
        }
        $this->redis_db = $ret['redis']['db'];

        // redis_password
        if (isset($ret['redis']['password']) === false) {
            error_log('config /redis/password not found');
            return false;
        }
        $this->redis_password = $ret['redis']['password'];

        return true;
    }
}
