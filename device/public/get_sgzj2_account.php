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

$game_id = 2;

if (isset($_GET['game']) !== false) {
    $game_id = $_GET['game'];
}

$device = $_GET['device'];
$account_array = array();

$dbh = $app->getDBHandler();
$sth = $dbh->prepare(
    'select `uid` from `tbl_sgzj2_device` '.
    'where `device_id` = :device '.
    'and `game_id` = :game_id limit 20'
);
$sth->bindValue(':device', $device, PDO::PARAM_STR);
$sth->bindValue(':game_id', $game_id, PDO::PARAM_STR);

if (@$sth->execute() === false) {
    accountResponse(-1, $account_array);
}

$result = $sth->fetchAll(PDO::FETCH_ASSOC);
foreach ($result as $info) {
    $uid = $info['uid'];
    $ret = $app->signedRequest(
        'passport.enjoymi.com',
        '08bf3a057ed1cc89a6e73e3ef880f0de4cf8eb363865e71f4f29c88deade9578',
        '/v2/get_account_info_by_uid.php',
        array(
            'uid' => $uid,
    ), 'post');
    if ($ret == false) {
        continue;
    }
    array_push($account_array, $ret);
}

accountResponse(0, $account_array);
