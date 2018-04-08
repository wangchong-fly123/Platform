## Ubuntu Env Settings
```
# install packages
sudo apt-get install nginx php5-fpm php5-mysql php5-redis php5-gd

# change nginx settings
vi /etc/nginx/nginx.conf
worker_processes 16;

# change php5-fpm settings
vi /etc/php5/fpm/pool.d/www.conf
pm.max_children = 32
pm.start_servers = 16
pm.min_spare_servers = 12
pm.max_spare_servers = 32
```
CentOS Env Settings
```
# install packages
yum install nginx php5-fpm php5-mysql php5-redis php5-curl

# change nginx settings
vi /etc/nginx/nginx.conf
worker_processes 16;

```
