<?php

require '../../lib/Config.php';
Config::init();
Util::setErrorCallback('Util::ClientErrorCallback');

if (isset($_POST['mobile_phone']) === false) {
    Util::error('`mobile_phone` is required');
}
if (isset($_POST['captcha_text']) === false) {
    Util::error('`captcha_text` is required');
}

$mobile_phone = $_POST['mobile_phone'];
$captcha_text = $_POST['captcha_text'];

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
$account_info = $account_service->getAccountInfoByPhone($mobile_phone);
if ($account_info === false) {
    Util::error('`mobile_phone` is invalid',
                ErrorCode::NOT_BIND_MOBILE_PHONE);
}
$uid = $account_info['uid'];

// send mobile message code
$message_code = $auth_service->generateResetPasswordCode($uid);
$mobile_service->sendResetPasswordMessageCode($mobile_phone, $message_code);

Util::response(array(
    'result' => array(
        'error_code' => 0,
    ),
));
