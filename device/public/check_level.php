<?php

require '../lib/Config.php';
Config::init();
Util::setErrorCallback('Util::ClientErrorCallback');

function reportResponse($ret)
{
    Util::response(array(
        'result' => array(
        'success' => $ret,
        ),
    ));
}

$app = new ServerApp();
if (isset($_GET['channel']) === false) {
    Util::error('`channel` is required');
}

$channel = '';
$uid = '';

if (isset($_GET['uid']) !== false) {
    $uid = $_GET['uid'];
}

$channel = $_GET['channel'];

$dbh = $app->getDBHandler();
$sth = $dbh->prepare(
    'select `level` from `tbl_sgzj2_account` '.
    'where `channel` = :channel '.
    'and `uid` = :uid '
);
$sth->bindValue(':channel', $channel, PDO::PARAM_STR);
$sth->bindValue(':uid', $uid, PDO::PARAM_STR);

if (@$sth->execute() === false) {
    Util::error('db select failed');
}

$ret = $sth->fetch(PDO::FETCH_ASSOC);
if ($ret === false) {
    reportResponse(false);
}

if ($ret['level'] > 48) {
    reportResponse(true);
}

reportResponse(false);
