#!/bin/bash

bin_dir=`dirname $0`
proj_home=$bin_dir/..
config_file=$proj_home/settings/config.ini
db_sql_file=$proj_home/settings/sql/gmdb.sql

if [ ! -f $config_file ]
then
    echo "$config_file is missing"
    exit 1
fi

if [ ! -f $db_sql_file ]
then
    echo "$db_sql_file is missing"
    exit 1
fi

db_host=$(sed -rn 's/^\s*host\s*=\s*(.*)/\1/p' $config_file)
db_port=$(sed -rn 's/^\s*port\s*=\s*(.*)/\1/p' $config_file)
db_name=$(sed -rn 's/^\s*dbname\s*=\s*(.*)/\1/p' $config_file)
db_user=$(sed -rn 's/^\s*username\s*=\s*(.*)/\1/p' $config_file)
db_password=$(sed -rn 's/^\s*password\s*=\s*(.*)/\1/p' $config_file)

echo "
set names utf8;
DROP DATABASE IF EXISTS $db_name;
CREATE DATABASE $db_name CHARACTER SET utf8 COLLATE utf8_bin;
use $db_name;
source $db_sql_file;
" | mysql -h$db_host -P$db_port -u$db_user --password=$db_password

if [ $? -ne 0 ]
then
    exit 1
fi

exit 0
