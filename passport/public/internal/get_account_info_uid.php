<?php

require '../../lib/Config.php';
Config::init();
Util::setErrorCallback('Util::ClientErrorCallback');

$app = new ServerApp();


if (Util::checkInternalIp($_SERVER['REMOTE_ADDR']) == false) {
    Util::error('ip invalid');
}

if (isset($_GET['uid']) === false) {
    Util::error('`uid` is required');
}

$uid = $_GET['uid'];

$account_service = $app->getAccountService();

$account_info = $account_service->getAccountInfoByUid($uid);
if ($account_info === false) {
    Util::error('`uid` is invalid',
                ErrorCode::UNKNOWN);
}

if ($uid != '') {
    Util::response(array(
        'result' => array(
            'error_code' => 0,
            'account' => $account_info['account'],
            'uid' => $account_info['uid'],
            'mobile_phone' => $account_info['mobile_phone'],
            'create_time' => $account_info['create_time'],
        ),
    ));
} else {
    Util::error('`uid` is empty',
                ErrorCode::NOT_BIND_MOBILE_PHONE);
}
