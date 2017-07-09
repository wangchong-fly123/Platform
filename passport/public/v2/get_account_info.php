<?php

require '../../lib/Config.php';
Config::init();
Util::setErrorCallback('Util::ClientErrorCallback');

$app = new ServerApp();
if ($app->checkRequestValid($_SERVER, $_POST) === false) {
    Util::error('request invalid');
}

if (isset($_POST['account']) === false) {
    Util::error('`account` is required');
}

$account = $_POST['account'];

$account_service = $app->getAccountService();

$account_info = $account_service->getAccountInfoByAccount($account);
if ($account_info === false) {
    Util::error('`account` is invalid',
                ErrorCode::UNKNOWN);
}

$phone = $account_info['mobile_phone'];

if ($phone != '') {
    Util::response(array(
        'result' => array(
            'error_code' => 0,
            'account' => $account,
            'mobile_phone' => $phone,
        ),
    ));
} else {
    Util::error('`mobile_phone` is empty',
                ErrorCode::NOT_BIND_MOBILE_PHONE);
}
