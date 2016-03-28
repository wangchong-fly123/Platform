<?php
require('../../base/Config.php');
Config::init();
$service = new LoginTokenService();
$service->init();

$uid = '';
$token = '';
$channel = '';

if (isset($_GET['uid']) === false ||
    isset($_GET['token']) === false ||
    isset($_GET['channel']) === false) {
    $service->error('login', 1);

} else {
    $uid = $_GET['uid'];
    $token = $_GET['token'];
    $channel = $_GET['channel'];
}

if ($service->checkToken($channel.'_'.$uid, $token) === true) {
    $service->error('login', 0);
} else {
    $service->error('login', 2);
}
