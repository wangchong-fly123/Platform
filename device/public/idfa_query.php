<?php

require '../lib/Config.php';
Config::init();
Util::setErrorCallback('Util::ClientErrorCallback');

$app = new ServerApp();
if (isset($_POST['bundleid']) === false) {
    Util::error('`bundleid` is required');
}
if (isset($_POST['idfa_list']) === false) {
    Util::error('`idfa_list` is required');
}

$bundleid = $_POST['bundleid'];
$idfa_list = $_POST['idfa_list'];
$idfa_array = explode(",", $idfa_list, 1000);
$result_array = array();

$dbh = $app->getDBHandler();
foreach ($idfa_array as $idfa) {
    $sth = $dbh->prepare(
        'select `device_id` from `tbl_device` '.
        'where `idfa` = :idfa limit 1'
    );
    $sth->bindValue(':idfa', $idfa, PDO::PARAM_STR);
    
    if (@$sth->execute() === false) {
        $result_array[$idfa] = "0";
    } else {
        $ret = $sth->fetch(PDO::FETCH_ASSOC);
        if ($ret == false) {
            $result_array[$idfa] = "0";
        } else {
            $result_array[$idfa] = "1";
        }
    }
}

Util::response($result_array);
