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
$level = '';

if (isset($_GET['uid']) !== false) {
    $uid = $_GET['uid'];
}
if (isset($_GET['level']) !== false) {
    $level = $_GET['level'];
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
if ($ret !== false) {
    if ($ret['level'] < $level) {
        $sth = $dbh->prepare(
            'update `tbl_sgzj2_account` '.
            'set `level` = :level '.
            'where `channel` = :channel '.
            'and `uid` = :uid '
        );
        $sth->bindValue(':channel', $channel, PDO::PARAM_STR);
        $sth->bindValue(':uid', $uid, PDO::PARAM_STR);
        $sth->bindValue(':level', $level, PDO::PARAM_INT);
        
        if (@$sth->execute() === false) {
            Util::error('db insert failed');
        }

        reportResponse(true);
    } else {
        reportResponse(false);
    }
}

$sth = $dbh->prepare(
    'insert into `tbl_sgzj2_account`('.
    '`channel`, `uid`,`level` '.
    ') values ('.
    ':channel, :uid, :level)'
);
$sth->bindValue(':channel', $channel, PDO::PARAM_STR);
$sth->bindValue(':uid', $uid, PDO::PARAM_STR);
$sth->bindValue(':level', $level, PDO::PARAM_INT);

if (@$sth->execute() === false) {
    Util::error('db insert failed');
}

reportResponse(true);
