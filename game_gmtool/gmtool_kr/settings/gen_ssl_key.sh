#!/bin/bash

if [ -f ca.key ]
then
    printf "regenerate ssl key? [n/Y]: "
    read opt
    if [ "$opt" != "Y" ]
    then
        exit 0
    fi
fi

# generate ca key
openssl genrsa -out ca.key 4096
openssl req -new -x509 -days 365 -key ca.key -out ca.crt \
        -subj "/CN=enjoymi.com"

# generate server key
openssl genrsa -out server.key 4096
openssl req -new -key server.key -out server.csr \
        -subj "/CN=ssl.enjoymi.com"
# sign server key
openssl x509 -req -days 365 -in server.csr -CA ca.crt -CAkey ca.key \
             -set_serial 01 -out server.crt

# generate client key
openssl genrsa -out client.key 4096
openssl req -new -key client.key -out client.csr \
        -subj "/CN=client.enjoymi.com"
# sign client key
openssl x509 -req -days 365 -in client.csr -CA ca.crt -CAkey ca.key \
             -set_serial 02 -out client.crt
# convert client key to pkcs
openssl pkcs12 -export -clcerts -passout pass:12345678 \
               -in client.crt -inkey client.key -out client.p12
