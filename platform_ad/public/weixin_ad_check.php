<?php

require '../lib/Config.php';
Config::init();
Util::setErrorCallback('Util::ClientErrorCallback');

$app = new ServerApp();
if (isset($_GET['muid']) === false) {
    Util::error('`muid` is required');
}
if (isset($_GET['appid']) === false) {
    Util::error('`appid` is required');
}
if (isset($_GET['advertiser_id']) === false) {
    Util::error('`advertiser_id` is required');
}

$muid = $_GET['muid'];
$appid = $_GET['appid'];
$advertiser_id = $_GET['advertiser_id'];
$activite_time = time();

$dbh = $app->getDBHandler();
$sth = $dbh->prepare(
    'select `id`, `muid`, `appid`, `advertiser_id`, '.
    '`app_type`, `click_id`, `click_time`, `activite_time` '.
    'from `tbl_weixin_ad_click` '.
    'where `muid` = :muid '.
    'and `appid` = :appid '.
    'and `advertiser_id` = :advertiser_id'
);
$sth->bindValue(':muid', $muid, PDO::PARAM_STR);
$sth->bindValue(':appid', $appid, PDO::PARAM_STR);
$sth->bindValue(':advertiser_id', $advertiser_id, PDO::PARAM_STR);

if (@$sth->execute() === false) {
    Util::error('db select failed');
}

$ret = $sth->fetch(PDO::FETCH_ASSOC);
if ($ret === false) {
    Util::error('ad click not found');
}

Util::response(array(
    'result' => array(
        'error_code' => 0,
    ),
));
