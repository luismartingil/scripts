#!/bin/bash
#
# Diffs released rpm packages between two different servers that contain
# rpm repos. Generates two files to be used by the extended choice parameter
# jenkins plugin: tobe_released.csv and released.csv.
#
# It allows the user to select projects to be released and unreleased,
# making the release pipeline better. Desired to run as a jenkins cron job.

# Author: luismartingil
# Year: 2015
#

# Output fmt example, (both released.csv and tobe_release.csv files have same fmt)
#
# REPO	NAME	VERSION	BUILD
# stable	project1	0.0.5	stable;project1-0.0.5-1.x86_64
# unstable	libgeotiff	1.2.5	unstable;libgeotiff-1.2.5-5.el6.x86_64
# unstable	libpqxx	3.1	unstable;libpqxx-3.1-0.1.rhel6.x86_64
# unstable	libpqxx-devel	3.1	unstable;libpqxx-devel-3.1-0.1.rhel6.x86_64
# unstable	pgdg-centos	8.4	unstable;pgdg-centos-8.4-3.noarch
#

# Safety lock
lock=/tmp/rpm-release-jenkins.lock
if [ -f $lock ]; then
    echo "Script already running."
    exit 1
fi

EXPECTED_ARGS=5
if [ $# -ne $EXPECTED_ARGS ]
then
    echo 'Usage: '$0' <rpm-ori> <rpm-dst> <rpm-repos> <env> <dest>'
    opts1='user0@rpm0.domain.net:/rpms user1@rpm1.domain.net:/rpms'
    opts2='"stable unstable" myenv /jenkins'
    echo $0' '$opts1' '$opts2
    exit 1
else
    RPM_ORI=$1
    RPM_DST=$2
    RPM_REPOS=$3
    PRE_FILE_ENV=$4
    DST=$5
fi

: ${JOB_NAME:?"Need to set JOB_NAME non-empty"}

# Released and tobe_released desired files with
# the extended_choice_param format.
PRE_FILE_TOBE_RELEASED=tobe_released.csv
PRE_FILE_RELEASED=released.csv

gen_extended_choice_param_fmt () {
    # Outputs into $OUTFILE file a valid extended choice format
    RPM_FOLDER=$1
    REPO=$2
    OUTFILE=$3
    PKGS=$4
    QUERY_OUT_FMT=$REPO'\t%{NAME}\t%{VERSION}\t'$REPO';%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}\n'
    rm -f $OUTFILE ; touch $OUTFILE
    echo 'Generating extended_choice_param jenkins plugin file format to '$OUTFILE
    for PKG in $PKGS; do
        rpm --nosignature --queryformat $QUERY_OUT_FMT -qp $RPM_FOLDER/$REPO/$PKG\*.rpm >> $OUTFILE
    done;
}

gen_list_pkgs () {
    # Generate the list of RPM packages contained in a given folder,
    # outputs to a file.
    echo 'Generating package list contained in '$1' to file '$2
    QUERY_FMT='%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}\n'
    rpm --nosignature --queryformat $QUERY_FMT -qp $1/\*.rpm | uniq | sort > $2
}

sync_repo () {
    # Syncs a repo into a local folder
    echo 'Syncing repo '$1' to '$2
    rsynclimit=0
    rsyncexcluded='--exclude=repoview/ --exclude=repodata/ --exclude=cached/'
    rsyncopts='-aHS --bwlimit='$rsynclimit' --delete --delete-excluded '$rsyncexcluded
    mkdir -p $2
    rsync $rsyncopts $1/ $2/
}

my_main () {
    TMPFOLDER_ORI=/tmp/$JOB_NAME/`echo $RPM_ORI | tr -dc '.a-zA-Z0-9'`
    TMPFOLDER_DST=/tmp/$JOB_NAME/`echo $RPM_DST | tr -dc '.a-zA-Z0-9'`

    TMPFOLDER=`mktemp -d -t $JOB_NAME.XXXXXXXXXX`

    for REPO in $RPM_REPOS; do

	echo 'Working with repo:'$REPO

	# Sync repos to local folders
	sync_repo $RPM_ORI/$REPO $TMPFOLDER_ORI/$REPO
	sync_repo $RPM_DST/$REPO $TMPFOLDER_DST/$REPO

	# Generate list of packages released and tobe_released
	TMPFILE_ORI=$TMPFOLDER/$REPO'.pkgs.ori'
	TMPFILE_DST=$TMPFOLDER/$REPO'.pkgs.dst'
	gen_list_pkgs $TMPFOLDER_ORI/$REPO $TMPFILE_ORI
	gen_list_pkgs $TMPFOLDER_DST/$REPO $TMPFILE_DST
	PKGS_RELEASED=`comm -1 $TMPFILE_ORI $TMPFILE_DST`
	PKGS_TOBE_RELEASED=`comm -23 $TMPFILE_ORI $TMPFILE_DST`
	rm -frv $TMPFILE_ORI
	rm -frv $TMPFILE_DST

	# Getting the released and tobe_released files
	TMPFILE_RELEASED=$TMPFOLDER/$REPO'.'$PRE_FILE_RELEASED
	TMPFILE_TOBE_RELEASED=$TMPFOLDER/$REPO'.'$PRE_FILE_TOBE_RELEASED
	gen_extended_choice_param_fmt $TMPFOLDER_ORI $REPO $TMPFILE_RELEASED "$PKGS_RELEASED"
	gen_extended_choice_param_fmt $TMPFOLDER_ORI $REPO $TMPFILE_TOBE_RELEASED "$PKGS_TOBE_RELEASED"    

	echo 'Finished working with repo:'$REPO
	echo ''
    done;

    # Cleaning previous files
    echo 'Cleaning previous files...'
    rm -frv $DST/$PRE_FILE_ENV.*.csv

    # Merging RPM_REPOS files into one
    HEADER='REPO\tNAME\tVERSION\tBUILD\n'
    echo 'Merging files...'
    printf $HEADER > $DST/$PRE_FILE_ENV.$PRE_FILE_RELEASED
    printf $HEADER > $DST/$PRE_FILE_ENV.$PRE_FILE_TOBE_RELEASED
    cat $TMPFOLDER/*.$PRE_FILE_RELEASED >> $DST/$PRE_FILE_ENV.$PRE_FILE_RELEASED
    cat $TMPFOLDER/*.$PRE_FILE_TOBE_RELEASED >> $DST/$PRE_FILE_ENV.$PRE_FILE_TOBE_RELEASED

    # Some feedback
    echo ' --------------------------------------------------------- '
    echo ' Released pkgs on '$RPM_DST' (upstream server:'$RPM_ORI')'
    echo ' --------------------------------------------------------- '
    cat $DST/$PRE_FILE_ENV.$PRE_FILE_RELEASED
    echo ' --------------------------------------------------------- '

    echo ' --------------------------------------------------------- '
    echo ' To be released pkgs on '$RPM_DST' (upstream server:'$RPM_ORI')'
    echo ' --------------------------------------------------------- '
    cat $DST/$PRE_FILE_ENV.$PRE_FILE_TOBE_RELEASED
    echo ' --------------------------------------------------------- '

    # Cleaning tmp folder
    ls -lRt $TMPFOLDER
    rm -frv $TMPFOLDER
}

touch $lock
my_main
rm -frv $lock
