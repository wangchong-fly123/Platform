#!/bin/bash

bin_dir=`dirname $0`
proj_home=$bin_dir/..
platform_config_file=$proj_home/settings/config.ini
batch_id=$1
if [ $# != 1 ]
then
    echo "usage: $0 [batch_id]"
    exit 1
fi

if [ ! -f $platform_config_file ]
then
    echo "$platform_config_file is missing"
    exit 1
fi

if [ $batch_id -le 0 ]
then
    echo "usage: $0 [batch_id]"
    echo "$batch_id must be great than 0"
    exit 1
fi

db_host=`grep dbHost $platform_config_file | awk -F'=' '{print $2}'`
db_port=`grep dbPort $platform_config_file | awk -F'=' '{print $2}'`
db_user=`grep dbUser $platform_config_file | awk -F'=' '{print $2}'`
db_password=`grep dbPwd $platform_config_file | awk -F'=' '{print $2}'`
db_name=`grep dbName $platform_config_file | awk -F'=' '{print $2}'`
echo "

use $db_name;
delete from tbl_giftcode_public where batch_id=$batch_id;
delete from tbl_giftcode_unique where batch_id=$batch_id;
" | mysql -h$db_host -P$db_port -u$db_user --password=$db_password

rm $bin_dir/sqlcode/giftcode_*_${batch_id}.sql -rf
rm $proj_home/output/giftcode_*_${batch_id}.txt -rf

if [ $? -ne 0 ]
then
    exit 1
fi

exit 0
