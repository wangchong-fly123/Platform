#!/bin/bash

bin_dir=`dirname $0`
proj_home=$bin_dir/..
config_file=$proj_home/settings/config.ini
backup_file=$proj_home/data_backup/platformdb_$(date +%Y%m%d%H%M).gz

if [ ! -f $config_file ]
then
    echo "$config_file is missing"
    exit 1
fi

db_host=$(grep '^\[db\]' -A 5 $config_file | grep '^host' | awk '{print $3}')
db_port=$(grep '^\[db\]' -A 5 $config_file | grep '^port' | awk '{print $3}')
db_name=$(grep '^\[db\]' -A 5 $config_file | grep '^name' | awk '{print $3}')
db_user=$(grep '^\[db\]' -A 5 $config_file | grep '^user' | awk '{print $3}')
db_password=$(grep '^\[db\]' -A 5 $config_file | grep '^password' | awk '{print $3}')

mysqldump -h$db_host -P$db_port -u$db_user --password=$db_password $db_name | \
gzip -c > $backup_file

if [ $? -ne 0 ]
then
    exit 1
fi

exit 0
