#!/bin/bash
# 
# Exports all the tags in a git repo as <repo-name>-<tag>.tar.gz
# Uploads all this tar files to a ftp server.
#
# Author: luismartingil
# Year: 2013

FTP_USERNAME="anonymous"
FTP_PASSWORD="anonymous@anonymous.com"
FTP_SERVER="projects.indigitaldev.net"
FTP_DIR="/realtime" # Folder where files are going to be stored

project=$(basename `git rev-parse --show-toplevel`)

for tag in $(git tag);
do
    TAG_TMP=$(echo $tag | sed 's/v//g') # Removing the 'v' from v1.0.0...
    NAME=$project-$TAG_TMP
    git archive --prefix=$NAME/ $tag | gzip > $NAME.tar.gz;
    echo 'Generated "'$NAME'.tar.gz" from tag "'$tag'"'
done

TARS=$project*.tar.gz

# Another loop, not efficient but want some
# overview of the files that are going to be uploaded
echo ''
for f in $TARS ;
do
    echo '+ Will upload '$f
done

sleep 1.5

# Uploading the files
for f in $TARS ;
do
    echo 'Uploading "$f" to "$FTP_SERVER"';
    ftp -n -i $FTP_SERVER<<EOF
EOF
    user $FTP_USERNAME $FTP_PASSWORD
    binary
    cd $FTP_DIR
    mput $f
    quit
EOF
done
