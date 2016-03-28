<?php

require('../../base/Config.php');
Config::init();
$service = new PayNoticeService();
$service->init();

Common::logPayRequest($_SERVER, $_POST);

$params = $_POST;
if (isset($_POST['server_id']) === false ||
    isset($_POST['private_data']) === false) {
    $service->error('pay', -1);
}

$remote_ip = $_SERVER['REMOTE_ADDR'];

if ($service->checkAnySDKSever($remote_ip) === false) {
    $service->error('pay', 1);
} else {
    $zone_service = new ZoneService();
    $zone_service->init();

    $zone_id = $params['server_id'];
    $platform = $params['private_data'];
    $slave_url = $zone_service->getZoneWebInfo($zone_id, $platform);
    if ($slave_url == '') {
        $service->error('pay', 2);
    } else {
        $service->payNotice($params, $slave_url.'anysdk/pay.php');
    }
}
