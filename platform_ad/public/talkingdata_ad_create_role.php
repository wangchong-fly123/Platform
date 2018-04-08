<?php

require '../lib/Config.php';
Config::init();

$app = new ServerApp();

$appkey ='';
$role_name ='';
$account_id ='';
$event_time ='';
$os_version ='';
$device_type ='';
$idfa ='';
$mac ='';
$advertising_id ='';
$android_id ='';
$imei ='';
$tdid ='';
$ip ='';
$spread_url ='';
$spread_name ='';
$ua ='';
$click_ip ='';
$click_time ='';
$adnet_name ='';
$appstore_id ='';
$deeplink ='';
$channel_package_id ='';

if (isset($_GET['appkey']) === false) {
    Util::error('`appkey` is required');
}
$appkey = $_GET['appkey'];

if (isset($_GET['role_name']) === true) {
    $role_name = $_GET['role_name'];
}
if (isset($_GET['account_id']) === true) {
    $account_id = $_GET['account_id'];
}
if (isset($_GET['event_time']) === true) {
    $event_time = $_GET['event_time'];
}
if (isset($_GET['os_version']) === true) {
    $os_version = $_GET['os_version'];
}
if (isset($_GET['device_type']) === true) {
    $device_type = $_GET['device_type'];
}
if (isset($_GET['idfa']) === true) {
    $idfa = $_GET['idfa'];
}
if (isset($_GET['mac']) === true) {
    $mac = $_GET['mac'];
}
if (isset($_GET['advertising_id']) === true) {
    $advertising_id = $_GET['advertising_id'];
}
if (isset($_GET['android_id']) === true) {
    $android_id = $_GET['android_id'];
}
if (isset($_GET['imei']) === true) {
    $imei = $_GET['imei'];
}
if (isset($_GET['tdid']) === true) {
    $tdid = $_GET['tdid'];
}
if (isset($_GET['ip']) === true) {
    $ip = $_GET['ip'];
}
if (isset($_GET['spread_url']) === true) {
    $spread_url = $_GET['spread_url'];
}
if (isset($_GET['spread_name']) === true) {
    $spread_name = $_GET['spread_name'];
}
if (isset($_GET['ua']) === true) {
    $ua = $_GET['ua'];
}
if (isset($_GET['click_ip']) === true) {
    $click_ip  = $_GET['click_ip'];
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
if (isset($_GET['deeplink']) === true) {
    $adnet_name = $_GET['deeplink'];
}
if (isset($_GET['channel_package_id']) === true) {
    $channel_package_id = $_GET['channel_package_id'];
}

$dbh = $app->getDBHandler();

$sth = $dbh->prepare(
    'insert ignore into `tbl_talkingdata_ad_create_role`('.
    '`appkey`, `role_name`, `account_id`, `event_time`, `os_version`, '.
    '`device_type`, `idfa`, `mac`, `advertising_id`, '.
    '`android_id`, `imei`, `tdid`, '.
    '`ip`, `spread_url`, `spread_name`, '.
    '`ua`, `click_ip`, `click_time`, `adnet_name`, '.
    ' `appstore_id`, `deeplink`, `channel_package_id` '.
    ') values ('.
    ':appkey, :role_name, :account_id, :event_time, :os_version, '.
    ':device_type, :idfa, :mac, :advertising_id, '.
    ':android_id, :imei, :tdid, '.
    ':ip, :spread_url, :spread_name, '.
    ':ua, :click_ip, :click_time, :adnet_name, '.
    ':appstore_id, :deeplink, :channel_package_id)'
);
$sth->bindValue(':appkey', $appkey, PDO::PARAM_STR);
$sth->bindValue(':role_name', $role_name, PDO::PARAM_STR);
$sth->bindValue(':account_id', $account_id, PDO::PARAM_STR);
$sth->bindValue(':event_time', $event_time, PDO::PARAM_STR);
$sth->bindValue(':os_version', $os_version, PDO::PARAM_STR);
$sth->bindValue(':device_type', $device_type, PDO::PARAM_STR);
$sth->bindValue(':idfa', $idfa, PDO::PARAM_STR);
$sth->bindValue(':mac', $mac, PDO::PARAM_STR);
$sth->bindValue(':advertising_id', $advertising_id, PDO::PARAM_STR);
$sth->bindValue(':android_id', $android_id, PDO::PARAM_STR);
$sth->bindValue(':imei', $imei, PDO::PARAM_STR);
$sth->bindValue(':tdid', $tdid, PDO::PARAM_STR);
$sth->bindValue(':ip', $ip, PDO::PARAM_STR);
$sth->bindValue(':spread_url', $spread_url, PDO::PARAM_STR);
$sth->bindValue(':spread_name', $spread_name, PDO::PARAM_STR);
$sth->bindValue(':ua', $ua, PDO::PARAM_STR);
$sth->bindValue(':click_ip', $click_ip, PDO::PARAM_STR);
$sth->bindValue(':click_time', $click_time, PDO::PARAM_STR);
$sth->bindValue(':adnet_name', $adnet_name, PDO::PARAM_STR);
$sth->bindValue(':appstore_id', $appstore_id, PDO::PARAM_STR);
$sth->bindValue(':deeplink', $deeplink, PDO::PARAM_STR);
$sth->bindValue(':channel_package_id', $channel_package_id, PDO::PARAM_STR);

if (@$sth->execute() === false) {
    Util::error('db insert failed');
}

Util::response(array(
    'ret' => 0,
    'msg'=> 'success',
));
