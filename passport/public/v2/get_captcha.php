<?php

require '../../lib/Config.php';
Config::init();

$captcha = new Captcha();
$captcha->build();

$app = new ServerApp();
$auth_service = $app->getAuthService();
$auth_service->setCaptchaText($captcha->getCaptchaText());

$captcha->sendImage();
