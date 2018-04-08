<?php

require '../lib/Config.php';
Config::init();

if (isset($_POST['uid']) === false) {
    Util::error('`uid` is required');
}
if (isset($_POST['server_id']) === false) {
    Util::error('`server_id` is required');
}
if (isset($_POST['src_channel']) === false) {
    Util::error('`src_channel` is required');
}

$uid = $_POST['uid'];
$platform = 'ios_apple';
$server_id = $_POST['server_id'];
$src_channel = $_POST['src_channel'];

$app = new ServerApp();
$service = $app->getRoleAccountService();

$pre_check = $service->checkHasChanged(
    $src_channel, $uid, $server_id);
if ($pre_check) {
    Util::response(array(
       'result' => array(
       'success' => true,
       'url' => $service->getDownloadUrlByChannel($src_channel),
       ),
    )); 
}

$ret = $service->changeAccount(
    $uid, $platform, $server_id, $src_channel);

if ($ret) {
    $service->recordChange($src_channel, $uid, $server_id);

    Util::response(array(
       'result' => array(
       'success' => true,
       'url' => $service->getDownloadUrlByChannel($src_channel),
       ),
    )); 
} else {
    if ($src_channel == '500026') {
        Util::response(array(
           'result' => array(
           'success' => true,
           'url' => $service->getDownloadUrlByChannel($src_channel),
           ),
        )); 
    } else {
        Util::response(array(
           'result' => array(
           'success' => false,
           ),
        )); 
    }
}
