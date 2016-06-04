#!/usr/bin/env php
<?php

if (PHP_SAPI !== 'cli') {
    exit(1);
}

if ($argc <= 1) {
    echo 'usage: '.basename($argv[0]).
         " <account> <password> <new_password>\n";
    exit(1);
}

$account = $argv[1];
$password = $argv[2];
$new_password = $argv[3];

require '../../lib/Config.php';
Config::init();
require 'TestConfig.php';

var_dump(Util::signedHttpRequest(
    TestConfig::$base_url, TestConfig::$secret_key,
    '/v2/change_password.php', array(
        'account' => $account,
        'password' => sha1($password),
        'new_password' => sha1($new_password),
    ), 'post')
);

exit(0);
