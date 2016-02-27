<?php
require('base/Config.php');
Config::init();
$service = new ZoneService();

if (isset($_POST["game"]) === false
    || isset($_POST["type"]) === false
    || isset($_POST["platform"]) === false)
{
    $service->error("zoneinfo", 1);
}
$game = $_POST["game"];
$type = $_POST["type"];
$platform = $_POST["platform"];
if(!is_numeric($game) || !is_numeric($type))
{
    $service->error("zoneinfo", 2);
}
$service->init();
$array = $service->getZoneInfo($game, $type, $platform);
if (count($array)) {
    $service->response(array("zoneinfo" => $array));
} else {
    $service->error("zoneinfo", 3);
}