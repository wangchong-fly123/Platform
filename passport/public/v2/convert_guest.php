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
if (isset($_POST['new_account']) === false) {
    Util::error('`new_account` is required');
}
if (isset($_POST['new_password']) === false) {
    Util::error('`new_password` is required');
}

$account = $_POST['account'];
$password = $_POST['password'];
$new_account = $_POST['new_account'];
$new_password = $_POST['new_password'];

// check account
if (preg_match('/^guest\d{9}$/', $account) !== 1) {
    Util::error('`account` is invalid');
}

// check password
if (preg_match('/^[0-9a-f]{40}$/', $password) !== 1) {
    Util::error('`password` is invalid');
}

// check new account
if (preg_match('/^[a-zA-Z]\w{5,19}$/', $new_account) !== 1) {
    Util::error('`new_account` is invalid');
}

// check new password
if (preg_match('/^[0-9a-f]{40}$/', $new_password) !== 1) {
    Util::error('`new password` is invalid');
}

$account_service = $app->getAccountService();

$account_info = $account_service->getAccountInfo($account, $password);
if ($account_info === false) {
    Util::error('`account` or `password` is invalid',
                ErrorCode::ACCOUNT_OR_PASSWORD_INVALID);
}
$uid = $account_info['uid'];
$account_type = $account_info['account_type'];

if ($account_type != AccountType::GUEST) {
    Util::error('account is not guest');
}

// convert guest
if ($account_service->convertGuest(
        $account, $new_account, $new_password) === false) {
    Util::error('`account` duplicated',
        ErrorCode::ACCOUNT_DUPLICATED);
}

Util::response(array(
    'result' => array(
        'error_code' => 0,
    ),
));
