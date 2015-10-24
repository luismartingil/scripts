#!/bin/bash
#
# Bash script to install emacs from sources
# Author: luismartingil
# Year: 2015
#
# Centos based installation script
# Thanks to:
#  https://creatorjie.wordpress.com/2013/03/27/how-to-install-emacs-24-3-in-centos-5-5/

install_emacs_centos () {
    VER=24.5
    sudo yum install -y gcc make ncurses-devel giflib-devel libjpeg-devel libtiff-devel
    cd /usr/local/src/
    wget -c http://ftp.gnu.org/gnu/emacs/emacs-$VER.tar.gz
    tar zxvf emacs-$VER.tar.gz
    cd emacs-$VER
    ./configure --without-x --without-selinux
    make --jobs=4
    sudo make install
    echo 'emacs-'$VER' is installed!'
}

install_emacs_centos
