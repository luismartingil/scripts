#!/bin/bash
#
# Adding Epel RPM server for Centos6.
#
# Author: luismartingil
# Year: 2014
#
#
#
# Possible problems/solutions:
# - Make sure you see epel repo here: `yum repolist enabled`
# - Make sure you see the epel gpg key here: `rpm -q gpg-pubkey --qf '%{name}-%{version}-%{release} --> %{summary}\n'` (Import the key if not: `rpm --import https://fedoraproject.org/static/0608B895.txt`)
# - Enable always epel using `yum-config-manager --enable epel`
# - Installing the epel dependency specifying the epel repo `yum --enablerepo=epel install python-psutil`
#
#

echo 'Adding epel rpm server'
set -e
echo 'Getting RPMs...'
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
echo 'Installing...'
sudo rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm
set +e