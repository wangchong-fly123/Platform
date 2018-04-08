<?php

require '../lib/Config.php';
Config::init();

$app = new ServerApp();

Util::response(array(
    'ret' => 0,
    'msg'=> 'success',
));

$appkey ='';
$spread_url ='';
$spread_name ='';
$ua ='';
$ip ='';
$click_time ='';
$adnet_name ='';
$appstore_id ='';

if (isset($_GET['appkey']) === false) {
    Util::error('`appkey` is required');
}
$appkey = $_GET['appkey'];

if (isset($_GET['spread_url']) === true) {
    $spread_url = $_GET['spread_url'];
}
if (isset($_GET['spread_name']) === true) {
    $spread_name = $_GET['spread_name'];
}
if (isset($_GET['ua']) === true) {
    $ua = $_GET['ua'];
}
if (isset($_GET['ip']) === true) {
    $ip  = $_GET['ip'];
}
if (isset($_GET['click_time']) === true) {
    $click_time = $_GET['click_time'];
}
if (isset($_GET['adnet_name']) === true) {
    $adnet_name = $_GET['adnet_name'];
}
if (isset($_GET['appstore_id']) === true) {
    $appstore_id = $_GET['appstore_id'];
}

$dbh = $app->getDBHandler();

$sth = $dbh->prepare(
    'insert ignore into `tbl_talkingdata_ad_click`('.
    '`appkey`, `spread_url`, `spread_name`, '.
    '`ua`, `ip`, `click_time`, `adnet_name`, `appstore_id`'.
    ') values ('.
    ':appkey, :spread_url, :spread_name, '.
    ':ua, :ip, :click_time, :adnet_name, :appstore_id)'
);
$sth->bindValue(':appkey', $appkey, PDO::PARAM_STR);
$sth->bindValue(':spread_url', $spread_url, PDO::PARAM_STR);
$sth->bindValue(':spread_name', $spread_name, PDO::PARAM_STR);
$sth->bindValue(':ua', $ua, PDO::PARAM_STR);
$sth->bindValue(':ip', $ip, PDO::PARAM_STR);
$sth->bindValue(':click_time', $click_time, PDO::PARAM_STR);
$sth->bindValue(':adnet_name', $adnet_name, PDO::PARAM_STR);
$sth->bindValue(':appstore_id', $appstore_id, PDO::PARAM_STR);

if (@$sth->execute() === false) {
    Util::error('db insert failed');
}

Util::response(array(
    'ret' => 0,
    'msg'=> 'success',
));
