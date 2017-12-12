<?php

require('../../base/Config.php');
Config::init();

$service = new GiftCodeService();
$service->init();

if (isset($_GET['code']) === false) {
    $service->response(array(
        'status' => false,
        ));
}

$code = $_GET['code'];

$result = $service->getCodeInfo($code);

if ($result != 0) {
    $service->response($result);
}
$service->response(array(
    'status' => false,
    ));
