#!/bin/bash
#
# Generates normalized wav based on the wav
# files found in $FOLDER recursively.
#
# - Requires: sox
#
# - Example:
# wavs/file0.wav
# wavs/file1.wav
# wavs/folder0/file2.wav
#
# # With DELTA=5, MIN=-10, MAX=0, generates:
# wavs/file0_norm_0.wav
# wavs/file0_norm_-5.wav
# wavs/file0_norm_-10.wav
# wavs/file1_norm_0.wav
# wavs/file1_norm_-5.wav
# wavs/file1_norm_-10.wav
# wavs/folder0/file2_norm_0.wav
# wavs/folder0/file2_norm_-5.wav
# wavs/folder0/file2_norm_-10.wav
#
# # If run again, nothing is re-produced unless
# # new wav files are added.
#
#
# - Hint: Change sox command if needed!
#
#
# - Author: luismartingil
# - Year: 2014
#

MIN=-50 # Min normalization level  (sox `norm`)
MAX=0 # MAX normalization level (sox `norm`)
DELTA=5 # Ticks - Output wavs every $DELTA from MIN to MAX
FOLDER=wavs # Folder to look for the *.wav files recursively
STAMP=_norm_ # Stamped string to be attached to new normalized files

hash sox 2>/dev/null || { echo >&2 "sox needed"; exit 1; }

# Let's go!
for audio in `find $FOLDER/ -name "*.wav" -type f`; do
    if [[ $audio != *$STAMP* ]]; then # Dont want to regenerate normalized ones
        for i in $(seq $MIN $DELTA $MAX); do
	    NAME="${audio%.*}"$STAMP$i.wav
	    if [ ! -f $NAME ]; then
		echo "Processing: "$NAME
		# sox command
	        sox $audio --encoding signed-integer --bits 16 -c 1 -r 8000 $NAME norm $i
	    else
		echo "Already exists: "$NAME
	    fi
        done
    else
	echo "Already normalized: "$audio
    fi
done
