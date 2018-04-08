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

if (true == $service->checkMailHasSend($player_id)) {
    Util::response(array(
        'success' => false));
}

$mail_ret = $service->sendPlayerMail($platform_id, $server_id,
    $player_id, '客服专区', '恭喜您成功绑定客服专区，这是您获得的绑定奖励', '');
if ($mail_ret['success'] == true) {
    $service->recordMailPlayer($player_id);

    Util::response(array(
        'success' => true));
} else {
    Util::response(array(
        'success' => false));
}
