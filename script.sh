#!/bin/bash
# Author: Miroslaw Wiacek

echo -e "\033[1;38;5;118mBSK lab6 fix by Mirek Wiacek B)\033[0m"

echo -e "\033[1;36m>>>>Installing dependencies...\033[0m"
apt-get install pkg-config libnl-3-dev libnl-genl-3-dev asleap

echo -e "\033[1;36m>>>>Installing OpenSSL...\033[0m"
apt-get install libssl-dev
apt-get install libssl1.0-dev

# ensure root
if [ "$EUID" -ne 0 ]
  then echo -e "\033[0;31mMialo byc \"sudo bash ./script.sh \" :|\033[0m"
  exit
fi

echo -e "\033[1;36m>>>>Patching OpenSSL...\033[0m"
sed -i 's/MinProtocol = TLSv1.\b[0-9]\{1\}\b/MinProtocol = TLSv1.0/g'  '/etc/ssl/openssl.cnf'

ver=$(cat /etc/ssl/openssl.cnf |  awk '/MinProtocol/ {print $3}')

if [ "$ver" = "TLSv1.0" ]; then
        echo -e "\033[1;32m>>>>OpenSSL patched correctly!\033[0m"
else
        echo -e "\033[1;31m>>>>Something went wrong!\033[0m"
        echo $(cat /etc/ssl/openssl.cnf | grep MinProtocol)
fi
