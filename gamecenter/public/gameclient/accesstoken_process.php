<?php

header("Content-type: text/html; charset=utf-8");
require('../../base/Config.php');
Config::init();

$service = new LoginTokenService();
$service->init();

$params = $_REQUEST;

if (!isset($params['channel']) ||
    !isset($params['uapi_key']) ||
    !isset($params['uapi_secret'])) {
    $service->error("accesstoken", 1);
}

$service->accessToken($params);
