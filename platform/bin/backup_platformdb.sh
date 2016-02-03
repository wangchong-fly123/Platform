#!/bin/bash

bin_dir=`dirname $0`
base_path=$(cd `dirname $0`; pwd)
proj_home=$bin_dir/..
platform_config_file=$proj_home/settings/config.ini
backup_date=$(date +%Y%m%d-%H)
data_file=${base_path}/dbbackup/${backup_date}.sql

if [ ! -f $platform_config_file ]
then
    echo "$platform_config_file is missing"
    exit 1
fi

db_host=`grep dbHost $platform_config_file | awk -F'=' '{print $2}'`
db_port=`grep dbPort $platform_config_file | awk -F'=' '{print $2}'`
db_user=`grep dbUser $platform_config_file | awk -F'=' '{print $2}'`
db_password=`grep dbPwd $platform_config_file | awk -F'=' '{print $2}'`
db_name=`grep dbName $platform_config_file | awk -F'=' '{print $2}'`
echo "

use $db_name;
" | mysqldump -h$db_host -P$db_port -u$db_user --password=$db_password \
    $db_name > $data_file

if [ $? -ne 0 ]
then
    exit 1
fi

exit 0
