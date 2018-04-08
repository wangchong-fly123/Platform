<?php

require '../lib/Config.php';
Config::init();

if (isset($_POST['phone']) === false) {
    Util::error('`phone` is required');
}

$phone = $_POST['phone'];

$app = new ServerApp();
$service = $app->getRoleAccountService();
$ret = $service->sendMessageCode($phone);

if (false != $ret) {
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
