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
if ($app->checkRequestValid($_SERVER, $_POST) === false) {
    Util::error('request invalid');
}

$game_id = 2;
$imei = '';
$channel = '';
$device = '';
$uid = '';

if (isset($_POST['game']) !== false) {
    $game_id = $_POST['game'];
}
if (isset($_POST['device']) !== false) {
    $device = $_POST['device'];
}
if (isset($_POST['uid']) !== false) {
    $uid = $_POST['uid'];
}

if ($device == '' || $uid == '') {
    reportResponse(0);
}

if ('00000000-0000-0000-0000-000000000000' == $device) {
    reportResponse(0);
}

$dbh = $app->getDBHandler();
$sth = $dbh->prepare(
    'delete from `tbl_sgzj2_device` '.
    'where `uid` = :uid '.
    'and `device_id` = :device '.
    'and `game_id` = :game_id '
);
$sth->bindValue(':uid', $uid, PDO::PARAM_STR);
$sth->bindValue(':device', $device, PDO::PARAM_STR);
$sth->bindValue(':game_id', $game_id, PDO::PARAM_STR);

if (@$sth->execute() === false) {
    Util::error('db select failed');
}

$ret = $sth->fetch();
if ($ret !== false) {
    reportResponse(0);
}
