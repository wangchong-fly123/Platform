<?php

require '../../lib/Config.php';
Config::init();
Util::setErrorCallback('Util::ClientErrorCallback');

$app = new ServerApp();


if (Util::checkInternalIp($_SERVER['REMOTE_ADDR']) == false) {
    Util::error('ip invalid');
}

if (isset($_GET['phone']) === false) {
    Util::error('`phone` is required');
}

$phone = $_GET['phone'];

$account_service = $app->getAccountService();

$account_info = $account_service->getAccountInfoByPhone($phone);
if ($account_info === false) {
    Util::error('`account` is invalid',
                ErrorCode::UNKNOWN);
}

$uid = $account_info['uid'];

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
