#!/usr/bin/php
<?php
if ($argc != 2)
{
    die("useage: ./tablename.php [account_name]\n");
}
require('base/Config.php');
Config::init();
$account = $argv[1];
$account = strtoupper($account);
$table_name = Common::getRealTableName(Common::getHashCode($account));
echo $table_name."\n";

