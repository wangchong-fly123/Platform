<?php

require '../../lib/Config.php';
Config::init();
Util::setErrorCallback('Util::ClientErrorCallback');

$app = new ServerApp();
if ($app->checkRequestValid($_SERVER, $_POST) === false) {
    Util::error('request invalid');
}

if (isset($_POST['mobile_phone']) === false) {
    Util::error('`mobile_phone` is required');
}
if (isset($_POST['password']) === false) {
    Util::error('`password` is required');
}
if (isset($_POST['message_code']) === false) {
    Util::error('`message_code` is required');
}

$mobile_phone = $_POST['mobile_phone'];
$password = $_POST['password'];
$message_code = $_POST['message_code'];

// check mobile phone
if (preg_match('/^[0-9]{11,}$/', $mobile_phone) !== 1) {
    Util::error('`mobile_phone` is invalid');
}

// check password
if (preg_match('/^[0-9a-f]{40}$/', $password) !== 1) {
    Util::error('`password` is invalid');
}

$account_service = $app->getAccountService();
$auth_service = $app->getAuthService();

// check phone account
$account_info = $account_service->getAccountInfoByPhone($mobile_phone);
if ($account_info === false) {
    Util::error('`mobile_phone` is invalid',
                ErrorCode::NOT_BIND_MOBILE_PHONE);
}

$uid = $account_info['uid'];
// check message code
if ($auth_service->checkRebindCode(
        $uid, $message_code) === false) {
    $auth_service->clearRebindCode($uid);

    Util::error('`message_code` is invalid',
                ErrorCode::MESSAGE_CODE_INVALID);
}

$account = $account_info['account'];

$auth_service->setRebindFlag($uid);
$auth_service->clearRebindCode($uid);

Util::response(array(
    'result' => array(
        'error_code' => 0,
        'account' => $account,
    ),
));
