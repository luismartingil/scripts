#!/bin/bash
#
# Bash script to install the jekyll.
# Author: luismartingil
# Year: 2015
#
# Centos friendly installation script

SOURCES_PATH=/usr/local/src/jekyll_installation

install_repo() {
    curl -O http://linuxsoft.cern.ch/cern/scl/slc6-scl.repo
    sudo mv slc6-scl.repo /etc/yum.repos.d/
    sudo rpm --import http://ftp.mirrorservice.org/sites/ftp.scientificlinux.org/linux/scientific/51/i386/RPM-GPG-KEYs/RPM-GPG-KEY-cern
    sudo yum clean all
}

install_reqs() {
    sudo yum -y install devtoolset-3 gcc g++ gcc-c++
    sudo yum -y install patch readline readline-devel zlib zlib-devel
    sudo yum -y install libyaml-devel libffi-devel openssl-devel make bzip2
    sudo yum -y install autoconf automake libtool bison
}

install_ruby() {
    wget https://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.7.tar.gz
    tar -xvf ruby-2.1.7.tar.gz
    cd ruby-2.1.7/
    ./configure
    make --jobs=4
    sudo make install
}

install_rubygems () {
    wget https://rubygems.org/rubygems/rubygems-2.4.8.tgz
    tar -xvf rubygems-2.4.8.tgz
    cd rubygems-2.4.8/
    sudo -i ruby setup.rb
}

install_nodejs () {
    wget https://nodejs.org/dist/v4.2.1/node-v4.2.1.tar.gz
    tar -xvf node-v4.2.1.tar.gz
    cd node-v4.2.1/
    scl enable devtoolset-3 - <<EOF
    ./configure
    make --jobs=4
    sudo make install
EOF
}

install_jekyll () {
    sudo /usr/local/bin/gem install jekyll
}

sudo mkdir -p $SOURCES_PATH
sudo chown -R `whoami`:`whoami` $SOURCES_PATH

install_repo
install_reqs

pushd $SOURCES_PATH
install_ruby
install_rubygems
install_nodejs
install_jekyll
popd
