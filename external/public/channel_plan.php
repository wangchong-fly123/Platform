<?php

require '../lib/Config.php';
Config::init();

if (isset($_POST['channel']) === false) {
    Util::error('`channel` is required');
}

$channel = $_POST['channel'];

$app = new ServerApp();
$service = $app->getRoleAccountService();

$ret = $service->getChannelPlan($channel);

if (false == $service->checkIpIsValid($app->getClientIp())) {
    $ret = false;
}

if ($ret != false) {
    Util::response(array(
       'result' => array(
       'success' => true,
       'plan' => $ret,
       ),
    )); 
} else {
    Util::response(array(
       'result' => array(
       'success' => false,
       ),
    )); 
}
