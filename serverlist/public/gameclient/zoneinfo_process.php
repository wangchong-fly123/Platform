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

        $service->error("zoneinfo", 1);
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
    $service->error("zoneinfo", 2);
}
$service->init();

$cache_service = new CacheService();
$cache_service->init();

$cache_info = $cache_service->getCache($platform);
$array = array();

if ($cache_info == false) {
    $array = $service->getZoneInfo($game, $type, $platform);
    if (count($array)) {
        $cache_service->writeCache($platform, serialize($array));
    }
} else {
    $array = unserialize($cache_info);
}

if (count($array)) {
    $service->response(array("zoneinfo" => $array));
} else {
    $service->error("zoneinfo", 3);
}
