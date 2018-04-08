<?php

require '../lib/Config.php';
Config::init();

function accountResponse($ret, $has_passport = '', $uid = '')
{
    Util::response(array(
        'result' => array(
        'success' => $ret,
        'has_passport' => $has_passport,
        'uid' => $uid,
        ),
    ));
}

if (isset($_POST['phone']) === false) {
    Util::error('`phone` is required');
}

$phone = $_POST['phone'];

$app = new ServerApp();
$service = $app->getRoleAccountService();

$pre_check = $service->checkPhoneHasChanged($phone);
if ($pre_check) {
    accountResponse(false);
}
$is_bind = $service->checkHasBindPhone($phone);
if (false == $is_bind) {
   accountResponse(false);
}

$has_passport = $service->checkHasEnjoymiPassport($phone);
if (false == $has_passport) {
    accountResponse(true);
} else {
    accountResponse(true, $has_passport['account'], $has_passport['uid']);
}
