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
    common_android)
    table_data_file=$base_path/serverlist/tbl_zoneinfo_common_android.txt;;  
    appstore_ios)
    table_data_file=$base_path/serverlist/tbl_zoneinfo_appstore_ios.txt;;  
    escape_ios)
    table_data_file=$base_path/serverlist/tbl_zoneinfo_escape_ios.txt;;  
    *)
    echo "$0 [0 | common_android | appstore_ios | escape_ios ]" 
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

set names utf8;
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
