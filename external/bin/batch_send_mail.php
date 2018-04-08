<?php

require '../lib/Config.php';
Config::init();

$player_id_list = array(
    '210001000117974',
    '230001000029273',
);

$mail_title = "老玩家回归奖励";
$reward = "6&1,7&10";
$mail_content = "亲爱的主公，欢迎您的回归，同时感谢您对我们的继续支持";

foreach ($player_id_list as $player_id) {
    $platform_id = substr($player_id, 0, 2);
    $server_id = substr($player_id, 0, 6) % 10000;
    
    $app = new ServerApp();
    $service = $app->getPlayerListService();
    
    $info_ret = $service->getPlayerInfo($platform_id, $server_id, $player_id);
    if (!isset($info_ret['brief_info']['nickname'])) {
        Util::response(array(
            'success' => false,
            'op' => 'check',
            'player_id' => $player_id,
            'server_id' => $server_id));
    }
}


foreach ($player_id_list as $player_id) {
    $platform_id = substr($player_id, 0, 2);
    $server_id = substr($player_id, 0, 6) % 10000;

    $mail_ret = $service->sendPlayerMail($platform_id, $server_id,
        $player_id, $mail_title, $mail_content, $reward);
    if ($mail_ret['success'] == true) {
    
    
        echo $player_id." send success "."\n";
    } else {
        Util::response(array(
            'success' => false,
            'op' => 'send',
            'player_id' => $player_id,
            'server_id' => $server_id));
    }
}
