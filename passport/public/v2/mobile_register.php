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

if (isset($_POST['mobile_phone']) === false) {
    Util::error('`mobile_phone` is required');
}
if (isset($_POST['password']) === false) {
    Util::error('`password` is required');
}
if (isset($_POST['message_code']) === false) {
    Util::error('`message_code` is required');
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

// check message code
if ($auth_service->checkAndClearMessageCode(
        $mobile_phone, $message_code) === false) {
    Util::error('`message_code` is invalid',
                ErrorCode::MESSAGE_CODE_INVALID);
}

$uid = $account_service->createAccount($mobile_phone, $password,
    AccountType::NORMAL, RegisterType::MOBILE,
    $name, $id_num);
if ($uid === false) {
    Util::error('`mobile_phone` is duplicated',
                ErrorCode::MOBILE_PHONE_DUPLICATED);
}

Util::response(array(
    'result' => array(
        'error_code' => 0,
        'uid' => $uid,
    ),
));
