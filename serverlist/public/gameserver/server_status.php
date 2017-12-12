<?php

require('../../base/Config.php');
Config::init();

$zone_service = new ZoneService();
$zone_service->init();

if ($zone_service->checkRequestValid($_SERVER, $_GET) === false) {
    $zone_service->error('status', -1);
}

$params = $_GET;
if (isset($_GET['server_id']) === false ||
    isset($_GET['platform_id']) === false ||
    isset($_GET['status']) === false) {
    $zone_service->error('status', -2);
}

$zone_id = $params['server_id'];
$platform_id = $params['platform_id'];
$status = $params['status'];
if ($status != 1 && $status != 0) {
    $zone_service->error('status', -3);
}

$zone_service->updateZoneStatusInfo($zone_id, $platform_id, $status);
