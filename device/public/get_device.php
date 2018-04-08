<?php

require '../lib/Config.php';
Config::init();
Util::setErrorCallback('Util::ClientErrorCallback');

function deviceResponse($ret, $device_array)
{
    Util::response(array(
        'result' => array(
        'error_code' => $ret,
        'device' => $device_array,
        ),
    ));
}

$app = new ServerApp();
if (isset($_GET['account']) === false) {
    Util::error('`account` is required');
}

$account = $_GET['account'];
$device_array = array();

$dbh = $app->getDBHandler();
$sth = $dbh->prepare(
    'select `device_id`,`record_time`,`imei`,`game_id` from `tbl_device` '.
    'where `account` = :account '
);
$sth->bindValue(':account', $account, PDO::PARAM_STR);

if (@$sth->execute() === false) {
    deviceResponse(-1, $device_array);
}

while ($result = $sth->fetch(PDO::FETCH_ASSOC)) {
    $device_array[] = $result['device_id'].','.$result['record_time'].','.
        $result['imei'].','.$result['game_id'];
}

deviceResponse(0, $device_array);
