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
if (isset($_POST['new_password']) === false) {
    Util::error('`new_password` is required');
}

$account = $_POST['account'];
$password = $_POST['password'];
$new_password = $_POST['new_password'];

// check account
if (preg_match('/^[a-zA-Z]\w{5,19}$/', $account) !== 1 &&
    preg_match('/^[0-9]{11,}$/', $account) !== 1) {
    Util::error('`account` is invalid');
}

// check password
if (preg_match('/^[0-9a-f]{40}$/', $password) !== 1) {
    Util::error('`password` is invalid');
}

// check new_password
if (preg_match('/^[0-9a-f]{40}$/', $new_password) !== 1) {
    Util::error('`new_password` is invalid');
}

$account_service = $app->getAccountService();

if ($account_service->checkPassword($account, $password) === false) {
    Util::error('`account` or `password` is invalid',
                ErrorCode::ACCOUNT_OR_PASSWORD_INVALID);
}

$result = $account_service->changePassword($account, $new_password);
if ($result === false) {
    Util::error('change password failed');
}

Util::response(array(
    'result' => array(
        'error_code' => 0,
    ),
));
