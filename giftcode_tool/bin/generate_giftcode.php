#!/usr/bin/php

<?php
require('../base/Config.php');
Config::init();

if ($argc != 6) {
    die("usage: ./generate_giftcode.php  [length] [count] [channel] [gift_id] [code_type(1;public code,0;unique code)]\n");
}

$length = $argv[1];
$count = $argv[2];
$channel = $argv[3];
$gift_id = $argv[4];
$code_type = $argv[5];

if (!is_numeric($length)) {
    die("length must be numeric!!!");
} elseif (!is_numeric($count)) {
    die("count must be numeric!!!");
} elseif (!is_numeric($gift_id)) {
    die("gift_id must be numeric!!!");
} elseif (!is_numeric($channel) || strlen($channel) != 6) {
    die("channel length must be 6");
} elseif ($code_type != 0 && $code_type != 1) {
    die("code_type must be 1 or 0");
}

$generate_count = $count;
$service = new CodeService();
$service->init();

$batch_id = $service->calculateBatchId();

$code_array = array();
while ($generate_count > 0) {
    $code = $service->generateOneCode($length, $channel, $gift_id, $batch_id, $code_type);
    if ($code === -1) {
        die("fatal error !!!");
    }

    $code_array[] = $code;
    if (count($code_array) === 1000) {
        $service->generateCodeSql($code_array, $channel, $gift_id, $batch_id, $code_type);
        $code_array = array();
    }
    $generate_count--;
}

if (count($code_array) > 0) {
    $service->generateCodeSql($code_array, $channel, $gift_id, $batch_id, $code_type);
}
echo "giftcode total count is: $count\n";
echo "giftcode txt file name is: ".
    'giftcode_'.$channel.'_'.$gift_id.'_'.$batch_id.'.txt'."\n";
echo "giftcode sql file name is: ".
    'giftcode_'.$channel.'_'.$gift_id.'_'.$batch_id.'.sql'."\n";
