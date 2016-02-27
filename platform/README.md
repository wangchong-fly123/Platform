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
2.添加一款游戏
    读完这句话:每款游戏有一个唯一号,目前《三国战纪》"game=1",
    对应的登录token表tbl_tokencache0001
    如果新增一款游戏 game=2,
    需要新添加一张表tbl_tokencache0002(结构与tbl_tokencache0001相同)
    #run
    echo "CREATE TABLE tbl_tokencache0002 LIKE tbl_tokencache0001;" | mysql -uroot enjoymi_platform
