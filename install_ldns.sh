#!/bin/bash
#
# Bash script to install the ldns library.
# Author: luismartingil
# Year: 2013
#
# Generic installation script

VER_LDNS=1.6.16
NAME=ldns-$VER_LDNS
WEB=http://www.nlnetlabs.nl/downloads/ldns/$NAME.tar.gz

SRC=/usr/local/src/ # Placing ldns sources
LIB_DST=/usr/lib/ # Library dest folder.


# Bash functions to install dependencies.
# Probably more deps than needed!
install_centos_req () {
    sudo yum groupinstall -y 'Development Tools'
}
install_debian_req () {
    echo 'todo'
    #sudo apt-get install libboost-dev libboost-test-dev libboost-program-options-dev libevent-dev automake libtool flex bison pkg-config g++ libssl-dev ruby-full ruby-dev librspec-ruby rake rubygems libdaemons-ruby libgemplugin-ruby mongrel python-dev python-twisted libbit-vector-perl php5-dev php5-cli libglib2.0-dev erlang-base erlang-eunit erlang-dev mono-gmcs libmono-dev libmono-system-web2.0-cil ghc6 cabal-install libghc6-binary-dev libghc6-network-dev libghc6-http-dev automake bison global doxygen libglib2.0-0 libevent-dev automake libtool flex bison pkg-config g++ libssl-dev automake libtool flex bison pkg-config g++
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
    echo 'Removing old ldns files'
    sudo rm -frv $SRC$NAME
fi

cd; sudo tar -zxvf $NAME.tar.gz -C /usr/local/src

# Compiling and installing the lib
cd $SRC$NAME ; sudo chmod uog+x configure
cd $SRC$NAME ; sudo ./configure --disable-gost --disable-ecdsa --libdir=$LIB_DST

# Lets go!
cd $SRC$NAME ; sudo make
cd $SRC$NAME ; sudo make install

# ldconfig creates the necessary links and cache to the most recent shared 
# libraries found in the directories specified on the command line
sudo ldconfig

echo '~~~~~~~~~~~~~~~~~~~~~~'
echo 'ldns is installed in '$LIB_DST
LS_CMD='ls -lrt '$LIB_DST' | grep ldns'
echo 'Executing: '$LS_CMD
$LS_CMD
