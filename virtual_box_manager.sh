#!/bin/bash
# 
# Script to manage my VirtualBox VMs.
#
# Author: luismartingil
# Year: 2011
                                       
BOXES="_name_of_vm1 _name_of_vm2 _name_of_vmX"
 
# Simple input param checking.
case $1 in
    start)
	;;
    stop)
	;;
    *)
	echo "please set the appropiate option: start, stop."
	exit
	;;
esac

# Looping the boxes list.
for j in ${BOXES}
do
    COMMAND=""
    case $1 in
    start)
            echo "starting "${j}" ..."
            COMMAND="VBoxHeadless -s "${j}" &"
            ;;
	stop)
            echo "stopping "${j}" ..."
            COMMAND="VBoxManage controlvm "${j}" poweroff"
            ;;
    esac
    eval $COMMAND
done