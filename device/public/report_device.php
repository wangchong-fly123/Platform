<?php

require '../lib/Config.php';
Config::init();
Util::setErrorCallback('Util::ClientErrorCallback');

function reportResponse($ret)
{
    Util::response(array(
        'result' => array(
        'error_code' => $ret,
        ),
    ));
}

$app = new ServerApp();
if (isset($_GET['account']) === false) {
    Util::error('`account` is required');
}

$game_id = 1;
$imei = '';
$channel = '';
$device = '';
$idfa = '';
$phone = '';
$uid = '';

if (isset($_GET['game']) !== false) {
    $game_id = $_GET['game'];
}
if (isset($_GET['imei']) !== false) {
    $imei = $_GET['imei'];
}
if (isset($_GET['channel']) !== false) {
    $channel = $_GET['channel'];
}
if (isset($_GET['device']) !== false) {
    $device = $_GET['device'];
}
if (isset($_GET['idfa']) !== false) {
    $idfa = $_GET['idfa'];
}
if (isset($_GET['phone']) !== false) {
    $phone = $_GET['phone'];
}
if (isset($_GET['uid']) !== false) {
    $uid = $_GET['uid'];
}


$account = $_GET['account'];

if ($account == '') {
    reportResponse(0);
}

// android
if ($imei != '') {
    $account = $channel.'_'.$account;
}

if ('00000000-0000-0000-0000-000000000000' == $device) {
    reportResponse(0);
}
if ('00000000-0000-0000-0000-000000000000' == $idfa) {
    reportResponse(0);
}

$dbh = $app->getDBHandler();
$sth = $dbh->prepare(
    'select 1 from `tbl_device` '.
    'where `account` = :account '.
    'and `device_id` = :device '.
    'and `game_id` = :game_id '
);
$sth->bindValue(':account', $account, PDO::PARAM_STR);
$sth->bindValue(':device', $device, PDO::PARAM_STR);
$sth->bindValue(':game_id', $game_id, PDO::PARAM_STR);

if (@$sth->execute() === false) {
    Util::error('db select failed');
}

$ret = $sth->fetch();
if ($ret !== false) {
    reportResponse(0);
}

$record_time = date("Y-m-d H:i:s");
$sth = $dbh->prepare(
    'replace into `tbl_device`('.
    '`account`, `device_id`,`record_time`,`game_id`,`imei`,`idfa`,`phone`,`uid` '.
    ') values ('.
    ':account, :device, :record_time, :game_id, :imei, :idfa, :phone, :uid)'
);
$sth->bindValue(':account', $account, PDO::PARAM_STR);
$sth->bindValue(':device', $device, PDO::PARAM_STR);
$sth->bindValue(':record_time', $record_time, PDO::PARAM_STR);
$sth->bindValue(':game_id', $game_id, PDO::PARAM_STR);
$sth->bindValue(':imei', $imei, PDO::PARAM_STR);
$sth->bindValue(':idfa', $idfa, PDO::PARAM_STR);
$sth->bindValue(':phone', $phone, PDO::PARAM_STR);
$sth->bindValue(':uid', $uid, PDO::PARAM_STR);

if (@$sth->execute() === false) {
    Util::error('db insert failed');
}

reportResponse(0);
