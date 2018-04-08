<?php

require '../lib/Config.php';
Config::init();

$app = new ServerApp();

if (isset($_GET['muid']) === false) {
    Util::error('`muid` is required');
}
if (isset($_GET['click_time']) === false) {
    Util::error('`click_time` is required');
}
if (isset($_GET['click_id']) === false) {
    Util::error('`click_id` is required');
}
if (isset($_GET['appid']) === false) {
    Util::error('`appid` is required');
}
if (isset($_GET['advertiser_id']) === false) {
    Util::error('`advertiser_id` is required');
}
if (isset($_GET['app_type']) === false) {
    Util::error('`app_type` is required');
}

$muid = $_GET['muid'];
$click_time = $_GET['click_time'];
$click_id = $_GET['click_id'];
$appid = $_GET['appid'];
$advertiser_id = $_GET['advertiser_id'];
$app_type = $_GET['app_type'];

$dbh = $app->getDBHandler();

$sth = $dbh->prepare(
    'select 1 from `tbl_weixin_ad_click` '.
    'where `muid` = :muid '.
    'and `appid` = :appid '.
    'and `advertiser_id` = :advertiser_id '.
    'and `activite_time` <> 0'
);
$sth->bindValue(':muid', $muid, PDO::PARAM_STR);
$sth->bindValue(':appid', $appid, PDO::PARAM_STR);
$sth->bindValue(':advertiser_id', $advertiser_id, PDO::PARAM_STR);

if (@$sth->execute() === false) {
    Util::error('db select failed');
}

$ret = $sth->fetch();
if ($ret !== false) {
    Util::response(array(
        'ret' => 0,
        'msg'=> 'success',
    ));
}

$sth = $dbh->prepare(
    'replace into `tbl_weixin_ad_click`('.
    '`muid`, `appid`, `advertiser_id`, '.
    '`app_type`, `click_id`, `click_time`'.
    ') values ('.
    ':muid, :appid, :advertiser_id, '.
    ':app_type, :click_id, :click_time)'
);
$sth->bindValue(':muid', $muid, PDO::PARAM_STR);
$sth->bindValue(':appid', $appid, PDO::PARAM_STR);
$sth->bindValue(':advertiser_id', $advertiser_id, PDO::PARAM_STR);
$sth->bindValue(':app_type', $app_type, PDO::PARAM_STR);
$sth->bindValue(':click_id', $click_id, PDO::PARAM_STR);
$sth->bindValue(':click_time', $click_time, PDO::PARAM_INT);

if (@$sth->execute() === false) {
    Util::error('db insert failed');
}

Util::response(array(
    'ret' => 0,
    'msg'=> 'success',
));
