#!/bin/bash

bin_dir=`dirname $0`
base_path=$(cd `dirname $0`; pwd)
proj_home=$bin_dir/..
platform_config_file=$proj_home/settings/config.ini
table_data_file=$base_path/serverlist/tbl_zoneinfo.txt

if [ ! -f $platform_config_file ]
then
    echo "$platform_config_file is missing"
    exit 1
fi

case $1 in 
    0)
    ;;
    xy_android)
    table_data_file=$base_path/serverlist/tbl_zoneinfo_xy_android.txt;;  
    xy_ios)
    table_data_file=$base_path/serverlist/tbl_zoneinfo_xy_ios.txt;;  
    xy_escape)
    table_data_file=$base_path/serverlist/tbl_zoneinfo_xy_escape.txt;;  
    papa_android)
    table_data_file=$base_path/serverlist/tbl_zoneinfo_papa_android.txt;;  
    papa_test)
    table_data_file=$base_path/serverlist/tbl_zoneinfo_papa_test.txt;;  
    *)
    echo "$0 [0 | xy_android | xy_ios | xy_escape | papa_android | papa_test]" 
    exit 1;;
esac

if [ ! -f $table_data_file ]
then
    echo "$table_data_file is missing"
    exit 1
fi

db_host=`grep dbHost $platform_config_file | awk -F'=' '{print $2}'`
db_port=`grep dbPort $platform_config_file | awk -F'=' '{print $2}'`
db_user=`grep dbUser $platform_config_file | awk -F'=' '{print $2}'`
db_password=`grep dbPwd $platform_config_file | awk -F'=' '{print $2}'`
db_name=`grep dbName $platform_config_file | awk -F'=' '{print $2}'`
echo "

use $db_name;
" | mysqlimport -h$db_host -P$db_port -u$db_user --password=$db_password \
    $db_name $table_data_file

cache_file=$base_path/cache/*{$0}.txt
if [ -f $cache_file ]
then
    rm $cache_file -rf
fi

if [ $? -ne 0 ]
then
    exit 1
fi

exit 0
