<?php

require '../../lib/Config.php';
Config::init();

if (isset($_GET['uid']) === false) {
    Util::error('`uid` is required');
}
if (isset($_GET['token']) === false) {
    Util::error('`token` is required');
}

$uid = $_GET['uid'];
$token = $_GET['token'];

// check account
if (preg_match('/^\d{9,}$/', $uid) !== 1) {
    Util::error('`uid` is invalid');
}

if (preg_match('/^[0-9a-f]{32}$/', $token) !== 1) {
    Util::error('`token` is invalid');
}

$app = new ServerApp();
$auth_service = $app->getAuthService();

if ($auth_service->checkLoginToken($uid, $token) === false) {
    Util::error('`token` is invalid');
}

Util::response(array(
    'error_code' => 0,
));
