#!/bin/bash
#
# Checks a vpn site-site connection in a VyOS router.
# Used by Nagios as a plugin.
#
#
# luismartingil
# 2015

PROGNAME=`basename $0`
REVISION=1.00

print_revision() {
	echo $PROGNAME $REVISION
}

print_usage() {
	echo "Usage:"
	echo "	$PROGNAME -c|--check <vyos_host> <vyos_user> <vpn_peer>"
	echo "	$PROGNAME -h|--help"
	echo "	$PROGNAME -v|--version"
}

print_help() {
	print_revision
	echo ""
	print_usage
	echo "Where:"
	echo "	vyos_host   vyos router host"
	echo "	vyos_user   vyos username"
	echo "	vpn_peer    vyos vpn site to site peer to be checked"
	echo ""
	echo "	-h|--help	prints this help screen"
	echo ""
	echo "	-v|--version	prints version"
	echo ""
}

check_vpn() {

	if [ $# -ne 3 ]
	then
	        echo "Number of arguments incorrect"
	        exit 3
	fi

	VYOS_HOST=$1
	VYOS_USER=$2
	VPN_PEER=$3
	VYATTA_VPN_CMD=/opt/vyatta/bin/sudo-users/vyatta-op-vpn.pl

	# New tmp folder
	TMP_DIR=$(mktemp -d)

	# Grab the output of the commands into local files
	FILE_PEER_DETAIL=$TMP_DIR/peer_detail
	ssh $2@$1 "sudo $VYATTA_VPN_CMD --show-ipsec-sa-peer-detail="$VPN_PEER"" > $FILE_PEER_DETAIL

	# FILE_STATS_PEER=$TMP_DIR/stats_peer
	# ssh $2@$1 "sudo $VYATTA_VPN_CMD --show-ipsec-sa-stats-peer="$VPN_PEER"" > $FILE_STATS_PEER

	FILE_IKE_PEER=$TMP_DIR/file_ike
	ssh $2@$1 "sudo $VYATTA_VPN_CMD --show-ike-sa-peer="$VPN_PEER"" > $FILE_IKE_PEER

	# With the information in the local fies, lets grab what we want
	tunnel_state_peer=$(cat $FILE_PEER_DETAIL | grep State | awk '{print $2}')
	inbound_bytes=$(cat $FILE_PEER_DETAIL | grep "Inbound Bytes" | awk '{print $3}')
	outbound_bytes=$(cat $FILE_PEER_DETAIL | grep "Outbound Bytes" | awk '{print $3}')
	ike_state=$(cat $FILE_IKE_PEER | grep -A2 "State" | tail --lines=1 | awk '{print $1}')
	
	# Clean tmp folder
	rm -fr $TMP_DIR

	# Scrpit output
	msg="State $tunnel_state_peer | Outbound Bytes=${outbound_bytes}B | Inbound Bytes=${inbound_bytes}B"
	if  [ $tunnel_state_peer == 'up' ] ; then
	    echo "IN Tunnel OK. "$msg
	    exit 0
	elif [ $tunnel_state_peer == 'down' ]; then
	    echo "IN Tunnel CRITICAL. "$msg
	    exit 2
	else
	    echo "IN Tunnel UNKNOWN. "$msg
	    exit 3
	fi
}

case "$1" in
--help)
                print_help
        exit 0
        ;;
-h)
                print_help
        exit 0
        ;;
--version)
                print_revision
        exit 0
        ;;
-v)
                print_revision
        exit 0
        ;;
--check)
                check_vpn $2 $3 $4
        ;;
-c)
                check_vpn $2 $3 $4
        ;;
*)
                print_usage
        exit 3

esac
