#!/bin/bash
#
# Bash script to install and set up an RPM
# server for CENTOS
# Author: luismartingil
# Year: 2014
#
# Centos based. Tested on CentOS release 6.4 (Final)

FTP_NAME='TestRPMServer'
RPM_FOLDER='/rpm-repo'

# Welcome
echo 'Installing and setting up an RPM server'
echo ' ------------------------------------- '

# Installing dev tools
sudo yum -y groupinstall "Development tools"
sudo yum -y install createrepo

# FTP folder
sudo mkdir -p $RPM_FOLDER
sudo chmod -R uog+rw $RPM_FOLDER

# We'll use proftpd as the ftp server, let's install it
PROFTPD_CONFIG='/usr/local/etc/proftpd.conf'
cd ; wget ftp://ftp.proftpd.org/distrib/source/proftpd-1.3.5.tar.gz
cd ; tar zxvf proftpd-1.3.5.tar.gz
cd proftpd-1.3.5 ;
sudo make clean
sudo rm -frv $PROFTPD_CONFIG
./configure
make
sudo make install

# Let's create the logs folder
sudo mkdir -p /var/log/proftpd

# This is going to be the proftpd config file
TMP_FILE=(mktemp)
cat > $TMP_FILE <<EOF
# This is a basic ProFTPD configuration file (rename it to
# 'proftpd.conf' for actual use.  It establishes a single server
# and a single anonymous login.  It assumes that you have a user/group
# "nobody" and "ftp" for normal operation and anon.

ServerName THISISSERVERNAME
ServerType standalone
DefaultServer on

TransferLog /var/log/proftpd/xferlog
SystemLog /var/log/proftpd/proftpd.log

# Port 21 is the standard FTP port.
Port 21

# Don't use IPv6 support by default.
UseIPv6 off

# Umask 022 is a good standard umask to prevent new dirs and files
# from being group and world writable.
Umask 022

# To prevent DoS attacks, set the maximum number of child processes
# to 30.  If you need to allow more than 30 concurrent connections
# at once, simply increase this value.  Note that this ONLY works
# in standalone mode, in inetd mode you should use an inetd server
# that allows you to limit maximum number of processes per service
# (such as xinetd).
MaxInstances 30

# Set the user and group under which the server will run.
User nobody
Group nobody

# To cause every FTP user to be "jailed" (chrooted) into their home
# directory, uncomment this line.
#DefaultRoot ~

# Normally, we want files to be overwriteable.
AllowOverwrite off

# Bar use of SITE CHMOD by default
<Limit SITE_CHMOD>
  DenyAll
</Limit>

# A basic anonymous configuration, no upload directories.  If you do not
# want anonymous users, simply delete this entire <Anonymous> section.
<Anonymous THISISREPOPATH>
  User ftp
  Group ftp

  # We want clients to be able to login with "anonymous" as well as "ftp"
  UserAlias anonymous ftp

  # Limit the maximum number of anonymous logins
  MaxClients 10

#  We want 'welcome.msg' displayed at login, and '.message' displayed
#  in each newly chdired directory.
#  DisplayLoginwelcome.msg
#  DisplayChdir.message

#  Limit WRITE everywhere in the anonymous chroot
#  <Limit WRITE>
#    DenyAll
#  </Limit>
</Anonymous>
EOF

sed -i 's,THISISSERVERNAME,'$FTP_NAME',g' $TMP_FILE
sed -i 's,THISISREPOPATH,'$RPM_FOLDER',g' $TMP_FILE

# Moving ftp config file to proper location
sudo mv $TMP_FILE $PROFTPD_CONFIG

# Starting the FTP server
sudo killall proftpd
sudo /usr/local/sbin/proftpd
sudo service iptables stop # Little dirty

# Create the RPM repo which will be
# served by the FTP server installed.
CREATE_REPO_CMD='sudo createrepo --update -v '$RPM_FOLDER
eval $CREATE_REPO_CMD

# Installing that command into crontab
# (Every minute recreate the repo. It would be
# better to look for file changes...)
CRON_LINE="*/1 * * * * "$CREATE_REPO_CMD # Little dirty
echo "$CRON_LINE"
crontab -l > mycron
sed -i '/createrepo/d' mycron # Little dirty
echo "$CRON_LINE" >> mycron
crontab mycron
rm mycron

# Some guidelines about client configuration
echo """
-----------------------------------------------------
Example of client configuration:

sudo sh -c 'echo \"[myrepo]
name=myrepo
comment =\"Test RPM Repo\"
baseurl=ftp://_IP_/
gpgcheck=0
enabled=1\" > /etc/yum.repos.d/myrepo.repo'

sudo yum --enablerepo=myrepo clean metadata
sudo yum clean expire-cache
sudo yum clean all
sudo yum update

"""