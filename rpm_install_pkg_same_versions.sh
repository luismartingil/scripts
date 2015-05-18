#!/bin/bash
#
# Script to install different versions of the same RPM 
# packages given a desired regex.
#
# Author: luismartingil
# Website: www.luismartingil.com
# Year: 2015
#
#
# Output example:
#
# mybox152 [~/_toremove] $ ./test.sh rpm.myserver.net
# yumdownloader already installed
# Loaded plugins: downloadonly, fastestmirror
# Cleaning repos: base epel extras rpm.myserver.net updates
# 2 metadata files removed
# 1 sqlite files removed
# 0 metadata files removed
# Loaded plugins: downloadonly, fastestmirror
# Cleaning repos: base epel extras rpm.myserver.net updates
# 0 metadata files removed
# Loaded plugins: downloadonly, fastestmirror
# Cleaning repos: base epel extras rpm.myserver.net updates
# Cleaning up Everything
# New rpm pkgs found
# Downloading myproject-doc-0.0.0 myproject-doc-0.0.1
# Loaded plugins: fastestmirror
# Loading mirror speeds from cached hostfile
# * base: mirror.trueinter.net
# * epel: fedora-mirror01.rbc.ru
# * extras: mirror.trueinter.net
# * updates: mirror.trueinter.net
# myproject-doc-0.0.0-1.x86_64.rpm | 1.9 MB     00:03
# myproject-doc-0.0.1-1.x86_64.rpm | 1.9 MB     00:01
# Installing pkg: myproject-doc-0.0.0
# Preparing...                ########################################### [100%]
# 1:myproject-doc            ########################################### [100%]
# Installing pkg: myproject-doc-0.0.1
# Preparing...                ########################################### [100%]
# 1:myproject-doc            ########################################### [100%]
# Cleaning tmp folder
# removed `/tmp/tmp.pimuspjUND/myproject-doc-0.0.0-1.x86_64.rpm'
# removed `/tmp/tmp.pimuspjUND/myproject-doc-0.0.1-1.x86_64.rpm'
# removed directory: `/tmp/tmp.pimuspjUND'



EXPECTED_ARGS=1
# 1 repo url

if [ $# -ne $EXPECTED_ARGS ]
then
    echo "Usage: $0 <repo-url>"
    echo "<repo-url> rpm repo to get the rpms from. Others will be disabled"
    echo "           Example: rpm.myserver.net"
    exit 1
fi

# Grab repo from the user
repo=$1

# Regex to match desired packages
regex=\*-doc

# Avoid packages containing this string
avoid=twisted

install_reqs () {
    sudo yum -y install yum-utils
}

repo_clean () {
    sudo yum --enablerepo=$repo clean metadata ; sudo yum clean expire-cache ;  sudo yum clean all
}

run_main () {
    hash yumdownloader 2>/dev/null && echo 'yumdownloader already installed' || install_reqs


    repo_clean

    pkgs=""
    pkgs=`sudo repoquery -a --pkgnarrow=available --show-duplicates --queryformat='%{name}-%{version}' --disablerepo="*" --enablerepo="$repo" list available $regex | grep -v '$avoid' | expand`

    # If we have new pkgs
    if [[ -n $pkgs ]]; then

	TMP=`mktemp -d`

 	echo "New rpm pkgs found"
 	echo "Downloading "$pkgs
	yumdownloader --destdir $TMP $pkgs

	for pkg in $pkgs;
	do
	    echo 'Installing pkg: '$pkg
	    find $TMP -name '*'$pkg'*' -type f -exec sudo rpm -hiv {} \;
	done

	echo 'Cleaning tmp folder'
	rm -frv $TMP
    else
	echo 'No new RPMs found, no need to download any'
    fi
}

run_main
