<?php

require '../../lib/Config.php';
Config::init();
Util::setErrorCallback('Util::ClientErrorCallback');

$app = new ServerApp();
if (Util::checkInternalIp($_SERVER['REMOTE_ADDR']) == false) {
    Util::error('ip invalid');
}

if (isset($_GET['account']) === false) {
    Util::error('`account` is required');
}

$account = $_GET['account'];

$account_service = $app->getAccountService();

$account_info = $account_service->getAccountInfoByAccount($account);
if ($account_info === false) {
    Util::error('`account` is invalid',
                ErrorCode::UNKNOWN);
}

// bind mobile phone
if ($account_service->clearMobilePhone($account) == false) {
    Util::error('`mobile_phone` clear error');
}

Util::response(array(
    'result' => array(
        'error_code' => 0,
    ),
));
