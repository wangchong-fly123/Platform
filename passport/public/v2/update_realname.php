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
if (isset($_POST['name']) === false) {
    Util::error('`name` is required');
}
if (isset($_POST['id_num']) === false) {
    Util::error('`id_num` is required');
}

$account = $_POST['account'];
$password = $_POST['password'];
$name = $_POST['name'];
$id_num = $_POST['id_num'];

// check account
if (preg_match('/^[a-zA-Z]\w{5,19}$/', $account) !== 1 &&
    preg_match('/^[0-9]{11,}$/', $account) !== 1) {
    Util::error('`account` is invalid');
}

// check id_num
if (preg_match('/^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/', $id_num) !== 1) {
    Util::error('`id_num` is invalid');
}

// check password
if (preg_match('/^[0-9a-f]{40}$/', $password) !== 1) {
    Util::error('`password` is invalid');
}

$account_service = $app->getAccountService();

if ($account_service->checkPassword($account, $password) === false) {
    Util::error('`account` or `password` is invalid',
                ErrorCode::ACCOUNT_OR_PASSWORD_INVALID);
}

$account_info = $account_service->getAccountInfoByAccount($account);
if ($account_info === false) {
    Util::error('`account` is invalid',
                ErrorCode::UNKNOWN);
}
$old_name = $account_info['name'];
if ($old_name != '') {
    Util::error('`realname` has record',
                ErrorCode::UNKNOWN);
}

$result = $account_service->updateRealname($account, $name, $id_num);
if ($result === false) {
    Util::error('update realname failed');
}

Util::response(array(
    'result' => array(
        'error_code' => 0,
    ),
));
