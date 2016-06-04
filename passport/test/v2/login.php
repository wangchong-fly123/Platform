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
require 'TestConfig.php';

var_dump(Util::signedHttpRequest(
    TestConfig::$base_url, TestConfig::$secret_key,
    '/v2/login.php', array(
        'account' => $account,
        'password' => sha1('1'),
    ), 'post')
);

exit(0);
