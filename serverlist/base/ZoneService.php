<?php

final class ZoneService
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

    public function getZoneInfo($game, $type, $platform)
    {   
        $dbh = $this->getDBHandler();
        $table_name = Common::getZoneInfoTableName($platform);

        $sth = $dbh->prepare('select `ZONE`,`NAME`,`IP`,`PORT`,`WEBPORT` from `'.$table_name.'`'.
                ' where `GAME`= :game and `TYPE`= :type');
        $sth->bindParam(":game", $game);
        $sth->bindParam(":type", $type);
        $info = array();
        if (@$sth->execute() === false) {
        } else {
            while($res = $sth->fetch(PDO::FETCH_ASSOC)){
                $info[] =  $res['ZONE'].",". $res['NAME'].",".
                    $res['IP'].",". $res['PORT'].",".$res['WEBPORT'];
            }
        }
        return $info;
    }
}
