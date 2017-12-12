<?php
require('../../base/Config.php');
Config::init();
$service = new AccountService();
$service->init();

$account = '';
$server_id = '';
$server_length = 5;

if (isset($_GET['account']) === false ||
    isset($_GET['server_id']) === false) {
    $service->error('update', 1);

} else {
    $account = $_GET['account'];
    $server_id = $_GET['server_id'];
}

$result = $service->updateAccountInfo($account, $server_id);
echo $result;
