#!/usr/bin/env php
<?php

if (PHP_SAPI !== 'cli') {
    exit(1);
}

require '../../lib/Config.php';
Config::init();
require 'TestConfig.php';

var_dump(Util::signedHttpRequest(
    TestConfig::$base_url, TestConfig::$secret_key,
    '/v2/guest_register.php', array(
        'password' => sha1('1'),
    ), 'post')
);

exit(0);
