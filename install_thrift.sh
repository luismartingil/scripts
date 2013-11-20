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

SRC=/usr/local/src/ # Placing thrift sources
LIB_DST=/usr/lib/ # Library dest folder.

# Bash functions to install dependencies.
# Probably more deps than needed!
install_centos_req () {
    sudo yum install -y automake libtool flex bison pkgconfig gcc-c++ boost-devel
    sudo yum install -y glib glib2 glib2-devel glibc glibc-devel glibc-common
    sudo yum groupinstall -y 'Development Tools'
    #sudo yum install automake libtool flex bison pkgconfig gcc-c++ boost-devel libevent-devel zlib-devel python-devel ruby-devel openssl-devel
    #sudo yum install -y boost libevent libevent-devel automake.noarch libtool flex bison ustr-devel libgudev1-devel ustr-devel pm-utils-devel libgudev1-devel openssl-devel openssl-static ruby-static ruby-devel ruby-libs ruby perl-Carp-Clan rubygem-rake python-devel gstreamer-python-devel dbus-python-devel python-twisted perl-core php php-cli glib2 glib malaga automake bison bison-devel gfs2-utils doxygen glib2 automake libtool flex bison pkgconfig gcc-c++ boost-devel libevent-devel zlib-devel ruby-devel
}
install_debian_req () {
    sudo apt-get install libboost-dev libboost-test-dev libboost-program-options-dev libevent-dev automake libtool flex bison pkg-config g++ libssl-dev ruby-full ruby-dev librspec-ruby rake rubygems libdaemons-ruby libgemplugin-ruby mongrel python-dev python-twisted libbit-vector-perl php5-dev php5-cli libglib2.0-dev erlang-base erlang-eunit erlang-dev mono-gmcs libmono-dev libmono-system-web2.0-cil ghc6 cabal-install libghc6-binary-dev libghc6-network-dev libghc6-http-dev automake bison global doxygen libglib2.0-0 libevent-dev automake libtool flex bison pkg-config g++ libssl-dev automake libtool flex bison pkg-config g++
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

# Assuming the home folder as the working directory
cd;

# Getting the lib
if [ ! -f $NAME.tar.gz ]; then
    cd; wget $WEB
else
    echo 'Cleaning old installation'
    cd $SRC$NAME ; sudo make uninstall
    cd $SRC$NAME ; sudo make clean
    echo 'Removing old thrift files'
    sudo rm -frv $SRC$NAME
fi

cd; sudo tar -zxvf $NAME.tar.gz -C /usr/local/src

# Compiling and installing the lib
cd $SRC$NAME ; sudo chmod uog+x configure
cd $SRC$NAME ; sudo ./configure --without-csharp --without-java --without-erlang --without-perl --without-php --without-php_extension --without-ruby --without-haskell --without-python --with-cpp --with-c_glib --libdir=$LIB_DST

# Lets go!
cd $SRC$NAME ; sudo make
cd $SRC$NAME ; sudo make install

# ldconfig creates the necessary links and cache to the most recent shared 
# libraries found in the directories specified on the command line
sudo ldconfig

echo '~~~~~~~~~~~~~~~~~~~~~~'

echo 'thrift is installed in '$LIB_DST
LS_CMD='ls -lrt '$LIB_DST' | grep thrift'
echo 'Executing: '$LS_CMD
$LS_CMD

echo 'thrift version'
echo '~~~~~~~~~~~~~~'
VER_CMD='thrift -version'
echo 'Executing: '$VER_CMD
$VER_CMD
