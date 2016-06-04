#!/usr/bin/env php
<?php

if (PHP_SAPI !== 'cli') {
    exit(1);
}

if ($argc <= 1) {
    echo 'usage: '.basename($argv[0])." <new_account>\n";
    exit(1);
}
$new_account = $argv[1];

require '../../lib/Config.php';
Config::init();
require 'TestConfig.php';

$ret = Util::signedHttpRequest(
    TestConfig::$base_url, TestConfig::$secret_key,
    '/v2/guest_register.php', array(
        'password' => sha1('1'),
    ), 'post');

var_dump($ret);

$ret = json_decode($ret, true);
if ($ret === null) {
    exit(0);
}

var_dump(Util::signedHttpRequest(
    TestConfig::$base_url, TestConfig::$secret_key,
    '/v2/convert_guest.php', array(
        'account' => $ret['result']['account'],
        'password' => sha1('1'),
        'new_account' => $new_account,
        'new_password' => sha1('1'),
    ), 'post'));

exit(0);
