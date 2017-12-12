<?php

require('../../base/Config.php');
Config::init();

$service = new GiftCodeService();
$service->init();

if (isset($_GET['batch']) === false) {
    $service->response(array(
        'status' => false,
        ));
}

$batch = $_GET['batch'];

$used_count = $service->getUsedCount($batch);
$total_count = $service->getTotalCount($batch);

if ($used_count > 0 || $total_count > 0) {
    $service->response(array(
        'status' => true,
        'used_count' => $used_count,
        'total_count' => $total_count,
        ));
} else {
    $service->response(array(
        'status' => false,
        ));
}
