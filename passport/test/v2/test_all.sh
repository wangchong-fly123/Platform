#!/bin/bash

if [ $# -ne 1 ]
then
    echo "usage `basename $0` <account>"
    exit 1
fi

account=$1

# account service
echo "guest_register"
./guest_register.php

echo "generate_account"
./generate_account.php

echo "quick_register"
./quick_register.php $account

echo "change_password"
./change_password.php $account 1 2
./change_password.php $account 2 1

# login service
echo "check_login"
./check_login.php $account

echo "login"
./login.php $account

exit 0
