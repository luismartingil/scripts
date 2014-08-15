#!/bin/bash
#
# Installation script for a readthedocs instance
# in a plain CENTOS box. readthedocs.org
#
# Author: luismartingil
# Year: 2014
#
#

# Actual folder
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ENV=rtd
ENV_DIR=$DIR/$ENV

install_pip() {
    echo 'Installing pip'
    curl https://raw.githubusercontent.com/pypa/pip/master/contrib/get-pip.py | sudo python -
    echo 'Done installing pip'
    # Making sure this did the job
    hash pip 2>/dev/null || { echo >&2 "error installing pip."; exit 1; }
    echo 'Success installing pip'
}

install_epel() {
    echo 'Installing epel'
    wget -c http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
    wget -c http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
    sudo rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm
    echo 'Done installing epel'
}

install_req () {
    echo 'Installing dependencies'
    # Getting epel repo
    [ `ls -lart /etc/yum.repos.d/ | grep epel | wc -l` -gt 0 ] && echo 'epel repo already installed' || install_epel
    # Getting dependencies
    sudo yum groupinstall -y "Development tools"
    sudo yum install -y pdfjam python-devel libxml2 libxslt libxml2-devel libxslt-devel libyaml-devel lxml python-lxml libdbi-dbd-sqlite zlib-devel xz-devel zlib-dev ncurses-devel bzip2-devel openssl-devel libpcap-devel readline-devel python-sqlite2 tk-devel gdbm-devel db4-devel sqlite-devel
    # Installing pip
    hash pip 2>/dev/null && echo 'pip already installed' || install_pip
    echo 'Done installing dependencies'
}

install_python27_aux () {
    echo 'Installing python2.7'
    # Installing python2.7
    wget --no-check-certificate http://python.org/ftp/python/2.7.6/Python-2.7.6.tgz
    gzip -dc Python-2.7.6.tgz | tar xf -
    cd Python-2.7.6
    ./configure --prefix=/usr/local --enable-unicode=ucs4 --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib"
    make && sudo make altinstall
    which python2.7
    echo 'Done installing python2.7'
    # Making sure this did the job
    hash python2.7 2>/dev/null || { echo >&2 "Error installing python2.7."; exit 1; }
    echo 'Success installing python2.7'
}

install_python27 () {
    hash python2.7 2>/dev/null && echo 'python2.7 already installed' || install_python27_aux
}

install_rtd () {
    echo 'Installing rtd'
    echo 'Removing previous installation'
    sudo rm -fr $ENV_DIR
    sudo pip install virtualenv    
    cd ; virtualenv -p python2.7 $ENV_DIR
    ENV_PYTHON_BIN=$ENV_DIR/bin/python
    cd $ENV ; source bin/activate
    pip install --upgrade pip
    mkdir checkouts ; cd checkouts
    git clone https://github.com/rtfd/readthedocs.org.git
    cd readthedocs.org
    echo 'Installing rtd reqs'
    pip install -r pip_requirements.txt
    pip install sphinx_bootstrap_theme
    echo 'Done installing rtd reqs'
    RTD_DIR=$ENV_DIR/checkouts/readthedocs.org
    cd $RTD_DIR
    $ENV_PYTHON_BIN manage.py syncdb
    $ENV_PYTHON_BIN manage.py migrate
    echo 'Done installing rtd'
    echo 'Running rtd server'
    $ENV_PYTHON_BIN manage.py runserver 0.0.0.0:8000    
}

# No iptables, please
sudo service iptables stop

# Installing requirements
install_req

# Installing python2.7 if needed
install_python27

# Installing rtd from Python sources
install_rtd
