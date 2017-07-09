#!/bin/bash

bin_dir=`dirname $0`
proj_home=$bin_dir/..
config_file=$proj_home/settings/config.ini
db_sql_file=$proj_home/settings/sql/patch/$1

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

printf "install db patch for platform db? [n/Y]: "
read opt
if [ "$opt" != "Y" ]
then
    exit 0
fi

# run backup_platformdb.sh first
bash $bin_dir/backup_platformdb.sh
if [ $? -ne 0 ]
then
    echo "run backup_platformdb.sh failed"
    exit 1
fi

db_host=$(grep '^\[db\]' -A 5 $config_file | grep '^host' | awk '{print $3}')
db_port=$(grep '^\[db\]' -A 5 $config_file | grep '^port' | awk '{print $3}')
db_name=$(grep '^\[db\]' -A 5 $config_file | grep '^name' | awk '{print $3}')
db_user=$(grep '^\[db\]' -A 5 $config_file | grep '^user' | awk '{print $3}')
db_password=$(grep '^\[db\]' -A 5 $config_file | grep '^password' | awk '{print $3}')

echo "
set names utf8;
use $db_name;
source $db_sql_file;
" | mysql -h$db_host -P$db_port -u$db_user --password=$db_password

if [ $? -ne 0 ]
then
    exit 1
fi

exit 0
