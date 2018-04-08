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
if (isset($_GET['device']) === false) {
    Util::error('`device` is required');
}

$game_id = 1;

if (isset($_GET['game']) !== false) {
    $game_id = $_GET['game'];
}

$device = $_GET['device'];
$account_array = array();

$dbh = $app->getDBHandler();
$sth = $dbh->prepare(
    'select `account` from `tbl_device` '.
    'where `device_id` = :device '.
    'and `game_id` = :game_id '
);
$sth->bindValue(':device', $device, PDO::PARAM_STR);
$sth->bindValue(':game_id', $game_id, PDO::PARAM_STR);

if (@$sth->execute() === false) {
    accountResponse(-1, $account_array);
}

while ($result = $sth->fetch(PDO::FETCH_ASSOC)) {
    $account_array[] = $result['account'];
}

accountResponse(0, $account_array);
