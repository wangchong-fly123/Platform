<?php
require('base/Config.php');
Config::init();
$service = new RegisterService();
$service->init();
if (isset($_POST["username"]) === false 
    || isset($_POST["password"]) === false
    || isset($_POST["regtype"]) === false) {
    $service->error("register", 1);
}
$user = $_POST["username"];
$psw = $_POST["password"];
$reg_type = $_POST["regtype"];
if ($user == "" || $psw == "" || $reg_type == "") {
    $service->error("register", 1);
}
if (!is_numeric($reg_type)) {
    $service->error("register", 1);
}
$service->register($user, $psw, $reg_type);
