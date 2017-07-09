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
if (isset($_GET['password']) === false) {
    Util::error('`password` is required');
}
if (isset($_GET['new_password']) === false) {
    Util::error('`new_password` is required');
}

$account = $_GET['account'];
$password = $_GET['password'];
$new_password = $_GET['new_password'];

if ($password != $new_password) {
    Util::error('The password for the two input must be the same');
}

if ($password == '') {
    Util::error('password can not be empty');
}

$account_service = $app->getAccountService();

$result = $account_service->changePassword($account, $new_password);
if ($result === false) {
    Util::error('change password failed');
}

Util::response(array(
    'result' => array(
        'error_code' => 0,
    ),
));
