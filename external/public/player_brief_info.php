<?php

require '../lib/Config.php';
Config::init();

if (isset($_GET['platform_id']) === false) {
    Util::error('`platform_id` is required');
}
if (isset($_GET['server_id']) === false) {
    Util::error('`server_id` is required');
}
if (isset($_GET['player_id']) === false) {
    Util::error('`player_id` is required');
}

$platform_id = $_GET['platform_id'];
$server_id = $_GET['server_id'];
$player_id = $_GET['player_id'];

$app = new ServerApp();
$service = $app->getPlayerListService();

$info_ret = $service->getPlayerInfo($platform_id, $server_id, $player_id);

if (isset($info_ret['brief_info'])) {
    Util::response(array(
        'success' => true,
        'role_info' => $info_ret['brief_info']));
} else {
    Util::response(array(
        'success' => false));
}
