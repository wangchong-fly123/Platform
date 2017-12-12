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

$server_list = $service->getAccountInfo($account);
$service->response($server_list);
