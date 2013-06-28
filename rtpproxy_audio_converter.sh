#!/bin/bash
#
# Converts all the recordings from the rtpproxy to .wav files
# Author: luismartingil
# Year: 2012
#

# Probably need to install some dependencies first!?

for f in *.a.rtp; do 
    f2="${f%.*}"
    filename="${f2%.*}"
    rtpbreak -W -g -f -r $filename".o.rtp"
    rtpbreak -W -g -f -r $filename".a.rtp"
    sox --combine merge -r 8k -e u-law rtp.0.0.raw  -r 8k -e u-law rtp.1.0.raw -t wavpcm -s $filename.wav
    # Watch this @luismartingil!
    rm -rv *.txt *.raw
done