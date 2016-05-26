## CentOS Env Settings
```
# runtime packages
    yum install --enablerepo=remi \
        mysql mysql-server redis nginx \
        php-fpm php-pdo php-mysql php-xml php5-curl php-redis \

# dev packages
    yum install man gcc-c++ git
    yum install --enablerepo=remi \
        pcre-devel php-devel
# redis
    chkconfig --level 2345 redis on

1.首次部署
    1.1 配置settings/config.ini,设置数据库相关信息
    1.2 运行./recreate_platformdb.sh
