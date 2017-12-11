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
if (isset($_POST['password']) === false) {
    Util::error('`password` is required');
}
if (isset($_POST['mobile_phone']) === false) {
    Util::error('`mobile_phone` is required');
}
if (isset($_POST['message_code']) === false) {
    Util::error('`message_code` is required');
}

$account = $_POST['account'];
$password = $_POST['password'];
$mobile_phone = $_POST['mobile_phone'];
$message_code = $_POST['message_code'];


// check password
if (preg_match('/^[0-9a-f]{40}$/', $password) !== 1) {
    Util::error('`password` is invalid');
}

$account_service = $app->getAccountService();
$auth_service = $app->getAuthService();

// check message code
if ($auth_service->checkAndClearMessageCode(
        $mobile_phone, $message_code) === false) {
    Util::error('`message_code` is invalid',
                ErrorCode::MESSAGE_CODE_INVALID);
}

// check account info
$account_info = $account_service->getAccountInfo($account, $password);
if ($account_info === false) {
    Util::error('`account` or `password` is invalid',
                ErrorCode::ACCOUNT_OR_PASSWORD_INVALID);
}
if ($account_info['mobile_phone'] !== null) {
    Util::error('already bind mobile phone',
                ErrorCode::ALREADY_BIND_MOBILE_PHONE);
}
if ($account_info['account_type'] != AccountType::NORMAL) {
    Util::error('`account_type` can not bind mobile phone');
}

// bind mobile phone
if ($account_service->bindMobilePhone($account, $mobile_phone) == false) {
    Util::error('`mobile_phone` duplicated',
                ErrorCode::MOBILE_PHONE_DUPLICATED);
}

Util::response(array(
    'result' => array(
        'error_code' => 0,
    ),
));
