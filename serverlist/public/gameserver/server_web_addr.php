<?php
require('../../base/Config.php');
Config::init();
$service = new ZoneService();

$server_id = "";
$platform = "";

if (isset($_GET["server_id"]) === false
    || isset($_GET["platform"]) === false) {

    if (isset($_POST["server_id"]) === false
        || isset($_POST["platform"]) === false) {

        $service->error("required parameter missing", -1);
    } else {
        $server_id = $_POST["server_id"];
        $platform = $_POST["platform"];
    }

} else {
    $server_id = $_GET["server_id"];
    $platform = $_GET["platform"];
}

if(!is_numeric($server_id))
{
    $service->error("parameter is invalid", 1);
}
$service->init();

$slave_url = $service->getZoneWebInfo($server_id, $platform);
$url = rtrim($slave_url, '/');
$service->response($url);
