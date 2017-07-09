<?php

require '../../lib/Config.php';
Config::init();
Util::setErrorCallback('Util::ClientErrorCallback');

$app = new ServerApp();
if ($app->checkRequestValid($_SERVER, $_POST) === false) {
    Util::error('request invalid');
}

$name = '';
$id_num = '';

if (isset($_POST['account']) === false) {
    Util::error('`account` is required');
}
if (isset($_POST['password']) === false) {
    Util::error('`password` is required');
}
if (isset($_POST['name'])) {
    $name = $_POST['name'];
}
if (isset($_POST['id_num'])) {
    $id_num = $_POST['id_num'];

    // check id_num
    if (preg_match('/^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/', $id_num) !== 1) {
        Util::error('`id_num` is invalid');
    }
}

$account = $_POST['account'];
$password = $_POST['password'];

// check account
if (preg_match('/^[a-zA-Z]\w{5,19}$/', $account) !== 1) {
    Util::error('`account` is invalid');
}

// check password
if (preg_match('/^[0-9a-f]{40}$/', $password) !== 1) {
    Util::error('`password` is invalid');
}

$account_service = $app->getAccountService();

$uid = $account_service->createAccount($account, $password,
    AccountType::NORMAL, RegisterType::QUICK,
    $name, $id_num);
if ($uid === false) {
    Util::error('`account` duplicated',
        ErrorCode::ACCOUNT_DUPLICATED);
}

Util::response(array(
    'result' => array(
        'error_code' => 0,
        'uid' => $uid,
    ),
));
