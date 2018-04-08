<?php

require '../lib/Config.php';
Config::init();

function accountResponse($ret, $platform='', $channel='')
{
    Util::response(array(
        'result' => array(
        'success' => $ret,
        'platform' => $platform,
        'channel' => $channel,
        ),
    ));
}

if (isset($_POST['imei']) === false) {
    Util::error('`imei` is required');
}
if (isset($_POST['old_uid']) === false) {
    Util::error('`old_uid` is required');
}
if (isset($_POST['src_channel']) === false) {
    Util::error('`src_channel` is required');
}
if (isset($_POST['uid']) === false) {
    Util::error('`uid` is required');
}
if (isset($_POST['platform']) === false) {
    Util::error('`platform` is required');
}

$imei = $_POST['imei'];
$uid = $_POST['uid'];
$old_uid = $_POST['old_uid'];
$platform = $_POST['platform'];
$src_channel = $_POST['src_channel'];


$app = new ServerApp();
$service = $app->getRoleAccountService();
$server_service = $app->getServerListService();
$player_service = $app->getPlayerListService();

$pre_check = $service->checkImeiHasChanged($imei, $src_channel);
if ($pre_check) {
    accountResponse(false);
}

$server_list = $server_service->getAccountServerList($src_channel.'_'.$old_uid);
$server_list = str_replace('"', '', $server_list);
$server_id_array = explode(';', $server_list);

$role_list = array();
for ($i = 0; $i < count($server_id_array); ++$i) {
    $player_role = $player_service->getPlayerList(
        $old_uid, $platform, $server_id_array[$i]);
    if (isset($player_role['error_code']) &&
        $player_role['error_code'] == -1) {
        continue;
    }
    if (isset($player_role[0]['player_id']) &&
        $player_role[0]['nickname'] != '' &&
        $player_role[0]['level'] >= 1) {
        $role_info = array(
            'nickname' => $player_role[0]['nickname'],
            'level' => $player_role[0]['level'],
            'player_id' => $player_role[0]['player_id'],
            'server_id' => $server_id_array[$i],
        );
        array_push($role_list, $role_info);
    }
}

if (count($role_list)) {
    for ($i = 0; $i < count($role_list); ++$i) {
        $service->changeAccountInGame(
            $old_uid, $uid, $platform,
            $role_list[$i]['server_id'], $src_channel);
    }
    $service->recordImeiChange($imei, $src_channel);

    accountResponse(true, $service->getOfficialPlatform(),
        $service->getOfficialChannel());
} else {
    accountResponse(false);
}

