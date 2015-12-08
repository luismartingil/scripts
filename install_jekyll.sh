#!/bin/bash
#
# Bash script to install the jekyll.
# Author: luismartingil
# Year: 2015
#
# Centos friendly installation script

SOURCES_PATH=/usr/local/src/

install_reqs() {
    sudo yum -y install gcc gcc-c++
    sudo yum -y install devtoolset-3
    sudo yum -y install gcc-c++ patch readline readline-devel zlib zlib-devel
    sudo yum -y install libyaml-devel libffi-devel openssl-devel make bzip2
    sudo yum -y install autoconf automake libtool bison iconv-devel
}

install_ruby() {
    VERSION=2.1.7
    pushd $SOURCES_PATH
    wget https://cache.ruby-lang.org/pub/ruby/2.1/ruby-$VERSION.tar.gz
    tar -xvf ruby-$VERSION.tar.gz
    cd ruby-$VERSION/
    ./configure
    make --jobs=4
    sudo make install
    popd
}

install_rubygems () {
    VERSION=2.4.8
    pushd $SOURCES_PATH
    wget https://rubygems.org/rubygems/rubygems-$VERSION.tgz
    tar -xvf rubygems-$VERSION.tgz
    cd rubygems-$VERSION/
    sudo -i ruby setup.rb
    popd
}

install_nodejs () {
    VERSION=4.2.1
    pushd $SOURCES_PATH
    wget https://nodejs.org/dist/v$VERSION/node-v$VERSION.tar.gz
    tar -xvf node-v$VERSION.tar.gz
    cd node-v$VERSION/
    ./configure
    make --jobs=4
    sudo make install
    popd    
}
