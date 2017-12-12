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

$account = $_POST['account'];
$password = $_POST['password'];

// check account
if (preg_match('/^[a-zA-Z]\w{5,19}$/', $account) !== 1 &&
    preg_match('/^[0-9]{11,}$/', $account) !== 1) {
    Util::error('`account` is invalid');
}

// check password
if (preg_match('/^[0-9a-f]{40}$/', $password) !== 1) {
    Util::error('`password` is invalid');
}

$account_service = $app->getAccountService();
$auth_service = $app->getAuthService();

$account_info = $account_service->getAccountInfo($account, $password);
if ($account_info === false) {
    Util::error('`account` or `password` is invalid',
                ErrorCode::ACCOUNT_OR_PASSWORD_INVALID);
}
$uid = $account_info['uid'];
$account_type = $account_info['account_type'];
$bind_phone = 0;
$phone_num = '';

if ($account_info['mobile_phone'] !== null) {
    $bind_phone = 1;
    $phone_num = $account_info['mobile_phone'];
}

$token = $auth_service->generateLoginToken($uid);
if ($token === false) {
    Util::error('generate login token failed');
}

$account_service->updateLastLoginTime($account);

Util::response(array(
    'result' => array(
        'error_code' => 0,
        'uid' => $uid,
        'account_type' => $account_type,
        'token' => $token,
        'bind_phone' => $bind_phone,
        'phone_num' => $phone_num,
    ),
));
