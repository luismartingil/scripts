#!/bin/bash
#
# Bash script to install emacs from sources
# Author: luismartingil
# Year: 2015
#
# Debian based installation script


install_emacs () {
    VER=24.5
    sudo apt-get install -y git-core libxaw7-dev libxpm-dev libpng12-dev libtiff5-dev libgif-dev libjpeg8-dev libgtk2.0-dev libncurses5-dev autoconf automake texinfo
    sudo apt-get build-dep -y emacs
    cd /tmp
    wget -c http://ftp.gnu.org/gnu/emacs/emacs-$VER.tar.gz
    tar zxvf emacs-$VER.tar.gz
    cd emacs-$VER
    ./configure
    make --jobs=4
    sudo make install
    echo 'emacs-'$VER' is installed!'
}

install_emacs
