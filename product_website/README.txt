1.服务器nginx指向xxx/xxx/sanguo目录，并且nginx对sanguo目录要有可读写权限
2.mysql数据库导入sanguo_web.sql
3.修改sanguo/app/config/db.php,数据库配置写进去
4.nginx 增加rewrite 例子：

	location / {
                root /var/www/game/html/sanguo;
                index index.php;
                if (!-e $request_filename){
                  rewrite ^/(.*) /index.php last;
                }
                #ntry_files $uri $uri/ /index.php;
                #if (!-e $request_filename) {
                #    rewrite . /index.php last;
                #}
        }
5.后台地址：http://xxxx/admin        username：admin      password：admin 
6.本产品使用的yii框架
7.需要安装mysql,nginx,php,php-fpm,php-cli,php-mbstring