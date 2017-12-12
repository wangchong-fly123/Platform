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

$player_id = '';

if (isset($_GET['giftcode']) === false ||
    isset($_GET['channel']) === false) {
    $service->response(array(
        'status' => false,
        ));
}

if (isset($_GET['player_id'])) {
    $player_id = $_GET['player_id'];
}

$giftcode = $_GET['giftcode'];
$channel = $_GET['channel'];

$giftcode = strtoupper($giftcode);
$result = $service->useCode($giftcode, $channel, $player_id);
if ($result == 0) {
    $service->response(array(
        'status' => true,
        ));
} else {
    $service->response(array(
        'status' => false,
        ));
}
