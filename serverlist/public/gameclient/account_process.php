<?php
require('../../base/Config.php');
Config::init();
$service = new AccountService();
$service->init();

$account = "";

if (isset($_GET["account"]) === false) {
    if (isset($_POST["account"]) === false) {

        echo -1;
        exit();
    } else {
        $account = $_POST["account"];
    }

} else {
    $account = $_GET["account"];
}

$arr = explode("_", $account);
if (count($arr) != 2 && count($arr) != 3) {
    echo -1;
    exit();
}

$account = $arr[0].'_'.$arr[1];

$server_list = $service->getAccountInfo($account);
$service->response(array('self_server' => $server_list));
