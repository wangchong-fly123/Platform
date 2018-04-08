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
if (isset($_GET['code']) === false) {
    Util::error('`code` is required');
}

$platform_id = $_GET['platform_id'];
$server_id = $_GET['server_id'];
$player_id = $_GET['player_id'];
$code = $_GET['code'];

$app = new ServerApp();
$service = $app->getPlayerListService();

$mail_ret = $service->sendPlayerMail($platform_id, $server_id,
    $player_id, '客服专区', '您正在绑定三国战纪客服专区，这是您的验证码:'.$code, '');
if ($mail_ret['success'] == true) {
    $info_ret = $service->getPlayerInfo($platform_id, $server_id, $player_id);
    if (isset($info_ret['brief_info']['nickname'])) {
        $role_name = $info_ret['brief_info']['nickname'];
    }
    Util::response(array(
        'success' => true,
        'role_name' => $role_name));
} else {
    Util::response(array(
        'success' => false));
}
