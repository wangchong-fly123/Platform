<?php

require '../lib/Config.php';
Config::init();

$app = new ServerApp();
$service = $app->getServerListService();

$ret = $service->getPlatformList();

if ($ret != false) {
    Util::response(array(
       'result' => array(
       'success' => true,
       'platform' => $ret,
       ),
    )); 
} else {
    Util::response(array(
       'result' => array(
       'success' => false,
       ),
    )); 
}
