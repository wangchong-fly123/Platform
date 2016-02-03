<?php

final class RegisterService
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

    public function register($user, $pass, $reg_type)
    {
        $username = strtoupper($user);
        $password = strtoupper($pass);
        $dbh = $this->getDBHandler();
        $regular = "/^[A-Za-z0-9]+$/";
        //$regular2 = "/^[a-zA-Z][a-zA-Z0-9_]{4,15}$/";

        if (0 == preg_match($regular, $username)
            || 0 == preg_match($regular, $password)) {
            //echo "输入必须是字母和数字或下划线组合,5-16个字符";
            return $this->error("register", 3);
        }
        if (strlen($username) < 5 || strlen($username) > 16
            || strlen($password) < 5 || strlen($password) > 16) {
            return $this->error("register", 3);
        }
        $table_name = Common::getRealTableName(Common::getHashCode($username));
        $res = $dbh->query("select `ACCOUNTNAME` from `$table_name` where `ACCOUNTNAME`='$username'");
        $col = $res->fetchColumn();
        if ($col == $username) {
            return $this->error("register", 4);
        }
        date_default_timezone_set("prc");
        $stringtime = date("Y-m-d H:i:s", time());
        $okpw = Common::encodePassword($password);
        $sth = $dbh->prepare('insert into `'.$table_name.'`(`ACCOUNTNAME`,`PASSWORD`,`REGTIMESTAMP`,`REGTYPE`) '.
                'VALUES(:username, :password, :stringtime, :reg_type)');
        $sth->bindValue(':username', $username, PDO::PARAM_STR);
        $sth->bindValue(':password', $okpw, PDO::PARAM_STR);
        $sth->bindValue(':stringtime', $stringtime, PDO::PARAM_STR);
        $sth->bindValue(':reg_type', $reg_type, PDO::PARAM_INT);
        if (@$sth->execute() === false) {
            return $this->error("register", 5);
        } else {
            if ($sth->rowCount() == 1) {
                $this->response(array("register" => "$user,$pass"));
            }
        }
        return $this->error("register", 6);
    }

}
