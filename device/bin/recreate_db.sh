#!/bin/bash

bin_dir=`dirname $0`
proj_home=$bin_dir/..
config_file=$proj_home/settings/config.ini
db_sql_file=$proj_home/settings/sql/db.sql

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

db_host=$(grep '^\[db\]' -A 5 $config_file | grep '^host' | awk '{print $3}')
db_port=$(grep '^\[db\]' -A 5 $config_file | grep '^port' | awk '{print $3}')
db_name=$(grep '^\[db\]' -A 5 $config_file | grep '^name' | awk '{print $3}')
db_user=$(grep '^\[db\]' -A 5 $config_file | grep '^user' | awk '{print $3}')
db_password=$(grep '^\[db\]' -A 5 $config_file | grep '^password' | awk '{print $3}')

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
