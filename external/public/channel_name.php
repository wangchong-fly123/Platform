<?php

require '../lib/Config.php';
Config::init();

$app = new ServerApp();
$service = $app->getServerListService();

$ret = $service->getChannelList();

if ($ret != false) {
    Util::response(array(
       'result' => array(
       'success' => true,
       'channel' => $ret,
       ),
    )); 
} else {
    Util::response(array(
       'result' => array(
       'success' => false,
       ),
    )); 
}
