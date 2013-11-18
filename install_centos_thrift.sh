#!/bin/bash
#
# Bash script to install thrift library in Centos.
# Author: luismartingil
# Year: 2013
#
# Centos installation script

# Some dependencies I usually install
sudo yum install -y boost libevent libevent-devel automake.noarch libtool flex bison ustr-devel libgudev1-devel NetworkManager-glib-devel ustr-devel pm-utils-devel libgudev1-devel openssl-devel openssl-static ruby-static ruby-devel ruby-libs ruby perl-Carp-Clan rubygem-rake python-devel gstreamer-python-devel dbus-python-devel python-twisted perl-core php php-cli glib2 glib malaga automake bison bison-devel gfs2-utils doxygen glib2 automake libtool flex bison pkgconfig gcc-c++ boost-devel libevent-devel zlib-devel python-devel ruby-devel

# Getting thrift lib and installing it
cd; wget http://apache.mirrorcatalogs.com/thrift/0.7.0/thrift-0.7.0.tar.gz
cd; sudo tar -zxvf thrift-0.7.0.tar.gz -C /usr/local/src
cd /usr/local/src/thrift-0.7.0
sudo chmod uog+x configure
sudo ./configure --without-csharp --without-java --without-erlang --without-perl --without-php --without-php_extension --without-ruby --without-haskell --with-python --with-cpp --with-c_glib
sudo make
sudo make install

echo 'thrift is installed in /usr/local/lib, make sure it exists'