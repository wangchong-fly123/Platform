<?php

final class ServerConfig
{
    public $db_host;
    public $db_port;
    public $db_name;
    public $db_user;
    public $db_password;
    public $ratio_switch;
    public $pay_ratio;
    public $force_ratio;
    public $app_secret_key;

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

        return true;
    }
}
