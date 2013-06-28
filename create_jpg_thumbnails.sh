#!/bin/bash
#
# Uses convert tool to resize a bunch of $EXT pictures.
# Author: -
# Tweaked by: luismartingil
# Year: - (~2005)
#

SRC=/home/myuser/src_pictures
DEST=/home/myuser/thumbnails
EXT=JPG
# Percentage of resizing
PER=42
 
for filename in $SRC/*.$EXT
do
    # Removing the prefixes.
    tmp=${filename##/*/}
    # Setting thumbnail name.
    t=${tmp%.$EXT}_thumb.$EXT  
    convert -resize $PER% -gravity center $filename $DEST/$t

echo 'thumbnails created!'