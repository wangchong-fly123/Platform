<?php

require_once Config::getSettingsDir().'SlaveServerConfig.php';

final class GiftCodeService
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

    public function checkRequestValid($server_params, $request_params)
    {
        return Common::checkRequestValid(
            SlaveServerConfig::$slave_server_key,
            $server_params, $request_params);
    }

    public function isPublicCode($giftcode, $channel)
    {
        $dbh = $this->getDBHandler();

        $sth = $dbh->prepare('select `gift_id`,`channel`'.
            ' from `tbl_giftcode_public`'.
            ' where `code`= :code');
        $sth->bindValue(':code', $giftcode, PDO::PARAM_STR);
        $sth->execute();
        $res = $sth->fetch(PDO::FETCH_ASSOC);
        if (count($res)) {
            if ($res['channel'] === "000000") {
                return $res['gift_id'];
            } else {
                if ($res['channel'] === $channel) {
                    return $res['gift_id'];
                }
            }
        }
        return 0;
    }

    public function checkUse($giftcode, $channel)
    { 
        $dbh = $this->getDBHandler();

        $gift_id = $this->isPublicCode($giftcode, $channel);
        if ($gift_id > 0) {
            return $gift_id;
        } else {
            $sth = $dbh->prepare('select `gift_id`,`channel` from'.
                ' `tbl_giftcode_unique`'.
                ' where `code`= :code and `used`=0');
            $sth->bindValue(':code', $giftcode, PDO::PARAM_STR);
            $sth->execute();
            $res = $sth->fetch(PDO::FETCH_ASSOC);
            if (count($res)) {
                if ($res['channel'] === "000000") {
                    return $res['gift_id'];
                } else {
                    if ($res['channel'] === $channel) {
                        return $res['gift_id'];
                    }
                }
            }
        }

        return 0;
    }

    public function updateCodeStatus($table_name, $giftcode)
    {
        $dbh = $this->getDBHandler();
        $sth = $dbh->prepare('update `'.$table_name.'` set `used`=1'.
                ' where `code`= :code and `used`=0');
        $sth->bindValue(':code', $giftcode, PDO::PARAM_STR);
        if ($sth->execute() === false) {
            return -1;
        } else {
            if ($sth->rowCount() == 1) {
                return 0;
            }
        }
        return -1;
    }

    public function useCode($giftcode, $channel)
    {
        $dbh = $this->getDBHandler();

        $gift_id = $this->checkUse($giftcode, $channel);
        if ($gift_id === 0) {
            return -1;
        }
        if ($this->isPublicCode($giftcode, $channel) > 0) {
            return 0;
        } else {
            return $this->updateCodeStatus('tbl_giftcode_unique', $giftcode);
        }
        return -1;
    }
}
