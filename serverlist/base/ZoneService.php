<?php

require_once Config::getSettingsDir().'SlaveServerConfig.php';

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

    public function getZoneInfo($game, $type, $platform)
    {   
        $dbh = $this->getDBHandler();
        $info = array();
        $table_name = Common::getZoneInfoTableName($platform);
        if ($table_name == "") {
            return $info;
        }

        $string_time = date("Y-m-d H:i:s", time());
        $string_time_empty = '';
        $sth = $dbh->prepare(
                'select `ZONE`,`NAME`,`IP`,'.
                '`PORT`,`WEBPORT`,`STATUS`,'.
                '`TIPS`,`DISABLE_GIFTCODE`,'.
                '`START_TIME`,`END_TIME` from `'.$table_name.'`'.
                ' where `GAME`= :game and `TYPE`= :type'.
                ' and (`START_TIME`<:string_time or `START_TIME`= :string_time_empty)');
        $sth->bindParam(":game", $game);
        $sth->bindParam(":type", $type);
        $sth->bindParam(":string_time", $string_time);
        $sth->bindParam(":string_time_empty", $string_time_empty);
        if (@$sth->execute() === false) {
        } else {
            while($res = $sth->fetch(PDO::FETCH_ASSOC)) {
                $show_new_tips = $res['TIPS'];
                if ($show_new_tips == 0) {
                    if ($res['START_TIME'] != '' && $res['END_TIME'] != '') {
                        if (time() >= strtotime($res['START_TIME']) &&
                            time() <= strtotime($res['END_TIME'])) {
                            $show_new_tips = 1;
                        }
                    }
                }

                $info[] =  $res['ZONE'].",". $res['NAME'].",".
                    $res['IP'].",". $res['PORT'].",".
                    $res['WEBPORT'].",".$res['STATUS'].",".
                    $show_new_tips.",".$res['DISABLE_GIFTCODE'].",".
                    $res['START_TIME'].",".$res['END_TIME'];
            }
        }
        return $info;
    }

    public function getZoneWebInfo($zone_id, $platform)
    {
        $info = "";
        $dbh = $this->getDBHandler();
        $table_name = Common::getZoneInfoTableName($platform);
        if ($table_name == "") {
            return $info;
        }
        $sth = $dbh->prepare('select `IP`,`WEBPORT` from `'.$table_name.'`'.
                ' where `ZONE`= :zone');
        $sth->bindParam(":zone", $zone_id);
        if (@$sth->execute() === false) {
        } else {
            while($res = $sth->fetch(PDO::FETCH_ASSOC)) {
                $info = 'http://'.$res['IP'].':'.$res['WEBPORT'].'/';
                break;
            }
        }
        return $info;
    }

    public function updateZoneStatusInfo($zone_id, $platform, $status)
    {
        $info = "";
        $dbh = $this->getDBHandler();
        $table_name = Common::getZoneInfoTableNameById($platform);
        if ($table_name == "") {
            return $info;
        }
        $sth = $dbh->prepare('update `'.$table_name.'` set `STATUS`=:status'.
                ' where `ZONE`= :zone');
        $sth->bindParam(":status", $status);
        $sth->bindParam(":zone", $zone_id);
        if (@$sth->execute() === false) {
            $this->error("zone", -1);
        }

        $this->updateSameZoneStatusInfo($zone_id, $platform, $status);

        return $info;
    }

    public function updateSameZoneStatusInfo($zone_id, $platform, $status)
    {
        $info = "";
        $dbh = $this->getDBHandler();
        $table_name = Common::getZoneInfoTableNameById($platform);
        if ($table_name == "") {
            return $info;
        }

        $dest_ip = '';
        $dest_port = '';
        $sth = $dbh->prepare('select `IP`,`PORT` from `'.$table_name.'`'.
                ' where `ZONE`= :zone');
        $sth->bindParam(":zone", $zone_id);
        if (@$sth->execute() === false) {
            $this->error("zone", -1);
        } else {
            while($res = $sth->fetch(PDO::FETCH_ASSOC)) {
                $dest_ip = $res['IP'];
                $dest_port = $res['PORT'];
                break;
            }
        }

        $sth = $dbh->prepare('update `'.$table_name.'` set `STATUS`=:status'.
                ' where `IP`= :dest_ip and `PORT`= :dest_port');
        $sth->bindParam(":status", $status);
        $sth->bindParam(":dest_ip", $dest_ip);
        $sth->bindParam(":dest_port", $dest_port);
        if (@$sth->execute() === false) {
            $this->error("zone", -1);
        }

        return $info;
    }

    public function checkRequestValid($server_params, $request_params)
    {
        return Common::checkRequestValid(
            SlaveServerConfig::$slave_server_key,
            $server_params, $request_params);
    }

    public function getBriefZoneInfo($game, $type, $platform)
    {   
        $dbh = $this->getDBHandler();
        $info = array();
        $table_name = Common::getZoneInfoTableName($platform);
        if ($table_name == "") {
            return $info;
        }

        $string_time = date("Y-m-d H:i:s", time());
        $string_time_empty = '';
        $sth = $dbh->prepare(
                'select `ZONE`,`NAME`,`IP`,'.
                '`PORT`,`WEBPORT`,`STATUS`,'.
                '`TIPS`,`DISABLE_GIFTCODE`,'.
                '`START_TIME`,`END_TIME` from `'.$table_name.'`'.
                ' where `GAME`= :game and `TYPE`= :type'.
                ' and (`START_TIME`<:string_time or `START_TIME`= :string_time_empty)');
        $sth->bindParam(":game", $game);
        $sth->bindParam(":type", $type);
        $sth->bindParam(":string_time", $string_time);
        $sth->bindParam(":string_time_empty", $string_time_empty);
        if (@$sth->execute() === false) {
        } else {
            while($res = $sth->fetch(PDO::FETCH_ASSOC)) {
                $show_new_tips = $res['TIPS'];
                if ($show_new_tips == 0) {
                    if ($res['START_TIME'] != '' && $res['END_TIME'] != '') {
                        if (time() >= strtotime($res['START_TIME']) &&
                            time() <= strtotime($res['END_TIME'])) {
                            $show_new_tips = 1;
                        }
                    }
                }

                $info_desc = array(
                    'zone' => $res['ZONE'],
                    'name' => $res['NAME'],
                    'status' => $res['STATUS'],
                    );
                array_push($info, $info_desc);
            }
        }
        $ret_array = array(
            "zoneinfo" => $info,
            );
        return json_encode($ret_array);
    }
}
