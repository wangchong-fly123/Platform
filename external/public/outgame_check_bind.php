<?php

require '../lib/Config.php';
Config::init();

function accountResponse($ret, $account_array=array(), $platform='', $channel='')
{
    Util::response(array(
        'result' => array(
        'error_code' => $ret,
        'uid' => $account_array,
        'platform' => $platform,
        'channel' => $channel,
        ),
    ));
}

if (isset($_POST['imei']) === false) {
    Util::error('`imei` is required');
}
if (isset($_POST['channel']) === false) {
    Util::error('`channel` is required');
}
if (isset($_POST['platform']) === false) {
    Util::error('`platform` is required');
}

$imei = $_POST['imei'];
$platform = $_POST['platform'];
$channel = $_POST['channel'];

$app = new ServerApp();
$service = $app->getRoleAccountService();
$pre_check = $service->checkImeiHasChanged($imei, $channel);
if ($pre_check) {
    accountResponse(-1, array());
}

$uid_list = $service->getAccountByImei($imei, $platform);
if (count($uid_list)) {
    accountResponse(0, $uid_list);
} else {
    accountResponse(1, array(),
        $service->getOfficialPlatform(), $service->getOfficialChannel());
}
