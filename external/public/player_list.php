<?php

require '../lib/Config.php';
Config::init();

if (isset($_GET['uid']) === false) {
    Util::error('`uid` is required');
}
if (isset($_GET['platform']) === false) {
    Util::error('`platform` is required');
}
if (isset($_GET['server_id']) === false) {
    Util::error('`server_id` is required');
}

$uid = $_GET['uid'];
$platform = $_GET['platform'];
$server_id = $_GET['server_id'];

$app = new ServerApp();
$service = $app->getPlayerListService();

$player_role_list = $service->getPlayerList($uid, $platform, $server_id);
if (count($player_role_list) > 0) {
    Util::response(array(
        'error_code' => 0,
        'role_list' => $player_role_list));
} else {
    Util::error('uid is invalid');
}
