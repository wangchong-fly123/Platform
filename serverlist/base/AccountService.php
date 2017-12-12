<?php

require_once Config::getSettingsDir().'SlaveServerConfig.php';

final class AccountService
{
    private $dbh_ = null;
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
            $this->error("zone", -1);
        }
    }

    public function getDBHandler()
    { 
        if ($this->dbh_ != null) {
            return $this->dbh_;
        } 

        $db_host = ServerConfig::$db_host;
        $db_port = ServerConfig::$db_port;
        $db_name = ServerConfig::$db_name;
        $db_user = ServerConfig::$db_user;
        $db_password = ServerConfig::$db_password;
        $db_source = "mysql:host=$db_host;port=$db_port;".
            "dbname=$db_name;charset=utf8";

        $this->dbh_ = new PDO($db_source, $db_user, $db_password);

        return $this->dbh_;
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

    public function writeCache($account, $server_info)
    {   
        $redis = $this->getRedis();
        $result = $redis->set('account_'.$account, $server_info);
        $redis->expire($account, 3600);
        return $result;
    }

    public function getCache($account)
    {   
        $redis = $this->getRedis();
        if ($redis->exists('account_'.$account) === true) {
            return $redis->get('account_'.$account);
        }
        return false;
    }

    public function getAccountInfo($account)
    {
        $info = '';
        $dbh = $this->getDBHandler();

        $table_name = Common::getRealTableName(
            Common::getHashCode($account));

        $sth = $dbh->prepare(
                'select `SERVER_LIST` from `'.$table_name.'`'.
                ' where `ACCOUNT` = :account');
        $sth->bindParam(":account", $account);
        if (@$sth->execute() === false) {
        } else {
            while($res = $sth->fetch(PDO::FETCH_ASSOC)) {
                $info = $res['SERVER_LIST'];
                break;
            }
        }
        return $info;
    }

    public function updateAccountInfo($account, $server_id)
    {
        $dbh = $this->getDBHandler();
        $server_list = $this->getAccountInfo($account);
        $old_list = explode(";", $server_list);
        if (in_array($server_id, $old_list)) {
            return $server_list;
        } else {
            if ($server_list == "") {
                $server_list = $server_id;
            } else {
                $server_list .= ';'.$server_id;
            }
        }
        $table_name = Common::getRealTableName(
            Common::getHashCode($account));

        $sth = $dbh->prepare(
            'insert into `'.$table_name.'`(`ACCOUNT`, `SERVER_LIST`) '.
            'values (:account, :server) '.
            'on duplicate key update '.
            '`SERVER_LIST` = :server');
        $sth->bindValue(':account', $account, PDO::PARAM_STR);
        $sth->bindValue(':server', $server_list, PDO::PARAM_STR);
        if (@$sth->execute() === false) {
            return '';
        }
        return $server_list;
    }
}
