<?php

require('../../base/Config.php');
Config::init();

$service = new GiftCodeService();
$service->init();

if ($service->checkRequestValid($_SERVER, $_GET) === false) {
    $service->response(array(
        'status' => false,
        ));
}

if (isset($_GET['giftcode']) === false ||
    isset($_GET['channel']) === false) {
    $service->response(array(
        'status' => false,
        ));
}

$giftcode = $_GET['giftcode'];
$channel = $_GET['channel'];

$giftcode = strtoupper($giftcode);
$result = $service->checkUse($giftcode, $channel);
if ($result > 0) {
    $service->response(array(
        'status' => true,
        'gift_id' => $result,
        ));
} else {
    $service->response(array(
        'status' => false,
        'error' => $result,
        ));
}
