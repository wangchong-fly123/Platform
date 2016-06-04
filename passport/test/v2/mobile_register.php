#!/usr/bin/env php
<?php

if (PHP_SAPI !== 'cli') {
    exit(1);
}

if ($argc <= 2) {
    echo 'usage: '.basename($argv[0])." <mobile_phone> <message_code>\n";
    exit(1);
}
$mobile_phone = $argv[1];
$message_code = $argv[2];

require '../../lib/Config.php';
Config::init();
require 'TestConfig.php';

var_dump(Util::signedHttpRequest(
    TestConfig::$base_url, TestConfig::$secret_key,
    '/v2/mobile_register.php', array(
        'mobile_phone' => $mobile_phone,
        'password' => sha1('1'),
        'message_code' => $message_code,
    ), 'post')
);

exit(0);
