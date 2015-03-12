#!/bin/bash
#
# Bash script to install the a redis instance.
# Author: luismartingil
# Year: 2015
#
# Centos installation script


NAME=redis
VER=2.8.9
NAME_COMP=NAME-VER
SRC=http://download.redis.io/releases/$NAME_COMP.tar.gz
 
# Installing some stuff
sudo yum groupinstall -y "Development tools"

wget $SRC
tar xzf $NAME_COMP.tar.gz
cd $NAME_COMP

make
make test
make install

cd utils
./install_server.sh

# Starting
service redis_6379 start
 
