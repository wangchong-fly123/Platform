#!/usr/bin/env php
<?php

function multiSlaveServerRequest($request_list)
{
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

function getSpreadList()
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
            '`url`, '.
            '`desc` '.
            'from `tbl_spread` ');
    if ($sth->execute() === false) {
        return false;
    }
    return $sth->fetchAll(PDO::FETCH_ASSOC);
}

function notifySpreadListToSlaveServer()
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
            '`id` '.
            'from `tbl_platform` ');
    if ($sth->execute() === false) {
        return false;
    }
    $platform_list = $sth->fetchAll(PDO::FETCH_ASSOC);
    
    $spread_list = getSpreadList();
    
    foreach ($platform_list as $platform) {
        $server_infos = Util::getPlatformServerInfo($dbh, $platform['id']);
        
        if ($server_infos === false) {
            echo "error: get server info($platform) failed\n";
            return false;
        }

        $request_list = array();
        foreach ($server_infos as $server_info) {
            array_push($request_list, array(
               'addr' => $server_info['addr'],
               'secret_key' => $server_info['secret_key'],
               'uri' => '/update_spread.php',
               'params' => array(
                   'url_list' => serialize($spread_list),
               ),
          ));
        }
        var_dump($request_list);
        $ret_list = multiSlaveServerRequest($request_list);
    }
}

function main($argc, $argv)
{
    $bin_dir = realpath(__DIR__).'/';
    require_once $bin_dir.'sgzj-gmserver/app/lib/Util.php';
    notifySpreadListToSlaveServer(); 
    return true;
}

if (PHP_SAPI !== 'cli') {
   exit(1);
}
if (main($argc, $argv) === false) {
   exit(1);
}
exit(0);
