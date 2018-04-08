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

# php-phaclon
    git clone --depth=1 git://github.com/phalcon/cphalcon.git
    git checkout phalcon-v2.0.9
    git clean -xdf
    cd build
    ./install # remove make install
    cp build/64bits/modules/phalcon.so /usr/lib64/php/modules
    echo "extension=phalcon.so" >> /etc/php.d/phalcon.ini
```

## Ubuntu Env Settings
```

# php-phalcon

    sudo apt-add-repository ppa:phalcon/stable
    sudo apt-get update
    sudo apt-get install php5-phalcon
    sudo apt-get install php5-cli php5-curl php5-readline  php5-sqlite nginx php5-fpm 
```

## Edit Your Config and Start Server
```
cd settings
# copy config
    ./copy_conf.sh
# generate ssl key-pair
    ./gen_ssl_key.sh

cd bin
./start.sh
```
