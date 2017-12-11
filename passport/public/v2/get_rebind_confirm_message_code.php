<?php

require '../../lib/Config.php';
Config::init();
Util::setErrorCallback('Util::ClientErrorCallback');

if (isset($_POST['old_mobile_phone']) === false) {
    Util::error('`old_mobile_phone` is required');
}
if (isset($_POST['mobile_phone']) === false) {
    Util::error('`mobile_phone` is required');
}
if (isset($_POST['captcha_text']) === false) {
    Util::error('`captcha_text` is required');
}

$old_mobile_phone = $_POST['old_mobile_phone'];
$mobile_phone = $_POST['mobile_phone'];
$captcha_text = $_POST['captcha_text'];

// check mobile phone
if (preg_match('/^[0-9]{11,}$/', $old_mobile_phone) !== 1) {
    Util::error('`old_mobile_phone` is invalid');
}

// check mobile phone
if (preg_match('/^[0-9]{11,}$/', $mobile_phone) !== 1) {
    Util::error('`mobile_phone` is invalid');
}

$app = new ServerApp();
$auth_service = $app->getAuthService();
$mobile_service = $app->getMobileService();
$account_service = $app->getAccountService();

// check captcha text
if ($auth_service->checkAndClearCaptchaText($captcha_text) === false) {
    Util::error('`captcha_text` is invalid',
                ErrorCode::CAPTCHA_TEXT_INVALID);
}

// check phone account
$account_info = $account_service->getAccountInfoByPhone($old_mobile_phone);
if ($account_info === false) {
    Util::error('`old_mobile_phone` is invalid',
                ErrorCode::NOT_BIND_MOBILE_PHONE);
}

// check phone account
$new_account_info = $account_service->getAccountInfoByPhone($mobile_phone);
if ($new_account_info != false) {
    Util::error('`mobile_phone` is invalid',
                ErrorCode::MOBILE_PHONE_DUPLICATED);
}

$uid = $account_info['uid'];
if ($auth_service->checkRebindFlag($uid) === false) {
    Util::error('`old_mobile_phone` is invalid',
                ErrorCode::CHANGE_PHONE_TIMEOUT);
}

// send mobile message code
$message_code = $auth_service->generateRebindConfirmCode($uid);
$mobile_service->sendRebindConfirmMessageCode($mobile_phone, $message_code);

Util::response(array(
    'result' => array(
        'error_code' => 0,
    ),
));
