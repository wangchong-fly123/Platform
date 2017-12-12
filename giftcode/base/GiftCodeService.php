<?php

require_once Config::getSettingsDir().'SlaveServerConfig.php';


final class Error
{
    const UNKNOWN = -1;
    const CODE_NOT_EXIST = -2; 
    const CODE_EXPIRED = -3;
    const ALREADY_USED = -4;
}

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

    public function checkTimeValid($start_time, $end_time)
    {
        if ($start_time == '' || $end_time == '') {
            return true;
        }

        $now = time();
        if ($now < strtotime($start_time) || $now > strtotime($end_time)) {
            return false;
        }

        return true;
    }

    public function isPublicCode($giftcode, $channel)
    {
        $dbh = $this->getDBHandler();

        $sth = $dbh->prepare('select `gift_id`,`channel`,`start_time`,`end_time` '.
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
            $sth = $dbh->prepare('select `gift_id`,`channel`,'.
                '`start_time`,`end_time`,`used` from'.
                ' `tbl_giftcode_public`'.
                ' where `code`= :code');
            $sth->bindValue(':code', $code, PDO::PARAM_STR);
            $sth->execute();
            $res = $sth->fetch(PDO::FETCH_ASSOC);
            if (count($res)) {

                if (false == $this->checkTimeValid(
                    $res['start_time'], $res['end_time'])) {
                    return Error::CODE_EXPIRED;
                }

                if ($res['channel'] === "000000") {
                    return $res['gift_id'];
                } else {
                    if ($res['channel'] === $channel) {
                        return $res['gift_id'];
                    }
                }
            }


        } else {
            $sth = $dbh->prepare('select `gift_id`,`channel`,'.
                '`start_time`,`end_time`,`used` from'.
                ' `tbl_giftcode_unique`'.
                ' where `code`= :code');
            $sth->bindValue(':code', $giftcode, PDO::PARAM_STR);
            $sth->execute();
            $res = $sth->fetch(PDO::FETCH_ASSOC);
            if (count($res)) {

                if (false == $this->checkTimeValid(
                    $res['start_time'], $res['end_time'])) {
                    return Error::CODE_EXPIRED;
                }
                if ($res['used'] == 1) {
                    return Error::ALREADY_USED;
                }

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

    public function updateCodeStatus($table_name, $giftcode, $player_id)
    {
        $dbh = $this->getDBHandler();
        $sth = $dbh->prepare('update `'.$table_name.'` set `used`=1, `use_time` = :use_time,
                `player_id` = :player_id'.
                ' where `code`= :code and `used`=0');
        $sth->bindValue(':use_time', date("Y-m-d H:i:s"), PDO::PARAM_STR);
        $sth->bindValue(':player_id', $player_id, PDO::PARAM_STR);
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

    public function updateCodeEndtime($table_name, $batch_id, $end_time)
    {
        $dbh = $this->getDBHandler();
        $sth = $dbh->prepare('update `'.$table_name.'` set 
                `end_time` = :end_time'.
                ' where `batch_id`= :batch_id');
        $sth->bindValue(':end_time', $end_time, PDO::PARAM_STR);
        $sth->bindValue(':batch_id', $batch_id, PDO::PARAM_INT);
        if ($sth->execute() === false) {
            return -1;
        } else {
            return 1;
        }
        return -1;
    }
    
    public function updateEndtime($batch_id, $end_time)
    {
        $ret = $this->updateCodeEndtime('tbl_giftcode_public', $batch_id, $end_time);
        $ret2 = $this->updateCodeEndtime('tbl_giftcode_unique', $batch_id, $end_time);
        if ($ret || $ret2) {
            return 1;
        }
        return -1;
    }

    public function useCode($giftcode, $channel, $player_id)
    {
        $dbh = $this->getDBHandler();

        $gift_id = $this->checkUse($giftcode, $channel);
        if ($gift_id <= 0) {
            return -1;
        }
        if ($this->isPublicCode($giftcode, $channel) > 0) {
            return 0;
        } else {
            return $this->updateCodeStatus('tbl_giftcode_unique', $giftcode, $player_id);
        }
        return -1;
    }

    public function getUsedCount($batch)
    {
        $dbh = $this->getDBHandler();
        $sth = $dbh->prepare('select count(*) as count from'.
            ' `tbl_giftcode_unique`'.
            ' where `batch_id`= :batch and `used`=1');
        $sth->bindValue(':batch', $batch, PDO::PARAM_INT);
        $sth->execute();
        $res = $sth->fetch(PDO::FETCH_ASSOC);
        if (count($res)) {
            return $res['count'];
        }
        return 0;
    }

    public function getTotalCount($batch)
    {
        $dbh = $this->getDBHandler();
        $sth = $dbh->prepare('select count(*) as count from'.
            ' `tbl_giftcode_unique`'.
            ' where `batch_id`= :batch');
        $sth->bindValue(':batch', $batch, PDO::PARAM_INT);
        $sth->execute();
        $res = $sth->fetch(PDO::FETCH_ASSOC);
        if (count($res)) {
            return $res['count'];
        }
        return 0;
    }

    public function getCodeInfo($code)
    {
        $dbh = $this->getDBHandler();

        // unique
        $sth = $dbh->prepare('select `code`,`channel`,`used`,`gift_id`,'.
                '`batch_id`,`use_time`,`player_id`,`start_time`,`end_time` from'.
                ' `tbl_giftcode_unique`'.
                ' where `code`= :code');
        $sth->bindValue(':code', $code, PDO::PARAM_STR);
        $sth->execute();
        $res = $sth->fetch(PDO::FETCH_ASSOC);
        if (count($res)) {
            return $res;
        }

        // public
        $sth = $dbh->prepare('select `code`,`channel`,`used`,`gift_id`,'.
                '`batch_id`,`use_time`,`player_id`,`start_time`,`end_time` from'.
                ' `tbl_giftcode_public`'.
                ' where `code`= :code');
        $sth->bindValue(':code', $code, PDO::PARAM_STR);
        $sth->execute();
        $res = $sth->fetch(PDO::FETCH_ASSOC);
        if (count($res)) {
            return $res;
        }

        return 0;
    }
}
