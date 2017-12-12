<?php

require('../../base/Config.php');
Config::init();

$service = new GiftCodeService();
$service->init();

if (isset($_GET['batch']) === false ||
    isset($_GET['end_time'] == false)) {
    $service->response(array(
        'status' => false,
        ));
}

$batch = $_GET['batch'];
$end_time = $_GET['end_time'];

$result = $service->updateEndtime($batch, $end_time);

if ($result != 0) {
    $service->response($result);
}
$service->response(array(
    'status' => false,
    ));
