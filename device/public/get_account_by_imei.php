<?php

require '../lib/Config.php';
Config::init();
Util::setErrorCallback('Util::ClientErrorCallback');

function accountResponse($ret, $account_array)
{
    Util::response(array(
        'result' => array(
        'error_code' => $ret,
        'account' => $account_array,
        ),
    ));
}

$app = new ServerApp();
if (isset($_GET['imei']) === false) {
    Util::error('`imei` is required');
}

$game_id = 1;

if (isset($_GET['game']) !== false) {
    $game_id = $_GET['game'];
}

$imei = $_GET['imei'];
$platform = $_GET['platform'];
$account_array = array();

$dbh = $app->getDBHandler();
$sth = $dbh->prepare(
    'select `account` from `tbl_device` '.
    'where `imei` = :imei '.
    'and `game_id` = :game_id '
);
$sth->bindValue(':imei', $imei, PDO::PARAM_STR);
$sth->bindValue(':game_id', $game_id, PDO::PARAM_STR);

if (@$sth->execute() === false) {
    accountResponse(-1, $account_array);
}

while ($result = $sth->fetch(PDO::FETCH_ASSOC)) {
    $account_array[] = $result['account'];
}

accountResponse(0, $account_array);
