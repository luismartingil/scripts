#!/bin/bash
#
# Bash script to install the pjsua SIP client.
# Author: luismartingil
# Year: 2012
#
# Ubuntu installation script

VER=2.0.1

# Installing some stuff
sudo apt-get install -y emacs tshark gcc make python git gnustep-gui-runtime alsa-utils linux-sound-base sox beep linux-sound-base gcc build-essential make g++ gpp alsaplayer-daemon libasound2 libasound2-dev gcc build-essential make g++ gpp libpulse-dev alsaplayer-daemon libasound2 libasound2-dev portaudio19-dev libportaudio2 pulseaudio alsa-utils libasound2-plugins libasound2 binutils binutils-dev

# Myself to the audio group, please.
sudo adduser `whoami` audio

cd ; wget http://www.pjsip.org/release/$VER/pjproject-$VER.tar.bz2
cd ; tar jxf pjproject-$VER.tar.bz2
cd ; cd pjproject-$VER
sudo make clean
./configure
make dep
make
sudo make install

# Let's create an symbolic link
cd ; ln -s pjproject-$VER/pjsip-apps/bin/pjsua-x86_64-unknown-linux-gnu pjsua

echo 'execute ./pjsua'
