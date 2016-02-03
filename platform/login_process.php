<?php
require('base/Config.php');
Config::init();
$service = new LoginService();
$service->init();

if (isset($_POST["username"]) === false 
    || isset($_POST["password"]) === false
    || isset($_POST["game"]) === false) {
    $service->error("login", 1);
}
$username = $_POST["username"];
$password = $_POST["password"];
$game = $_POST["game"];
if(!is_numeric($game)) {
    $service->error("login", 2);
}

error_log($username."-".$password."-".$game);

if ($service->login($username, $password, $game)) {
    $token_service = new TokenService();
    $token_service->init();
    $length = 16;
    $token = Common::createToken($length);
    $account = $username."_enjoymi";
    $token_service->writeToken($account, $game, $token);
    $service->error("login", "0,".$account.",".$token);
} else {
    $service->error("login", 4);
}
