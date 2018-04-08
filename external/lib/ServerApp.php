<?php

final class ServerApp
{
    private $server_config_ = null;
    private $db_handler_ = null;
    private $redis_handler_ = null;
    private $session_started_ = false;

    private $serverlist_service_ = null;
    private $playerlist_service_ = null;
    private $pay_notice_service_ = null;
    private $account_service_ = null;

    public function __construct()
    {
    }

    public function getServerConfig()
    {
        if ($this->server_config_ !== null) {
            return $this->server_config_;
        }

        $this->server_config_ = new ServerConfig();
        if ($this->server_config_->init() === false) {
            Util::error('load server config failed');
        }

        return $this->server_config_;
    }

    public function getDBHandler()
    {
        if ($this->db_handler_ !== null) {
            return $this->db_handler_;
        }

        $server_config = $this->getServerConfig();
        $db_host = $server_config->db_host;
        $db_port = $server_config->db_port;
        $db_name = $server_config->db_name;
        $db_user = $server_config->db_user;
        $db_password = $server_config->db_password;

        $db_source = "mysql:host=$db_host;port=$db_port;".
                     "dbname=$db_name;charset=utf8";
        $this->db_handler_ = new PDO($db_source, $db_user, $db_password);

        return $this->db_handler_;
    }

    public function getRedisHandler()
    {
        if ($this->redis_handler_ !== null) {
            return $this->redis_handler_;
        }

        $server_config = $this->getServerConfig();
        $redis_host = $server_config->redis_host;
        $redis_port = $server_config->redis_port;
        $redis_db = $server_config->redis_db;
        $redis_password = $server_config->redis_password;

        $this->redis_handler_ = new Redis();
        if ($this->redis_handler_->connect(
                $redis_host, $redis_port) === false) {
            Util::error('redis connect failed');
        }
        if (strlen($redis_password) > 0) {
            if ($this->redis_handler_->auth($redis_password) === false) {
                Util::error('redis auth failed');
            }
        }
        if ($this->redis_handler_->select($redis_db) === false) {
            Util::error('redis select failed');
        }

        return $this->redis_handler_;
    }

    private function startSession()
    {
        if ($this->session_started_) {
            return;
        }

        $server_config = $this->getServerConfig();
        $redis_host = $server_config->redis_host;
        $redis_port = $server_config->redis_port;
        $redis_db = $server_config->redis_db;
        $redis_password = $server_config->redis_password;

        ini_set('session.save_handler', 'redis');
        ini_set('session.save_path',
                "tcp://$redis_host:$redis_port".
                "?timeout=5&database=$redis_db&auth=$redis_password");

        session_start();

        $this->session_started_ = true;
    }

    public function getSession($key)
    {
       $this->startSession();

        if (isset($_SESSION[$key]) === false) {
            return null;
        }
        return $_SESSION[$key];
    }
    
    public function setSession($key, $value)
    {
        $this->startSession();

        $_SESSION[$key] = $value;
    }

    public function clearSession($key)
    {
        $this->startSession();

        unset($_SESSION[$key]);
    }

    public function checkRequestValid($server_params, $post_params)
    {
        $server_config = $this->getServerConfig();

        return Util::checkRequestValid(
            $server_config->app_secret_key, $server_params, $post_params);
    }

    public function getServerListService()
    {
        if ($this->serverlist_service_ !== null) {
            return $this->serverlist_service_;
        }

        $this->serverlist_service_ = new ServerListService($this);

        return $this->serverlist_service_;
    }

    public function getPlayerListService()
    {
        if ($this->playerlist_service_ !== null) {
            return $this->playerlist_service_;
        }

        $this->playerlist_service_ = new PlayerListService($this);

        return $this->playerlist_service_;
    }

    public function getPayNoticeService()
    {
        if ($this->pay_notice_service_ !== null) {
            return $this->pay_notice_service_;
        }

        $this->pay_notice_service_ = new PayNoticeService($this);

        return $this->pay_notice_service_;
    }

    public function getRoleAccountService()
    {
        if ($this->account_service_ !== null) {
            return $this->account_service_;
        }

        $this->account_service_ = new RoleAccountService($this);

        return $this->account_service_;
    }

    public function getClientIp()
    {
        $ip = 'unknown';

        if (getenv('HTTP_X_FORWARDED_FOR')) {
            // 使用透明代理、欺骗性代理的情况
            $ip = getenv('HTTP_X_FORWARDED_FOR');

        } elseif (getenv('REMOTE_ADDR')) {
            // 没有代理、使用普通匿名代理和高匿代理的情况
            $ip = getenv('REMOTE_ADDR');

        }

        // 处理多层代理的情况
        if (strpos($ip, ',') !== false) {
            // 输出第一个IP

            $ip = reset(explode(',', $ip));
        }

        return $ip;
    }
}
