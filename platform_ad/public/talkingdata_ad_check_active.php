<?php

require '../lib/Config.php';
Config::init();

$app = new ServerApp();

$appkey = '';
$tdid = '';

if (isset($_GET['appkey']) === true) {
    $appkey = $_GET['appkey'];
}
if (isset($_GET['tdid']) === true) {
    $tdid = $_GET['tdid'];
}

$dbh = $app->getDBHandler();

$sth = $dbh->prepare(
    'select `spread_url`,`event_time` from `tbl_talkingdata_ad_active` '.
    'where `tdid` = :tdid and `appkey` = :appkey '.
    'order by `event_time` desc'
);
$sth->bindValue(':tdid', $tdid, PDO::PARAM_STR);
$sth->bindValue(':appkey', $appkey, PDO::PARAM_STR);

if (@$sth->execute() === false) {
    Util::error('db select failed');
}

$ret = $sth->fetch(PDO::FETCH_ASSOC);
if ($ret !== false) {
    $event_time = $ret['event_time'];
    $now = time();
    if ($now > $event_time/1000 + 86400*3) {
        Util::response(array(
            'ret' => -1,
        ));
    } else {
        Util::response(array(
            'ret' => 0,
            'spread_url' => $ret['spread_url'],
        ));
    }
}

Util::response(array(
    'ret' => -1,
));
