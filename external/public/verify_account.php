<?php

require '../lib/Config.php';
Config::init();

if (isset($_POST['account']) === false) {
    Util::error('`account` is required');
}

$account = $_POST['account'];

$app = new ServerApp();
$service = $app->getRoleAccountService();

$remote_ip = $_SERVER['REMOTE_ADDR'];

$ret = $service->checkIsGmAccount($account);
$ip_ret = $service->checkGmIp($remote_ip);
if ($ret && $ip_ret) {
    Util::response(array(
       'result' => array(
       'success' => true,
       ),
    )); 
} else {
    Util::response(array(
       'result' => array(
       'success' => false,
       ),
    )); 
}
