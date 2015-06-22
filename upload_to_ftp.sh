#!/bin/bash
#
# Uploads files to an anonymous ftp server 
#
#  $1 : FTP server host
#  $2 : Remote FTP folder where files are going to be stored
#  $3 : Local FTP folder where to get the files from
#  $4 : Local files extension.

upload_to_ftp ()
{
    # Uploads files from local folder to a given FTP server.
    # Params:
    #  $1 : FTP server host
    #  $2 : Remote FTP folder where files are going to be stored
    #  $3 : Local FTP folder where to get the files from
    #  $4 : Local files extension.
    #
    FTP_USERNAME="anonymous"
    FTP_PASSWORD="anonymous@anonymous.com"
    FTP_SERVER=$1 # Ftp server
    FTP_DIR=$2 # Dest folder where files are going to be stored
    LOCAL_DIR=$3 # Local folder where files are stored
    LOCAL_EXTENSION=$4 # Extension of the files to be uploaded

    echo 'FTP_SERVER:'$FTP_SERVER
    echo 'FTP_DIR:'$FTP_DIR
    echo 'LOCAL_DIR:'$LOCAL_DIR
    echo 'LOCAL_EXTENSION:'$LOCAL_EXTENSION

    echo 'About to upload these files,'
    ls -lart $LOCAL_DIR/*.$LOCAL_EXTENSION
    
    cd $LOCAL_DIR
    for f in *.$LOCAL_EXTENSION ;
    do
	if [[ "$f" == *.$LOCAL_EXTENSION ]]
	then
	    echo 'Uploading "'$f'" to "'$FTP_SERVER'"';
	    FTP_LOG=`mktemp`
	    ftp -inv $FTP_SERVER > $FTP_LOG 2>&1 <<-EOF
user $FTP_USERNAME $FTP_PASSWORD
binary
cd $FTP_DIR
mput $f
quit
EOF

	    echo 'FTP command executed'
	
	    echo ' >>> '
	    cat $FTP_LOG
	    echo ' <<< '
 
	    # Now check the output of the ftp cmd
	    # to see if we've been succesful.
	    FTP_SUCCESS_MSG="226 Transfer complete"
	    if fgrep "$FTP_SUCCESS_MSG" $FTP_LOG ;then
		echo 'Success uploading the file using FTP'
	    else
		echo 'Error: FTP problem' && exit 1
	    fi
	fi
    done
}

EXPECTED_ARGS=4

#  $1 : FTP server host
#  $2 : Remote FTP folder where files are going to be stored
#  $3 : Local FTP folder where to get the files from
#  $4 : Local files extension.

if [ $# -ne $EXPECTED_ARGS ]
then
    echo "Usage: $0 <ftp-server> <ftp-dir> <local-path> <files-extension>"
    echo "<ftp-server> ftp to store the rpms."
    echo "<ftp-dir> ftp folder path."
    echo "<local-path> local path."
    echo "<files-extension> local files extension."
else
    upload_to_ftp $1 $2 $3 $4
