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

// send mobile message code
$message_code = $auth_service->generateMessageLoginCode($mobile_phone);
$mobile_service->sendMessageLoginMessageCode($mobile_phone, $message_code);

Util::response(array(
    'result' => array(
        'error_code' => 0,
    ),
));
