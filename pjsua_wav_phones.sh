#!/bin/bash
#
# Automation of the .wav phones creation.
# 1. Download a set of .wav recordings.
# 2. Convert them using sox.
# 3. Bind them as SIP UAs using pjsua.
# 4. Each pjsua will be opened in a tmux terminal.
# Author: luismartingil
# Year: 2013
#

# Some IPs for the pjsua
BOUND_ADDR=192.168.191.16
IP_ADDR=192.168.191.16
STUN_SRV=192.168.191.15
TMUX_SRV=main

# The array of 'url desc port i'
# <url> url to download the wav from
# <desc> description of the recording/ua
# <port> port to bind the UA
# <i> counter # Would be better to automate
array=('
http://www.villagegeek.com/downloads/webwavs/dangerousjob.wav,ua1-dangerousjob,5060,1
http://www.villagegeek.com/downloads/webwavs/getdrunk.wav,ua2-getdrunk,5061,2
http://www.villagegeek.com/downloads/webwavs/guitar.wav,ua3-guitar,5062,3
http://www.villagegeek.com/downloads/webwavs/goodcat.wav,ua3-alf_goodcat,5063,4
')

# New tmux session
tmux new-session -d -s $TMUX_SRV -n $TMUX_SRV

# Let's go!
for i in $array
do IFS=",";
    set $i
    tmp=$2_in.wav
    # Getting the .wav
    wget -c $1 -O $tmp
    # Converting the .wav
    sox $tmp --encoding signed-integer --bits 16 -c 1 -r 8000 $2.wav
    # Use a proper tmux window to execute the pjsua
    tmux new-window -t $TMUX_SRV:$4 -n $2:$3
    cmd=(./pjsua --bound-addr=$BOUND_ADDR --ip-addr=$IP_ADDR --stun-srv=$STUN_SRV --auto-answer=200 --local-port=$3 --play-file=$2.wav --null-audio --auto-play)
    str="${cmd[@]}"
    tmux send-keys -t $TMUX_SRV:$4 $str C-m
done

# Tmux final selection
tmux select-window -t $TMUX_SRV:1
tmux attach-session -t $TMUX_SRV

echo 'phones created!'