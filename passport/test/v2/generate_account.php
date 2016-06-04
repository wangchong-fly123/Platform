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
    '/v2/generate_account.php', array(
    ), 'post')
);

exit(0);
