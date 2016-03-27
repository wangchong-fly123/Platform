<?php

require('../base/Config.php');
Config::init();
$service = new TokenService();
$service->init();

if (isset($_POST["account"]) === false 
    || isset($_POST["token"]) === false
    || isset($_POST["game"]) === false) {
    $service->error("login", 1);
}
$account = $_POST["account"];
$game = $_POST["game"];
$token = $_POST["token"];
if (!is_numeric($game)) {
    $service->error("login", 2);
}
if ($service->checkToken($account, $game, $token)) {
    $service->error("login", 0);
} else {
    $service->error("login", -1);
}
