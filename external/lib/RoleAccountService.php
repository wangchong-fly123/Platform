<?php

require_once Config::getSettingsDir().'ServerPlatformConfig.php';

final class RoleAccountService
{
    private $server_app_ = null;

    public function __construct($server_app)
    {
        $this->server_app_ = $server_app;
    }

    public function checkUidInWhite($uid)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'select `id` from tbl_account_white'.
            ' where `uid` = :uid');
        $sth->bindValue(':uid', $uid, PDO::PARAM_STR);
        if (@$sth->execute() === false) {
            return false;
        }

        $ret = $sth->fetch(PDO::FETCH_ASSOC);
        if ($ret === false) {
            return false;
        }

        return true;
    }

    public function checkHasBindPhone($phone)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'select `phone` from tbl_account_phone'.
            ' where `phone` = :phone');
        $sth->bindValue(':phone', $phone, PDO::PARAM_STR);
        if (@$sth->execute() === false) {
            return false;
        }

        $ret = $sth->fetch(PDO::FETCH_ASSOC);
        if ($ret === false) {
            return false;
        }

        return true;
    }

    public function getDestChannel($channel)
    {
        if (!isset(ServerPlatformConfig::$channel_change_list[$channel])) {
            return false;
        }

        return ServerPlatformConfig::$channel_change_list[$channel];
    }

    public function getDownloadUrlByChannel($channel)
    {
        $dest_channel = $this->getDestChannel($channel);
        if ($dest_channel == false) {
            return false;
        }

        if (!isset(ServerPlatformConfig::$channel_download_list[$dest_channel])) {
            return false;
        }
        return ServerPlatformConfig::$channel_download_list[$dest_channel];
    }

    public function getChannelPlan($channel)
    {
        if (!isset(ServerPlatformConfig::$channel_plan_list[$channel])) {
            return false;
        }

        return ServerPlatformConfig::$channel_plan_list[$channel];
    }

    public function getChannelPayPlugin($channel)
    {
        if (!isset(ServerPlatformConfig::$channel_pay_plugin[$channel])) {
            return false;
        }

        return ServerPlatformConfig::$channel_pay_plugin[$channel];
    }

    public function getOfficialPlatform()
    {
        return ServerPlatformConfig::$official_platform_str;
    }
    
    public function getOfficialChannel()
    {
        return ServerPlatformConfig::$official_channel_str;
    }

    public function changeAccount($uid, $platform,
        $server_id, $src_channel)
    {
        if (0 == ServerPlatformConfig::$channel_change_switch) {
            return false;
        }
        $dest_channel = $this->getDestChannel($src_channel);
        if ($dest_channel == false) {
            return false;
        }

        if (false == $this->checkUidInWhite($uid) &&
            0 == ServerPlatformConfig::$force_channel_change) {
            return false;
        }

        $info = array();

        $server_config = $this->server_app_->getServerConfig();

        $addr = Util::getSlaveUrl(
            $server_config->server_web_addr_url, $server_id, $platform);
        if ($addr == false) {
            return false;
        }

        $output = Util::slaveServerRequest(
            $addr, ServerPlatformConfig::$slave_key,
            '/change_role_account.php', array(
                'old_uid' => $uid,
                'uid' => $uid,
                'src_channel' => $src_channel,
                'dest_channel' => $dest_channel,
                'server_id' => $server_id));
        if ($output === false) {
            return false;
        }

        if (isset($output['success'])) {
            if ($output['success'] == true) {
                return true;
            }
        }

        return false;
    }

    public function checkHasChanged($src_channel, $uid, $server_id)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'select `id` from tbl_account_change'.
            ' where `uid` = :uid'.
            ' and `channel` = :channel'.
            ' and `server_id` = :server_id');
        $sth->bindValue(':uid', $uid, PDO::PARAM_STR);
        $sth->bindValue(':channel', $src_channel, PDO::PARAM_STR);
        $sth->bindValue(':server_id', $server_id, PDO::PARAM_STR);
        if (@$sth->execute() === false) {
            return false;
        }

        $ret = $sth->fetch(PDO::FETCH_ASSOC);
        if ($ret === false) {
            return false;
        }

        return true;
    }

    public function checkUidHasChanged($src_channel, $uid)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'select `id` from tbl_account_change'.
            ' where `uid` = :uid'.
            ' and `channel` = :channel');
        $sth->bindValue(':uid', $uid, PDO::PARAM_STR);
        $sth->bindValue(':channel', $src_channel, PDO::PARAM_STR);
        if (@$sth->execute() === false) {
            return false;
        }

        $ret = $sth->fetch(PDO::FETCH_ASSOC);
        if ($ret === false) {
            return false;
        }

        return true;
    }

    public function checkImeiHasChanged($imei, $src_channel)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'select `id` from tbl_device_change'.
            ' where `imei` = :imei'.
            ' and `channel` = :channel');
        $sth->bindValue(':imei', $imei, PDO::PARAM_STR);
        $sth->bindValue(':channel', $src_channel, PDO::PARAM_STR);
        if (@$sth->execute() === false) {
            return false;
        }

        $ret = $sth->fetch(PDO::FETCH_ASSOC);
        if ($ret === false) {
            return false;
        }

        return true;
    }

    public function recordChange($src_channel, $uid, $server_id)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'insert into `tbl_account_change`('.
            '`channel`, `uid`, `server_id` '.
            ') values ('.
            ':channel, :uid, :server_id) '
        );
        $sth->bindValue(':channel', $src_channel, PDO::PARAM_STR);
        $sth->bindValue(':uid', $uid, PDO::PARAM_STR);
        $sth->bindValue(':server_id', $server_id, PDO::PARAM_STR);
        if (@$sth->execute() === false) {
            return false;
        }

        return true;
    }

    public function recordImeiChange($imei, $src_channel)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'insert into `tbl_device_change`('.
            '`imei`, `channel` '.
            ') values ('.
            ':imei, :channel) '
        );
        $sth->bindValue(':imei', $imei, PDO::PARAM_STR);
        $sth->bindValue(':channel', $src_channel, PDO::PARAM_STR);
        if (@$sth->execute() === false) {
            return false;
        }

        return true;
    }

    public function recordGamePhone($platform, $channel, $uid, $phone, $server_id)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'insert into `tbl_account_phone`('.
            '`platform`, `channel`, `uid`, `phone`,`server_id` '.
            ') values ('.
            ':platform, :channel, :uid, :phone, :server_id) '
        );
        $sth->bindValue(':platform', $platform, PDO::PARAM_STR);
        $sth->bindValue(':channel', $channel, PDO::PARAM_STR);
        $sth->bindValue(':uid', $uid, PDO::PARAM_STR);
        $sth->bindValue(':phone', $phone, PDO::PARAM_STR);
        $sth->bindValue(':server_id', $server_id, PDO::PARAM_STR);
        if (@$sth->execute() === false) {
            return false;
        }

        return true;
    }

    public function checkIsGmAccount($account)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'select `id` from tbl_gm_account'.
            ' where `account` = :account');
        $sth->bindValue(':account', $account, PDO::PARAM_STR);
        if (@$sth->execute() === false) {
            return false;
        }

        $ret = $sth->fetch(PDO::FETCH_ASSOC);
        if ($ret === false) {
            return false;
        }

        return true;
    }

    public function checkGmIp($remote_ip)
    {
        if (!in_array($remote_ip, ServerPlatformConfig::$gm_allow_ip_list)) {
            return false;
        }
        return true;
    }

    public function checkInGameChangeSwitch($channel)
    {
        if (ServerPlatformConfig::$in_game_bind_switch == 0) {
            return false;
        }

        $dest_channel = $this->getDestChannel($channel);
        if ($dest_channel == false) {
            return false;
        }

        return true;
    }

    public function changeAccountInGame($old_uid, $uid, $platform,
        $server_id, $src_channel)
    {
        $dest_channel = $this->getDestChannel($src_channel);
        if ($dest_channel == false) {
            return false;
        }

        $info = array();

        $server_config = $this->server_app_->getServerConfig();

        $addr = Util::getSlaveUrl(
            $server_config->server_web_addr_url, $server_id, $platform);
        if ($addr == false) {
            return false;
        }

        $output = Util::slaveServerRequest(
            $addr, ServerPlatformConfig::$slave_key,
            '/change_role_account.php', array(
                'old_uid' => $old_uid,
                'uid' => $uid,
                'src_channel' => $src_channel,
                'dest_channel' => $dest_channel,
                'server_id' => $server_id));
        if ($output === false) {
            return false;
        }

        if (isset($output['success'])) {
            if ($output['success'] == true) {
                return true;
            }
        }

        return false;
    }

    public function getAccountByImei($imei, $platform)
    {
        if (strpos($platform, '@') !== false) {
            $platform_array = explode('@', $platform);
            $platform = $platform_array[0];
        } 

        $output = Util::httpRequest(
            ServerPlatformConfig::$device_service_url, array(
                'game' => 1,
                'imei' => $imei,
            ), 'get');

        $ret = json_decode($output, true);
        if ($ret == null) {
            return false;
        }
         
        if (!isset($ret['result']) ||
            !isset($ret['result']['error_code'])) {
            return false;
        }

        if ($ret['result']['error_code'] != 0) {
            return false;
        }
        
        $account_array = $ret['result']['account'];
        $uid_list = array();
        for ($i = 0; $i < count($account_array); ++$i) {
            $origin_account = $account_array[$i];
            $origin_account_array = explode('_', $origin_account);
            if ($platform != $origin_account_array[0].'_'.$origin_account_array[1]) {
                continue;
            }
            $uid_list[] = str_replace($platform.'_', '', $origin_account);

        }
        return $uid_list;
    }

    public function checkIpIsValid($remote_ip)
    {
        if (empty(ServerPlatformConfig::$allow_ip_list)) {
            return true;
        }
        if (!in_array($remote_ip, ServerPlatformConfig::$allow_ip_list)) {
            return false;
        }
        return true;
    }

    public function sendMessageCode($phone)
    {
        $dbh = $this->server_app_->getRedisHandler();
        if ($dbh->get('fail_times'.$phone) > 5) {
            return false;
        }
        if ($dbh->exists('message_code'.$phone)) {
            return false;
        }

        $message_code = sprintf('%06ld', mt_rand(0, 999999));

        $output = Util::httpRequest(
            ServerPlatformConfig::$sms_service_url, array(
                'message_type' => 'common_code',
                'message_code' => $message_code,
                'phone_num' => $phone,
            ), 'get');

        $dbh->setex('message_code'.$phone, 60, $message_code);
        return $message_code;
    }

    public function getMessageCode($phone)
    {
        $dbh = $this->server_app_->getRedisHandler();
        return $dbh->get('message_code'.$phone);
    }

    public function checkMessageCode($phone, $code)
    {
        $dbh = $this->server_app_->getRedisHandler();
        if (false == $dbh->exists('message_code'.$phone)) {
            return false;
        }

        if ($dbh->get('message_code'.$phone) != $code) {
            if ($dbh->exists('fail_times'.$phone)) {
                $dbh->incr('fail_times'.$phone);

            } else {
                $dbh->setex('fail_times'.$phone, 300, 1);
            }

            return false;
        }
        return true;
    }

    public function recordPhoneChange($phone)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'insert into `tbl_phone_change`('.
            '`phone` '.
            ') values ('.
            ':phone) '
        );
        $sth->bindValue(':phone', $phone, PDO::PARAM_STR);
        if (@$sth->execute() === false) {
            return false;
        }

        return true;
    }

    public function checkPhoneHasChanged($phone)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'select `change` from tbl_phone_change'.
            ' where `phone` = :phone');
        $sth->bindValue(':phone', $phone, PDO::PARAM_STR);
        if (@$sth->execute() === false) {
            return false;
        }

        $ret = $sth->fetch(PDO::FETCH_ASSOC);
        if ($ret === false) {
            return false;
        }

        return true;
    }

    public function checkHasEnjoymiPassport($phone)
    {
        $output = Util::httpRequest(
            ServerPlatformConfig::$passport_service_url, array(
                'phone' => $phone,
            ), 'get');

        $ret = json_decode($output, true);
        if ($ret == null) {
            return false;
        }
         
        if (!isset($ret['result']) ||
            !isset($ret['result']['error_code'])) {
            return false;
        }

        if ($ret['result']['error_code'] != 0) {
            return false;
        }
        if ($ret['result']['uid'] != '') {
            return $ret['result'];
        }

        return false;
    }

    public function getBindPhoneInfo($phone)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'select `platform`,`channel`,`uid`,`server_id` from tbl_account_phone'.
            ' where `phone` = :phone');
        $sth->bindValue(':phone', $phone, PDO::PARAM_STR);
        if (@$sth->execute() === false) {
            return false;
        }

        $ret = $sth->fetch(PDO::FETCH_ASSOC);
        if ($ret === false) {
            return false;
        }

        return $ret;
    }
}
