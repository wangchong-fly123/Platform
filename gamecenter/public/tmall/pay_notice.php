<?php

require('../../base/Config.php');
Config::init();
$service = new PayNoticeService();
$service->init();

Common::logPayRequest($_SERVER, $_GET);

$params = $_GET;

foreach ($_GET as $key => $value) {
    $params[$key] = urldecode($value);
}

$remote_ip = Common::getClientIp();

if ($service->checkSeverIp($remote_ip) === false ||
    $service->checkRequestValid($_SERVER, $_GET) === false) {
    // sign error
    $service->payResponse(2);
} else {

    $zone_service = new ZoneService();
    $zone_service->init();

    $zone_id = $params['gameserver'];
    $platform = 'appstore_tmall';
    $slave_url = $zone_service->getZoneWebInfo($zone_id, $platform);
    if ($slave_url == '') {
        $zone_service->payResponse(3);
    } else {
        $service->tmallPayNotice($params, $slave_url.'tmall/pay.php');
    }
}
