<?php

final class LoginService
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

    public function isVisitorAccount($user)
    {
        $username = strtoupper($user);
        $dbh = $this->getDBHandler();

        $table_name = Common::getRealTableName(Common::getHashCode($username));
        $sth = $dbh->prepare('select `ID` from `'.$table_name.'`'.
            ' where `ACCOUNTNAME`= :username'.
            ' and `REGTYPE`= 1');
        $sth->bindValue(':username', $username, PDO::PARAM_STR);
        $sth->execute();
        $res = $sth->fetchAll(PDO::FETCH_ASSOC);
        if (count($res)) {
            return true;
        }
        return false;
    }

    public function login($user, $pass, $game)
    {  
        $username = strtoupper($user);
        $password = strtoupper($pass);
        $dbh = $this->getDBHandler();

        $table_name = Common::getRealTableName(Common::getHashCode($username));
        $okpw = Common::encodePassword($password);
        $sth = $dbh->prepare('select `ACCOUNTNAME` from `'.$table_name.'`'.
            ' where `ACCOUNTNAME`= :username'.
            ' and `PASSWORD`= :okpw');
        $sth->bindValue(':username', $username, PDO::PARAM_STR);
        $sth->bindValue(':okpw', $okpw, PDO::PARAM_STR);
        $sth->execute();
        $res = $sth->fetchAll(PDO::FETCH_ASSOC);
        if (count($res)) {
            return true;
        }
        return false;
    }
}
