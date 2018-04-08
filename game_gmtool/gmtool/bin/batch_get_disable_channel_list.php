#!/usr/bin/env php
<?php

function multiSlaveServerRequest($request_list)
{
    var_dump($request_list);
    $output_list = Util::multiSignedHttpRequest($request_list);
    $ret_list = array();

    foreach ($output_list as $output) {
       if (false === $output) {
            array_push($ret_list, false);
            continue;
       }
       $ret = json_decode($output, true);
       if ($ret === null) {
            array_push($ret_list, false);
            continue;
        }
        array_push($ret_list, $ret);
    }
    return $ret_list;
 }

function notifyDisabledChannelToSlaveServer()
 {
    // get db handler
    $bin_dir = realpath(__DIR__).'/';
    $settings_dir = realpath($bin_dir."../settings").'/';
    $config_ini_file = $settings_dir."config.ini";
    $dbh = Util::getDBHandler($config_ini_file);
    if ($dbh === false) {
        echo "error: load config file $config_ini_file failed\n";
        return false;
    }
    $sth = $dbh->prepare(
            'select '.
            '`platform_id`, '.
            '`id` '.
            'from `tbl_channel` '.
            'where `state` = :state ');
    $sth->bindValue(':state', 0, PDO::PARAM_INT);
    if ($sth->execute() === false) {
        return false;
    }
    $disable_channel_list = $sth->fetchAll(PDO::FETCH_ASSOC);
    var_dump($disable_channel_list);
    foreach ($disable_channel_list as $disable_channel) {
        if (!isset($platform_disable_channel_list[$disable_channel['platform_id']])) {
           $platform_disable_channel_list[$disable_channel['platform_id']] = array();
        }
    }
    foreach ($disable_channel_list as $disable_channel) {
       array_push($platform_disable_channel_list[$disable_channel['platform_id']], $disable_channel['id']);
    }
	
    $request_list = array();
    foreach ($platform_disable_channel_list as $platform =>
         $disable_channel) { 

         $server_infos= Util::getPlatformServerInfo($dbh, $platform);
         if ($server_infos === false) {
            echo "error: get server info($platform) failed\n";
            return false;
        }
        foreach ($server_infos as $server_info) {
            array_push($request_list, array(
               'addr' => $server_info['addr'],
               'secret_key' => $server_info['secret_key'],
               'uri' => '/disable_channel_list.php',
               'params' => array('disable_channel_list' => implode(',', $disable_channel))
          ));
         }
      $ret_list = multiSlaveServerRequest($request_list);
   }
}
function main($argc, $argv)
{
    $bin_dir = realpath(__DIR__).'/';
    require_once $bin_dir.'sgzj-gmserver/app/lib/Util.php';
    notifyDisabledChannelToSlaveServer(); 
    return true;
}

if (PHP_SAPI !== 'cli') {
   exit(1);
}
if (main($argc, $argv) === false) {
    exit(1);
}
exit(0);
