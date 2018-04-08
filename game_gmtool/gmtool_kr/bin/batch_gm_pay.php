#!/usr/bin/env php
<?php

function parseBatchPayFile($file_name)
{
    $fp = fopen($file_name, 'r');
    if ($fp === false) {
        echo "error: can not open file $file_name\n";
        return false;
    }

    $pay_list = array();

    while (($line = fgets($fp)) !== false) {
        $parts = explode('|', $line);
        if (count($parts) !== 5) {
            echo "error: line($line) is invalid\n";
            return false;
        }

        array_push($pay_list, array(
            'platform_id' => $parts[0],
            'server_id' => $parts[1],
            'player_id' => $parts[2],
            'product_id' => $parts[3],
            'amount' => $parts[4],
        ));
    }

    fclose($fp);

    return $pay_list;
}

function gmPay($dbh, $platform_id, $server_id, $player_id,
    $product_id, $amount, $virtual_send = true)
{
    $server_info = Util::getServerInfo($dbh, $platform_id, $server_id);
    if ($server_info === false) {
        echo "error: get server info($platform_id:$server_id) failed\n";
        return false;
    }

    $output = Util::signedHttpRequest(
        $server_info['addr'], $server_info['secret_key'],
        '/player_brief_info.php', array(
            'player_key_type' => '3',
            'player_key' => $player_id,
        ));
    if (false === $output) {
        echo "error: request player_brief_info.php failed\n";
        return false;
    }
    $ret = json_decode($output, true);
    if ($ret === null || isset($ret['error_code'])) {
        echo "error: can not find player($player_id)\n";
        return false;
    }

    if ($virtual_send) {
        return true;
    }

    $output = Util::signedHttpRequest(
        $server_info['addr'], $server_info['secret_key'],
        '/gm_pay.php', array(
            'player_id' => $player_id,
            'pay_id' => $product_id,
            'amount' => $amount,
        ));
    if (false === $output) {
        echo "error: request gm_pay.php failed\n";
        return false;
    }
    $ret = json_decode($output, true);
    if ($ret === null || isset($ret['error_code'])) {
        echo "error: request gm_pay.php failed\n";
        return false;
    }

    echo "gmpay to $player_id success\n";

    return true;
}

function main($argc, $argv)
{
    $bin_dir = realpath(__DIR__).'/';
    $settings_dir = realpath($bin_dir."../settings").'/';
    $config_ini_file = $settings_dir."config.ini";
    require_once $bin_dir.'sgzj-gmserver/app/lib/Util.php';

    if ($argc <= 1) {
        echo "usage: batch_gm_pay.php <batch_pay_file>\n";
        return false;
    }
    $batch_pay_file = $argv[1];

    // parse batch mail file
    $pay_list = parseBatchPayFile($batch_pay_file);
    if ($pay_list === false) {
        echo "error: parse batch mail file failed\n";
        return false;
    }

    // get db handler
    $dbh = Util::getDBHandler($config_ini_file);
    if ($dbh === false) {
        echo "error: load config file $config_ini_file failed\n";
        return false;
    }

    foreach ($pay_list as $mail) {
        if (gmPay($dbh,
                $mail['platform_id'],
                $mail['server_id'],
                $mail['player_id'],
                $mail['product_id'],
                $mail['amount'],
                true) === false) {
            return false;
        }
    }

    foreach ($pay_list as $mail) {
        if (gmPay($dbh,
                $mail['platform_id'],
                $mail['server_id'],
                $mail['player_id'],
                $mail['product_id'],
                $mail['amount'],
                false) === false) {
            return false;
        }
    }

    return true;
}

if (PHP_SAPI !== 'cli') {
   exit(1);
}
if (main($argc, $argv) === false) {
    exit(1);
}
exit(0);
