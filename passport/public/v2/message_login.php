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
if (isset($_POST['message_code']) === false) {
    Util::error('`message_code` is required');
}
if (isset($_POST['password']) === false) {
    Util::error('`password` is required');
}

$mobile_phone = $_POST['mobile_phone'];
$message_code = $_POST['message_code'];
$password = $_POST['password'];

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

if ($auth_service->checkMessageLoginCode(
        $mobile_phone, $message_code) === false) {
    $auth_service->addFailedMessageLoginCodeTimes($mobile_phone);

    Util::error('`message_code` is invalid',
                ErrorCode::MESSAGE_CODE_INVALID);
}

$account_info = $account_service->getAccountInfoByPhone($mobile_phone);

$uid = '';
$account_type = '';
if ($account_info === false) {
    $account = '';

    // generate account
    $gen_account_success = false;
    for ($i = 0; $i < 20; ++$i) {
        $account = 'enjoymi'.sprintf(sprintf("%%0%dd", 9),
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

    // create account
    $uid = $account_service->createAccount($account, $password,
        AccountType::NORMAL, RegisterType::MESSAGE);
    if ($uid === false) {
        Util::error('`account` duplicated',
            ErrorCode::ACCOUNT_DUPLICATED);
    }

    // bind mobile phone
    if ($account_service->bindMobilePhone($account, $mobile_phone) == false) {
        Util::error('`mobile_phone` duplicated',
            ErrorCode::MOBILE_PHONE_DUPLICATED);
    }

    $account_type = AccountType::NORMAL;
} else {
    $uid = $account_info['uid'];
    $account_type = $account_info['account_type'];
    $account = $account_info['account'];
    $password = $account_info['password'];
}

$auth_service->clearMessageLoginCode($mobile_phone);

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
        'bind_phone' => 1,
        'phone_num' => $mobile_phone,
        'account' => $account,
        'password' => $password,
    ),
));
