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
    1.3 如果需要哪些服务器列表，请填写 serverlist/tbl_zoneinfo*.txt
        文件,每列数据格式以"\t"分割
    1.4 运行./add_serverlist.sh 添加相应的参数完成服务器列表数据添加
        ex: ./add_serverlist.sh xy_ios
            给tbl_zoneinfo_xy_ios表中添加了serverlist/tbl_zoneinfo_xy_ios.txt
            文件中的所有数据
    1.5 最后可以运行 ./show_serverlist.sh xy_ios 查看xy的ios渠道服务器列表
2.添加服务器列表
    2.1 比如xy平台的安卓渠道需要新开一个服务器
        2.1.1 在serverlist/tbl_zoneinfo_xy_android.txt中写入一行数据(有且只有一条)
        2.1.2 运行 ./add_serverlist.sh xy_android
    2.2 最后可以运行 ./show_serverlist.sh xy_android 查看xy的android渠道服务器列表
```
##AnySDK 登陆
```
SGZJ_APP->SDK_SERVER:1请求 token
SDK_SERVER-->SGZJ_APP:2返回 token
SGZJ_APP->GAME_CENTER_SERVER:3 check token
GAME_CENTER_SERVER->ANYSDK_SERVER:4 forward check token
ANYSDK_SERVER->SDK_SERVER:5 forward check token
SDK_SERVER->ANYSDK_SERVER:6 返回 check token
ANYSDK_SERVER->GAME_CENTER_SERVER:7 返回 check token
GAME_CENTER_SERVER-->SGZJ_APP: 8 返回 check token
SGZJ_APP->SGZJ_SLAVESERVER: 9 check game token
SGZJ_SLAVESERVER->GAME_CENTER_SERVER: 10 check game token
GAME_CENTER_SERVER->SGZJ_SLAVESERVER: 11 返回 check game token
SGZJ_SLAVESERVER-->SGZJ_APP:12 返回 check game token
SGZJ_APP->SGZJ_SOCIALSERVER: 13 请求进入游戏
```
![image](https://github.com/wangchong-fly123/Platform/raw/master/gamecenter/anysdk_login.jpg)
##AnySDK 支付
```
APP->AnySDKServer:请求订单号
AnySDKServer-->APP:返回订单号
APP->SDKServer:请求支付
SDKServer-->APP:同步支付结果通知
SDKServer->AnySDKServer:异步支付结果通知
AnySDKServer->SDKServer:ok响应
AnySDKServer->GameCenterServer:通知支付成功
GameCenterServer->SlaveServer:通知支付成功
SlaveServer->SocialServer:通知支付成功发放道具
SocialServer-->APP:notify charge ok,object info
SlaveServer-->GameCenterServer:ok响应
GameCenterServer-->AnySDKServer:ok响应
```
![image](https://github.com/wangchong-fly123/Platform/raw/master/gamecenter/anysdk_pay.jpg)
