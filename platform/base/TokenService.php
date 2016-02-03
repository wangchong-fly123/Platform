<?php

final class TokenService
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

    public function checkToken($account, $game, $token)
    { 
        date_default_timezone_set("prc");
        $stringtime = date("Y-m-d H:i:s", time());
        $dbh = $this->getDBHandler();
        $table_name = Common::getTokenTableByGame($game);
        $res = $dbh->query("select `ACCOUNT` from `$table_name`".
                " where `ACCOUNT`='$account' and ".
                "`TOKEN`='$token' and ".
                "`UNTILTIMESTAMP`>='$stringtime'");
        $result = $res->fetchColumn();
        if ($result == $account) {
            return true;
        }
        return false;
    }

    public function writeToken($account, $game, $token)
    {
        $dbh = $this->getDBHandler();
        $table_name = Common::getTokenTableByGame($game);
        $sth = $dbh->prepare('delete from `'.$table_name.'` where `ACCOUNT`=:account');
        $sth->bindValue(':account', $account, PDO::PARAM_STR);
        if (@$sth->execute() === false) {
            return $this->error("login", 5);
        }

        date_default_timezone_set("prc");
        $stringtime = date("Y-m-d H:i:s", time() + ServerConfig::$token_timeout);
        $sth = $dbh->prepare('insert into `'.$table_name.'` (`ACCOUNT`,`TOKEN`,`UNTILTIMESTAMP`)'.
                'values(:account, :token, :timestamp)');
        $sth->bindValue(':account', $account, PDO::PARAM_STR);
        $sth->bindValue(':token', $token, PDO::PARAM_STR);
        $sth->bindValue(':timestamp', $stringtime, PDO::PARAM_STR);
        if (@$sth->execute() === false) {
            return $this->error("login", 5);
        }
    }
}
