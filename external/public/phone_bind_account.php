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

if (isset($_POST['uid']) === false) {
    Util::error('`uid` is required');
}
if (isset($_POST['phone']) === false) {
    Util::error('`phone` is required');
}

$uid = $_POST['uid'];
$phone = $_POST['phone'];

$app = new ServerApp();
$service = $app->getRoleAccountService();
$server_service = $app->getServerListService();
$player_service = $app->getPlayerListService();

$pre_check = $service->checkPhoneHasChanged($phone);
if ($pre_check) {
    accountResponse(false);
}

$bind_phone_info = $service->getBindPhoneInfo($phone);
if (false == $bind_phone_info) {
   accountResponse(false);
}
$old_uid = $bind_phone_info['uid'];
$platform = $bind_phone_info['platform'];
$src_channel = $bind_phone_info['channel'];
$server_id = $bind_phone_info['server_id'];

$has_passport = $service->checkHasEnjoymiPassport($phone);
if (false == $has_passport) {
   accountResponse(false);
}

$service->changeAccountInGame(
    $old_uid, $uid, $platform,
    $server_id, $src_channel);


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
}

$service->recordPhoneChange($phone);
accountResponse(true);
