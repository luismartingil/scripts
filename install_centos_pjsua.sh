#!/bin/bash
#
# Bash script to install the pjsua SIP client.
# Author: luismartingil
# Year: 2016
#
# Centos installation script

VER=2.5.5

# Installing some stuff
sudo yum groupinstall -y "Development tools"
sudo yum install -y alsa-lib alsa-lib-devel alsa-utils binutils boost-devel ffmpeg-devel gcc gcc-c++ libevent-devel libyuv libyuv-devel make python-devel python-gevent tcpdump

cd ; rm -fv pjproject-$VER/
cd ; wget http://www.pjsip.org/release/$VER/pjproject-$VER.tar.bz2
cd ; tar jxf pjproject-$VER.tar.bz2
cd ; cd pjproject-$VER
sudo make clean
./configure --disable-libyuv
make dep
make
sudo make install

# Let's create an symbolic link
cd ; ln -s pjproject-$VER/pjsip-apps/bin/pjsua-x86_64-unknown-linux-gnu pjsua

echo 'execute ./pjsua'
