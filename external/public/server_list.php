<?php

require '../lib/Config.php';
Config::init();

if (isset($_GET['platform']) === false) {
    Util::error('`platform` is required');
}

$platform = $_GET['platform'];
$app = new ServerApp();
$service = $app->getServerListService();

$server_list = $service->getServerList($platform);
if (count($server_list) > 0) {
    echo $server_list;
} else {
    Util::error('platform is invalid');
}
