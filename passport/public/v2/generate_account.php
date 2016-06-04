<?php

require '../../lib/Config.php';
Config::init();
Util::setErrorCallback('Util::ClientErrorCallback');

$app = new ServerApp();
if ($app->checkRequestValid($_SERVER, $_POST) === false) {
    Util::error('request invalid');
}

$account_service = $app->getAccountService();

$gen_account_success = false;
for ($i = 0; $i < 10; ++$i) {
    $account = 'sgzj'.sprintf(sprintf("%%0%dd", 9),
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

Util::response(array(
    'result' => array(
        'error_code' => 0,
        'account' => $account,
    ),
));
