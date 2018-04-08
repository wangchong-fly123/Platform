<?php

require '../lib/Config.php';
Config::init();

if (isset($_POST['channel']) === false) {
    Util::error('`channel` is required');
}
if (isset($_POST['uid']) === false) {
    Util::error('`uid` is required');
}
if (isset($_POST['platform']) === false) {
    Util::error('`platform` is required');
}
if (isset($_POST['phone']) === false) {
    Util::error('`phone` is required');
}
if (isset($_POST['message_code']) === false) {
    Util::error('`message_code` is required');
}
if (isset($_POST['server_id']) === false) {
    Util::error('`server_id` is required');
}

$channel = $_POST['channel'];
$uid = $_POST['uid'];
$platform = $_POST['platform'];
$phone = $_POST['phone'];
$message_code = $_POST['message_code'];
$server_id = $_POST['server_id'];

$app = new ServerApp();
$service = $app->getRoleAccountService();

$is_bind = $service->checkHasBindPhone($phone);
if (true == $is_bind) {
    Util::response(array(
       'result' => array(
       'success' => true,
       ),
    )); 
}

$ret = $service->checkMessageCode($phone, $message_code);
if ($ret) {
    $service->recordGamePhone($platform, $channel, $uid, $phone, $server_id);
}

if ($ret != false) {
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
