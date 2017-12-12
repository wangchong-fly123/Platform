<?php
require('../../base/Config.php');
Config::init();
$service = new ZoneService();

$game = "";
$type = "";
$platform = "";

if (isset($_GET["game"]) === false
    || isset($_GET["type"]) === false
    || isset($_GET["platform"]) === false) {

    if (isset($_POST["game"]) === false
        || isset($_POST["type"]) === false
        || isset($_POST["platform"]) === false) {

        $service->error("required parameter missing", -1);
    } else {
        $game = $_POST["game"];
        $type = $_POST["type"];
        $platform = $_POST["platform"];
    }

} else {
    $game = $_GET["game"];
    $type = $_GET["type"];
    $platform = $_GET["platform"];
}

if(!is_numeric($game) || !is_numeric($type))
{
    $service->error("parameter is invalid", 1);
}
$service->init();

$array = $service->getBriefZoneInfo($game, $type, $platform);
if (count($array)) {
    echo $array;
} else {
    $service->error("platform is invalid or serverlist is empty", 2);
}
