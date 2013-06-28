#!/bin/bash
#
# Installation script for the restund STUN server.
# Author: luismartingil
# Year: 2013
#
#
 
WEB=http://www.creytiv.com/pub/
re=re-0.4.3
restund=restund-0.4.2
ARRAY=( $re $restund )
  
for i in "${ARRAY[@]}"
do
    cd; wget $WEB$i.tar.gz
    sudo tar -zxvf $i.tar.gz -C /usr/local/src
    cd /usr/local/src/$i/
    sudo make
    sudo make install
    sudo make config
done
 
# Updating shared libs
sudo ldconfig
 
# Copying libre.so to lib64 in case ldconfig doesnt work.
sudo cp /usr/local/src/$re/libre.so /usr/lib64
 
# Making the config file
cd /usr/local/src/$restund/ ; sudo make config
 
# Setting the IP
echo "Set the IP followed by [enter]"
read ipsrv
 
# Chaging the IP in the config file
sudo sed -i 's|127.0.0.1|'$ipsrv'|g' /etc/restund.conf
 
echo 'execute sudo restund'
echo 'Make sure your iptables are allowing this traffic'
echo 'You can disable them with: sudo iptables stop'