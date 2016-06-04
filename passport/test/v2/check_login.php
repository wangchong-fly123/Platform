#!/usr/bin/env php
<?php

if (PHP_SAPI !== 'cli') {
    exit(1);
}

if ($argc <= 1) {
    echo 'usage: '.basename($argv[0])." <account>\n";
    exit(1);
}
$account = $argv[1];

require '../../lib/Config.php';
Config::init();

$app = new ServerApp();
$server_config = $app->getServerConfig();
require 'TestConfig.php';

$ret = Util::signedHttpRequest(
    TestConfig::$base_url, TestConfig::$secret_key,
    '/v2/login.php', array(
        'account' => $account,
        'password' => sha1('1'),
    ), 'post');

var_dump($ret);

$ret = json_decode($ret, true);
if ($ret === null) {
    exit(0);
}

var_dump(Util::signedHttpRequest(
    TestConfig::$base_url, TestConfig::$secret_key,
    '/v2/check_login.php', array(
        'uid' => $ret['result']['uid'],
        'token' => $ret['result']['token'],
    ))
);
