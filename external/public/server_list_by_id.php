<?php

require '../lib/Config.php';
Config::init();

if (isset($_GET['platform_id']) === false) {
    Util::error('`platform_id` is required');
}

$platform_id = $_GET['platform_id'];
$app = new ServerApp();
$service = $app->getServerListService();

$server_list = $service->getServerListById($platform_id);
if (count($server_list) > 0) {
    echo $server_list;
} else {
    Util::error('platform_id is invalid');
}
