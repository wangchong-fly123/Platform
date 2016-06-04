<?php

require '../../lib/Config.php';
Config::init();
Util::setErrorCallback('Util::ClientErrorCallback');

$app = new ServerApp();
if ($app->checkRequestValid($_SERVER, $_POST) === false) {
    Util::error('request invalid');
}

if (isset($_POST['password']) === false) {
    Util::error('`password` is required');
}

$password = $_POST['password'];

// check password
if (preg_match('/^[0-9a-f]{40}$/', $password) !== 1) {
    Util::error('`password` is invalid');
}

$account_service = $app->getAccountService();

// generate account
$gen_account_success = false;
for ($i = 0; $i < 10; ++$i) {
    $account = 'guest'.sprintf(sprintf("%%0%dd", 9),
        mt_rand(0, 999999999));
    if ($account_service->checkAccountExist($account) === false) {
        $gen_account_success = true;
        break;
    }
}
if ($gen_account_success === false) {
    Util::error('generate account failed',
        ErrorCode::GENERATE_ACCOUNT_FAILED);
}

$uid = $account_service->createAccount($account, $password,
    AccountType::GUEST, RegisterType::GUEST);
if ($uid === false) {
    Util::error('`account` duplicated',
        ErrorCode::ACCOUNT_DUPLICATED);
}

Util::response(array(
    'result' => array(
        'error_code' => 0,
        'uid' => $uid,
        'account' => $account,
    ),
));
