#!/bin/bash
#
# Bash script to install the baresip SIP client.
# Author: luismartingil
#
 
WEB=http://www.creytiv.com/pub/
ARRAY=( re-0.4.2 rem-0.4.2 baresip-0.4.3 )
 
# Installing some stuff
sudo apt-get install emacs tshark gcc gpp python make
sudo apt-get install alsa-utils alsa-oss linux-sound-base
sudo adduser `whoami` audio
 
alsamixer
 
for i in "${ARRAY[@]}"
do
    wget $WEB$i.tar.gz
    tar -zxvf $i.tar.gz
    cd $i/
    make
    sudo make install
done
 
# Updating shared libs
sudo ldconfig
 
echo 'execute baresip'