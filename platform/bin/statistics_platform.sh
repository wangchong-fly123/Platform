#!/bin/bash

bin_dir=`dirname $0`
proj_home=$bin_dir/..
platform_config_file=$proj_home/settings/config.ini
db_sql_file1=$proj_home/sql/statistics.sql

if [ ! -f $platform_config_file ]
then
    echo "$platform_config_file is missing"
    exit 1
fi

if [ ! -f $db_sql_file1 ]
then
    echo "$db_sql_file1 is missing"
    exit 1
fi

db_host=`grep dbHost $platform_config_file | awk -F'=' '{print $2}'`
db_port=`grep dbPort $platform_config_file | awk -F'=' '{print $2}'`
db_user=`grep dbUser $platform_config_file | awk -F'=' '{print $2}'`
db_password=`grep dbPwd $platform_config_file | awk -F'=' '{print $2}'`
db_name=`grep dbName $platform_config_file | awk -F'=' '{print $2}'`
echo "

use $db_name;

source $db_sql_file1;
" | mysql -h$db_host -P$db_port -u$db_user --password=$db_password

if [ $? -ne 0 ]
then
    exit 1
fi

exit 0
