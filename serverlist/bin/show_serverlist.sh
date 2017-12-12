#!/bin/bash

bin_dir=`dirname $0`
proj_home=$bin_dir/..
platform_config_file=$proj_home/settings/config.ini
table_name=tbl_zoneinfo

if [ ! -f $platform_config_file ]
then
    echo "$platform_config_file is missing"
    exit 1
fi

case $1 in 
    common_android)
    table_name=tbl_zoneinfo_common_android;;  
    appstore_ios)
    table_name=tbl_zoneinfo_appstore_ios;;  
    escape_ios)
    table_name=tbl_zoneinfo_escape_ios;;  
    android_papa)
    table_name=tbl_zoneinfo_android_papa;;  
    test)
    table_name=tbl_zoneinfo_test;;  
    *)
    echo "$0 [common_android | appstore_ios | escape_ios | android_papa |test ]" 
    exit 1;;
esac

db_host=`grep dbHost $platform_config_file | awk -F'=' '{print $2}'`
db_port=`grep dbPort $platform_config_file | awk -F'=' '{print $2}'`
db_user=`grep dbUser $platform_config_file | awk -F'=' '{print $2}'`
db_password=`grep dbPwd $platform_config_file | awk -F'=' '{print $2}'`
db_name=`grep dbName $platform_config_file | awk -F'=' '{print $2}'`
echo "

use $db_name;
set names utf8;
select * from $table_name;
" | mysql -h$db_host -P$db_port -u$db_user --password=$db_password

if [ $? -ne 0 ]
then
    exit 1
fi

exit 0
