#!/bin/bash
#
# Bash script to replace chars in multiple files using sed.
# Backslashes are allowed in the string
#
# Author: luismartingil
# Year: 2013
#

# Some variables to be changed.
URL=http://127.0.0.1
PORT=7788
FILE1=/etc/myprogram1.conf
FILE2=/etc/myprogram2.conf

# Be careful while editing this array. 
# Items should be 'ori_str' 'dst_str' 'path_file'
array_changes=(

    # Example1. 'ori_str' 'dst_str' 'path_file'
    'define("URL", "_url_");'
    'define("URL", "'$URL'");'
    $FILE1

    # Example2. 'ori_str' 'dst_str' 'path_file'
    'define("PORT", "_port_");'
    'define("PORT", "'$PORT'");'
    $FILE1

    # Example3. 'ori_str' 'dst_str' 'path_file'
    ';http://domain.net'
    ';http://domain.net/mypath'
    $FILE2

    # Example4. 'ori_str' 'dst_str' 'path_file'
    ';debug=info'
    'debug=info'
    $FILE2
)

# Don't modify!
# Looping over the array_changes array applying the sed translations.
# Looping technique is a little bit ugly...
i=0
for item in "${array_changes[@]}"
do
    n=$((i%3))
    # Source string for the sed command
    if [ "$n" -eq "0" ]
    then 
	src=$(echo "$item" | sed 's/\//\\\//g')
    # Dest string for the sed command
    elif [ "$n" -eq "1" ]
    then 
	dst=$(echo "$item" | sed 's/\//\\\//g')
    else 
    # File for the sed command
	f=$item
	str="s/"$src"/"$dst"/g"
	cmd=( sudo sed -i "'"$str"'" $f )
	eval "${cmd[@]}"
    fi
    (( ++i ))
done
