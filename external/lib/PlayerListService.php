<?php

require_once Config::getSettingsDir().'ServerPlatformConfig.php';

final class PlayerListService
{
    private $server_app_ = null;

    public function __construct($server_app)
    {
        $this->server_app_ = $server_app;
    }

    public function getPlayerList($uid, $platform, $server_id)
    {
        $info = array();

        $server_config = $this->server_app_->getServerConfig();

        $addr = Util::getSlaveUrl(
            $server_config->server_web_addr_url, $server_id, $platform);
        if ($addr == false) {
            return false;
        }

        $output = Util::slaveServerRequest(
            $addr, ServerPlatformConfig::$slave_key,
            '/player_role_list.php', array(
                'uid' => $uid,
                'server_id' => $server_id,
                ));
        if ($output === false) {
            Util::error('request slave server failed');
        }

        return $output;
    }

    public function sendPlayerMail($platform_id, $server_id,
        $player_id, $mail_title, $mail_content, $mail_awards)
    {
        $info = array();

        $server_config = $this->server_app_->getServerConfig();

        $platform = '';
        if (isset(ServerPlatformConfig::$id_2_platform[$platform_id])) {
            $platform = ServerPlatformConfig::$id_2_platform[$platform_id];
        } else {
            return false;
        }

        $addr = Util::getSlaveUrl(
            $server_config->server_web_addr_url, $server_id, $platform);
        if ($addr == false) {
            return false;
        }

        $ret = array();
        $awards = explode(',', $mail_awards);
        foreach ($awards as $award) {
            if ($award == '') {
                continue;
            }
            $parts = explode('&', $award);
            if (count($parts) !== 2) {
                return false;
            }
            array_push($ret, array(
                'item_template_id' => $parts[0],
                'item_count' => $parts[1],
            ));
        }

        $output = Util::slaveServerRequest(
            $addr, ServerPlatformConfig::$slave_key,
            '/send_mail.php', array(
                'player_id' => $player_id,
                'mail_title' => $mail_title,
                'mail_content' => $mail_content,
                'mail_awards' => json_encode($ret),
                'expired_second' => 0,
                ));
        if ($output === false) {
            Util::error('request slave server failed');
        }

        return $output;
    }

    public function getPlayerInfo($platform_id, $server_id, $player_id)
    {
        $info = array();

        $server_config = $this->server_app_->getServerConfig();

        $platform = '';
        if (isset(ServerPlatformConfig::$id_2_platform[$platform_id])) {
            $platform = ServerPlatformConfig::$id_2_platform[$platform_id];
        } else {
            return false;
        }

        $addr = Util::getSlaveUrl(
            $server_config->server_web_addr_url, $server_id, $platform);
        if ($addr == false) {
            return false;
        }

        $output = Util::slaveServerRequest(
            $addr, ServerPlatformConfig::$slave_key,
            '/player_brief_info.php', array(
                'player_key_type' => 3,
                'player_key' => $player_id,
                ));
        if ($output === false) {
            Util::error('request slave server failed');
        }

        return $output;
    }

    public function getPlayerBuddyList($platform_id, $server_id, $player_id)
    {
        $info = array();

        $server_config = $this->server_app_->getServerConfig();

        $platform = '';
        if (isset(ServerPlatformConfig::$id_2_platform[$platform_id])) {
            $platform = ServerPlatformConfig::$id_2_platform[$platform_id];
        } else {
            return false;
        }

        $addr = Util::getSlaveUrl(
            $server_config->server_web_addr_url, $server_id, $platform);
        if ($addr == false) {
            return false;
        }

        $output = Util::slaveServerRequest(
            $addr, ServerPlatformConfig::$slave_key,
            '/player_buddy_list.php', array(
                'player_id' => $player_id,
                ));
        if ($output === false) {
            Util::error('request slave server failed');
        }

        return $output;
    }

    public function recordMailPlayer($player_id)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'insert into `tbl_mail_bind`('.
            '`player_id` '.
            ') values ('.
            ':player_id) '
        );
        $sth->bindValue(':player_id', $player_id, PDO::PARAM_STR);
        if (@$sth->execute() === false) {
            return false;
        }

        return true;
    }

    public function checkMailHasSend($player_id)
    {
        $dbh = $this->server_app_->getDBHandler();
        $sth = $dbh->prepare(
            'select `id` from `tbl_mail_bind`'.
            ' where `player_id` = :player_id');
        $sth->bindValue(':player_id', $player_id, PDO::PARAM_STR);
        if (@$sth->execute() === false) {
            return false;
        }

        $ret = $sth->fetch(PDO::FETCH_ASSOC);
        if ($ret === false) {
            return false;
        }

        return true;
    }
}
