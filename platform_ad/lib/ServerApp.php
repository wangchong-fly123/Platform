<?php

final class ServerApp
{
    private $server_config_ = null;
    private $db_handler_ = null;

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
}
