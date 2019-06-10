#!/bin/bash
FILES=tests/*

red=`tput setaf 9`
green=`tput setaf 10`
reset=`tput sgr0`

# VALGRIND="valgrind --leak-check=yes --leak-check=full  --track-origins=yes  -v"

for f in $FILES; do
    echo ''
    echo ''    
    echo '========================================================================================'
    echo ''
    echo "Processing ${f} file..."
    echo ''

    PASSWORD=$(openssl rand -hex 24)
    # PASSWORD="password"
    echo "Using key:${PASSWORD}"

    TMP_FOLDER=$(mktemp -d)
    NAME=$(basename $f)
    NAME_TMP=${TMP_FOLDER}/${NAME}

    echo '- Testing encrypting and decrypting using C program:'
    CRYPTED_FILE=${NAME_TMP}.crypt
    DECRYPTED_FILE=${NAME_TMP}.plain
    # Encrypting
    echo '*) Executing crypt command'
    set -x    
    $VALGRIND ./crypt encrypt -i ${f} -o ${CRYPTED_FILE} -p ${PASSWORD}
    set +x
    # Decrypting
    echo ''
    echo '*) Executing crypt command'
    set -x
    $VALGRIND ./crypt decrypt -i ${CRYPTED_FILE} -o ${DECRYPTED_FILE} -p ${PASSWORD}
    set +x
    if diff ${f} ${DECRYPTED_FILE}; then
    	echo "${green}${f} OK${reset}"
    else
    	echo "${red}${f} FAIL${reset}"
    fi

    echo ''
    echo '----------------------------'
    echo '- Testing encrypting using openssl command-line and decrypting using C program:'
    CRYPTED_FILE_CMD=${NAME_TMP}.cmd.crypt
    DECRYPTED_FILE_CMD=${NAME_TMP}.cmd.plain
    # Encrypting using command-line
    echo '*) Executing openssl command'
    set -x
    openssl enc -aes-256-cbc -k ${PASSWORD} -in ${f} -nosalt -p -out ${CRYPTED_FILE_CMD}
    set +x
    # Decrypting
    echo ''
    echo '*) Executing crypt command'
    set -x
    $VALGRIND ./crypt decrypt -i ${CRYPTED_FILE_CMD} -o ${DECRYPTED_FILE_CMD} -p ${PASSWORD}
    set +x
    if diff ${f} ${DECRYPTED_FILE_CMD}; then
    	echo "${green}${f} OK command-line${reset}"
    else
    	echo "${red}${f} FAIL command-line${reset}"
    fi
    
    # Clean-up
    rm -fr ${TMP_FOLDER}
done
