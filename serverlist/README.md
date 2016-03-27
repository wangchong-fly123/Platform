## CentOS Env Settings
```
# runtime packages
    yum install --enablerepo=remi \
        mysql mysql-server nginx \
        php-fpm php-pdo php-mysql php-xml php5-curl \

# dev packages
    yum install man gcc-c++ git
    yum install --enablerepo=remi \
        pcre-devel php-devel

1.首次部署
    1.1 配置settings/config.ini,设置数据库相关信息
    1.2 运行./recreate_platformdb.sh
    1.3 如果需要哪些服务器列表，请填写 serverlist/tbl_zoneinfo*.txt
        文件,每列数据格式以"\t"分割
    1.4 运行./add_serverlist.sh 添加相应的参数完成服务器列表数据添加
        ex: ./add_serverlist.sh xy_ios
            给tbl_zoneinfo_xy_ios表中添加了serverlist/tbl_zoneinfo_xy_ios.txt
            文件中的所有数据
    1.5 最后可以运行 ./show_serverlist.sh xy_ios 查看xy的ios渠道服务器列表
    1.6 设置canche目录权限
        chown apache:apache /opt/www/serverlist/bin/cache
        chmod -R 0755 /opt/www/serverlist/bin/cache
2.添加服务器列表
    2.1 比如xy平台的安卓渠道需要新开一个服务器
        2.1.1 在serverlist/tbl_zoneinfo_xy_android.txt中写入一行数据(有且只有一条)
        2.1.2 运行 ./add_serverlist.sh xy_android
    2.2 最后可以运行 ./show_serverlist.sh xy_android 查看xy的android渠道服务器列表
