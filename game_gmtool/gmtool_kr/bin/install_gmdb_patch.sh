#!/bin/bash

bin_dir=`dirname $0`
proj_home=$bin_dir/..
config_file=$proj_home/settings/config.ini

if [ $# -ne 1 ]
then
    echo "usage: `basename $0` <db_patch_file>"
    exit 1
fi

db_patch_file=$proj_home/settings/sql/$1

if [ ! -f $config_file ]
then
    echo "$config_file is missing"
    exit 1
fi

if [ ! -f $db_patch_file ]
then
    echo "$db_patch_file is missing"
    exit 1
fi

db_host=$(sed -rn 's/^\s*host\s*=\s*(.*)/\1/p' $config_file)
db_port=$(sed -rn 's/^\s*port\s*=\s*(.*)/\1/p' $config_file)
db_name=$(sed -rn 's/^\s*dbname\s*=\s*(.*)/\1/p' $config_file)
db_user=$(sed -rn 's/^\s*username\s*=\s*(.*)/\1/p' $config_file)
db_password=$(sed -rn 's/^\s*password\s*=\s*(.*)/\1/p' $config_file)

echo "
use $db_name;
source $db_patch_file;
" | mysql -h$db_host -P$db_port -u$db_user --password=$db_password

if [ $? -ne 0 ]
then
    exit 1
fi

exit 0
