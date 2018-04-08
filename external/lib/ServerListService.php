<?php

require_once Config::getSettingsDir().'ServerPlatformConfig.php';

final class ServerListService
{
    private $server_app_ = null;

    public function __construct($server_app)
    {
        $this->server_app_ = $server_app;
    }

    public function getServerList($platform)
    {
        $info = array();
        $server_config = $this->server_app_->getServerConfig();

        $output = Util::httpRequest( 
            $server_config->server_list_center_url, array(
                'game' => 1,
                'type' => 0,
                'platform' => $platform,
            ), 'get');
        $ret = json_decode($output, true);
        if ($ret !== null) {
            //error_log($output);
            return $output;
        }

        return $info;
    }

    public function getServerListById($platform_id)
    {
        $platform = '';
        if (isset(ServerPlatformConfig::$id_2_platform[$platform_id])) {
            $platform = ServerPlatformConfig::$id_2_platform[$platform_id];
        } else {
            return array();
        }
        return self::getServerList($platform);
    }

    public function getAccountServerList($account)
    {
        $info = array();
        $server_config = $this->server_app_->getServerConfig();

        $output = Util::httpRequest( 
            $server_config->account_server_center_url, array(
                'account' => $account,
            ), 'get');
        $ret = json_decode($output, true);
        if ($ret !== null) {
            //error_log($output);
            return $output;
        }

        return $info;
    }

    public function getChannelList()
    {
        return ServerPlatformConfig::$channel_name_list;
    }

    public function getPlatformList()
    {
        return ServerPlatformConfig::$platform_name_list;
    }

}
