#!/usr/bin/env php
<?php

function parseBatchMailFile($file_name)
{
    $fp = fopen($file_name, 'r');
    if ($fp === false) {
        echo "error: can not open file $file_name\n";
        return false;
    }

    $mail_list = array();

    while (($line = fgets($fp)) !== false) {
        $parts = explode('|', $line);
        if (count($parts) !== 7) {
            echo "error: line($line) is invalid\n";
            return false;
        }

        array_push($mail_list, array(
            'platform_id' => $parts[0],
            'server_id' => $parts[1],
            'player_id' => $parts[2],
            'mail_title' => $parts[3],
            'mail_content' => $parts[4],
            'mail_awards' => $parts[5],
            'expired_second' => $parts[6],
        ));
    }

    fclose($fp);

    return $mail_list;
}

function getEncodedMailReward($mail_awards)
{
    $ret = array();
    $awards = explode(',', $mail_awards);
    foreach ($awards as $award) {
        $parts = explode('&', $award);
        if (count($parts) !== 2) {
            return false;
        }
        array_push($ret, array(
            'item_template_id' => $parts[0],
            'item_count' => $parts[1],
        ));
    }

    return json_encode($ret);
}

function sendMail($dbh, $platform_id, $server_id, $player_id,
    $mail_title, $mail_content, $mail_awards, $expired_second,
    $virtual_send = true)
{
    $server_info = Util::getServerInfo($dbh, $platform_id, $server_id);
    if ($server_info === false) {
        echo "error: get server info($platform_id:$server_id) failed\n";
        return false;
    }

    $encoded_mail_awards = getEncodedMailReward($mail_awards);
    if ($encoded_mail_awards === false) {
        echo "error: mail reward($mail_awards) is invalid\n";
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
        '/send_mail.php', array(
            'player_id' => $player_id,
            'mail_title' => $mail_title,
            'mail_content' => $mail_content,
            'mail_awards' => $encoded_mail_awards,
            'expired_second' => $expired_second,
        ));
    if (false === $output) {
        echo "error: request send_mail.php failed\n";
        return false;
    }
    $ret = json_decode($output, true);
    if ($ret === null || isset($ret['error_code'])) {
        echo "error: request send_mail.php failed\n";
        return false;
    }

    echo "send mail to $player_id success\n";

    return true;
}

function main($argc, $argv)
{
    $bin_dir = realpath(__DIR__).'/';
    $settings_dir = realpath($bin_dir."../settings").'/';
    $config_ini_file = $settings_dir."config.ini";
    require_once $bin_dir.'sgzj-gmserver/app/lib/Util.php';

    if ($argc <= 1) {
        echo "usage: batch_send_mail.php <batch_mail_file>\n";
        return false;
    }
    $batch_mail_file = $argv[1];

    // parse batch mail file
    $mail_list = parseBatchMailFile($batch_mail_file);
    if ($mail_list === false) {
        echo "error: parse batch mail file failed\n";
        return false;
    }

    // get db handler
    $dbh = Util::getDBHandler($config_ini_file);
    if ($dbh === false) {
        echo "error: load config file $config_ini_file failed\n";
        return false;
    }

    foreach ($mail_list as $mail) {
        if (sendMail($dbh,
                $mail['platform_id'],
                $mail['server_id'],
                $mail['player_id'],
                $mail['mail_title'],
                $mail['mail_content'],
                $mail['mail_awards'],
                $mail['expired_second'],
                true) === false) {
            return false;
        }
    }

    foreach ($mail_list as $mail) {
        if (sendMail($dbh,
                $mail['platform_id'],
                $mail['server_id'],
                $mail['player_id'],
                $mail['mail_title'],
                $mail['mail_content'],
                $mail['mail_awards'],
                $mail['expired_second'],
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
