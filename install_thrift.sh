#!/bin/bash
#
# Bash script to install the thrift library 0.7.
# Author: luismartingil
# Year: 2012
#
# Generic installation script

VER_TH=0.7.0
NAME=thrift-$VER_TH
WEB=http://apache.mirrorcatalogs.com/thrift/$VER_TH/$NAME.tar.gz

# Bash functions to install dependencies.
# Probably more deps than needed!
install_centos_req () {
    sudo yum install -y boost libevent libevent-devel automake.noarch libtool flex bison ustr-devel libgudev1-devel NetworkManager-glib-devel ustr-devel pm-utils-devel libgudev1-devel openssl-devel openssl-static ruby-static ruby-devel ruby-libs ruby perl-Carp-Clan rubygem-rake python-devel gstreamer-python-devel dbus-python-devel python-twisted perl-core php php-cli glib2 glib malaga automake bison bison-devel gfs2-utils doxygen glib2 automake libtool flex bison pkgconfig gcc-c++ boost-devel libevent-devel zlib-devel python-devel ruby-devel
}
install_debian_req () {
    sudo apt-get install libboost-dev libboost-test-dev libboost-program-options-dev libevent-dev automake libtool flex bison pkg-config g++ libssl-dev ruby-full ruby-dev librspec-ruby rake rubygems libdaemons-ruby libgemplugin-ruby mongrel python-dev python-twisted libbit-vector-perl php5-dev php5-cli libglib2.0-dev erlang-base erlang-eunit erlang-dev mono-gmcs libmono-dev libmono-system-web2.0-cil ghc6 cabal-install libghc6-binary-dev libghc6-network-dev libghc6-http-dev automake bison global doxygen libglib2.0-0 libboost-dev libboost-test-dev libboost-program-options-dev libevent-dev automake libtool flex bison pkg-config g++ libssl-dev libboost-dev automake libtool flex bison pkg-config g++
}

# Getting the OS information
ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
if [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Debian based distribution
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/redhat-release ]; then
    # Redhat based distribution
    OS=$(cut -d ' ' -f 1 /etc/system-release)
    VER=$(cut -d ' ' -f 3 /etc/system-release)
else
    OS=$(uname -s)
    VER=$(uname -r)
fi

# Some output information
echo $OS
echo $VER

# Checking OS
case $OS in
    *buntu*|*ebian*)
    echo 'OS Supported'
    install_debian_req
    ;;
    *red*|*entOS*)
	echo 'OS Supported'
	install_centos_req
	;;
    *)
	echo 'OS not supported'
	;;
esac

# Getting the lib
cd; wget $WEB
cd; sudo tar -zxvf $NAME.tar.gz -C /usr/local/src

# Compiling and installing the lib
cd /usr/local/src/$NAME ; sudo chmod uog+x configure
cd /usr/local/src/$NAME ; sudo ./configure --without-csharp --without-java --without-erlang --without-perl --without-php --without-php_extension --without-ruby --without-haskell --with-python --with-cpp --with-c_glib

# Lets go!
cd /usr/local/src/$NAME ; sudo make
cd /usr/local/src/$NAME ; sudo make install

echo 'thrift is installed in /usr/local/lib, make sure it exists'
echo '~~~~~~~~~~~~~~~~~~~~~~'
LS_CMD='ls -lrt /usr/local/lib'
echo $LS_CMD
$LS_CMD