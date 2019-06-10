rm -f *.o *~ *.crypt crypt
gcc -g -Wall -Wextra -Werror -c crypt.c -o crypt.o
gcc -g -Wall -Wextra -Werror -c utils.c -o utils.o
gcc  crypt.o  utils.o -g -Wall -Wextra -Werror -o crypt -lm -lssl -lcrypto
./test.sh


========================================================================================

Processing tests/file001.bin file...

Using key:2dc02feb82507aad070aa527d6e2e75e70ce6cf2c0917c8a
- Testing encrypting and decrypting using C program:
*) Executing crypt command
+ ./crypt encrypt -i tests/file001.bin -o /tmp/tmp.vATWtU7EBf/file001.bin.crypt -p 2dc02feb82507aad070aa527d6e2e75e70ce6cf2c0917c8a
Key: d36b965eb9651d49b395d8dafc9f95de908d4fd8bc3830f8960c5e7eff601b53
IV: b732737af747860ff9d3b2de7546b0a2
Reading "tests/file001.bin" file... done
Encrypting "tests/file001.bin" file to "/tmp/tmp.vATWtU7EBf/file001.bin.crypt"... done
Writting "/tmp/tmp.vATWtU7EBf/file001.bin.crypt" file... done
+ set +x

*) Executing crypt command
+ ./crypt decrypt -i /tmp/tmp.vATWtU7EBf/file001.bin.crypt -o /tmp/tmp.vATWtU7EBf/file001.bin.plain -p 2dc02feb82507aad070aa527d6e2e75e70ce6cf2c0917c8a
Key: d36b965eb9651d49b395d8dafc9f95de908d4fd8bc3830f8960c5e7eff601b53
IV: b732737af747860ff9d3b2de7546b0a2
Reading "/tmp/tmp.vATWtU7EBf/file001.bin.crypt" file... done
Decrypting "/tmp/tmp.vATWtU7EBf/file001.bin.crypt" file to "/tmp/tmp.vATWtU7EBf/file001.bin.plain"... done
Writting "/tmp/tmp.vATWtU7EBf/file001.bin.plain" file... done
+ set +x
tests/file001.bin OK

----------------------------
- Testing encrypting using openssl command-line and decrypting using C program:
*) Executing openssl command
+ openssl enc -aes-256-cbc -k 2dc02feb82507aad070aa527d6e2e75e70ce6cf2c0917c8a -in tests/file001.bin -nosalt -p -out /tmp/tmp.vATWtU7EBf/file001.bin.cmd.crypt
key=D36B965EB9651D49B395D8DAFC9F95DE908D4FD8BC3830F8960C5E7EFF601B53
iv =B732737AF747860FF9D3B2DE7546B0A2
+ set +x

*) Executing crypt command
+ ./crypt decrypt -i /tmp/tmp.vATWtU7EBf/file001.bin.cmd.crypt -o /tmp/tmp.vATWtU7EBf/file001.bin.cmd.plain -p 2dc02feb82507aad070aa527d6e2e75e70ce6cf2c0917c8a
Key: d36b965eb9651d49b395d8dafc9f95de908d4fd8bc3830f8960c5e7eff601b53
IV: b732737af747860ff9d3b2de7546b0a2
Reading "/tmp/tmp.vATWtU7EBf/file001.bin.cmd.crypt" file... done
Decrypting "/tmp/tmp.vATWtU7EBf/file001.bin.cmd.crypt" file to "/tmp/tmp.vATWtU7EBf/file001.bin.cmd.plain"... done
Writting "/tmp/tmp.vATWtU7EBf/file001.bin.cmd.plain" file... done
+ set +x
tests/file001.bin OK command-line


========================================================================================

Processing tests/file002.bin file...

Using key:aeb573dbe8c46fcc7541d601563a6e9a6ba742ecbe5ea29d
- Testing encrypting and decrypting using C program:
*) Executing crypt command
+ ./crypt encrypt -i tests/file002.bin -o /tmp/tmp.v7wxvoQDbi/file002.bin.crypt -p aeb573dbe8c46fcc7541d601563a6e9a6ba742ecbe5ea29d
Key: 8601c5c4bec3dda4beae034078d1496a69bffcf4140fb0db2d068a626c233838
IV: 3ceeca9ed67d81028b85e83098f1b575
Reading "tests/file002.bin" file... done
Encrypting "tests/file002.bin" file to "/tmp/tmp.v7wxvoQDbi/file002.bin.crypt"... done
Writting "/tmp/tmp.v7wxvoQDbi/file002.bin.crypt" file... done
+ set +x

*) Executing crypt command
+ ./crypt decrypt -i /tmp/tmp.v7wxvoQDbi/file002.bin.crypt -o /tmp/tmp.v7wxvoQDbi/file002.bin.plain -p aeb573dbe8c46fcc7541d601563a6e9a6ba742ecbe5ea29d
Key: 8601c5c4bec3dda4beae034078d1496a69bffcf4140fb0db2d068a626c233838
IV: 3ceeca9ed67d81028b85e83098f1b575
Reading "/tmp/tmp.v7wxvoQDbi/file002.bin.crypt" file... done
Decrypting "/tmp/tmp.v7wxvoQDbi/file002.bin.crypt" file to "/tmp/tmp.v7wxvoQDbi/file002.bin.plain"... done
Writting "/tmp/tmp.v7wxvoQDbi/file002.bin.plain" file... done
+ set +x
tests/file002.bin OK

----------------------------
- Testing encrypting using openssl command-line and decrypting using C program:
*) Executing openssl command
+ openssl enc -aes-256-cbc -k aeb573dbe8c46fcc7541d601563a6e9a6ba742ecbe5ea29d -in tests/file002.bin -nosalt -p -out /tmp/tmp.v7wxvoQDbi/file002.bin.cmd.crypt
key=8601C5C4BEC3DDA4BEAE034078D1496A69BFFCF4140FB0DB2D068A626C233838
iv =3CEECA9ED67D81028B85E83098F1B575
+ set +x

*) Executing crypt command
+ ./crypt decrypt -i /tmp/tmp.v7wxvoQDbi/file002.bin.cmd.crypt -o /tmp/tmp.v7wxvoQDbi/file002.bin.cmd.plain -p aeb573dbe8c46fcc7541d601563a6e9a6ba742ecbe5ea29d
Key: 8601c5c4bec3dda4beae034078d1496a69bffcf4140fb0db2d068a626c233838
IV: 3ceeca9ed67d81028b85e83098f1b575
Reading "/tmp/tmp.v7wxvoQDbi/file002.bin.cmd.crypt" file... done
Decrypting "/tmp/tmp.v7wxvoQDbi/file002.bin.cmd.crypt" file to "/tmp/tmp.v7wxvoQDbi/file002.bin.cmd.plain"... done
Writting "/tmp/tmp.v7wxvoQDbi/file002.bin.cmd.plain" file... done
+ set +x
tests/file002.bin OK command-line


========================================================================================

Processing tests/file003.bin file...

Using key:edb5cdd18eceaf3128c8faae318478aec931b80b38023d54
- Testing encrypting and decrypting using C program:
*) Executing crypt command
+ ./crypt encrypt -i tests/file003.bin -o /tmp/tmp.7kJ4uykvq8/file003.bin.crypt -p edb5cdd18eceaf3128c8faae318478aec931b80b38023d54
Key: e2edddf68f9473f7fe4539a1911fffa0ef34d3bd8c8784dbc2a6cb10acaf803d
IV: 9a2ad36a65e720bf54cffc90bb65a112
Reading "tests/file003.bin" file... done
Encrypting "tests/file003.bin" file to "/tmp/tmp.7kJ4uykvq8/file003.bin.crypt"... done
Writting "/tmp/tmp.7kJ4uykvq8/file003.bin.crypt" file... done
+ set +x

*) Executing crypt command
+ ./crypt decrypt -i /tmp/tmp.7kJ4uykvq8/file003.bin.crypt -o /tmp/tmp.7kJ4uykvq8/file003.bin.plain -p edb5cdd18eceaf3128c8faae318478aec931b80b38023d54
Key: e2edddf68f9473f7fe4539a1911fffa0ef34d3bd8c8784dbc2a6cb10acaf803d
IV: 9a2ad36a65e720bf54cffc90bb65a112
Reading "/tmp/tmp.7kJ4uykvq8/file003.bin.crypt" file... done
Decrypting "/tmp/tmp.7kJ4uykvq8/file003.bin.crypt" file to "/tmp/tmp.7kJ4uykvq8/file003.bin.plain"... done
Writting "/tmp/tmp.7kJ4uykvq8/file003.bin.plain" file... done
+ set +x
tests/file003.bin OK

----------------------------
- Testing encrypting using openssl command-line and decrypting using C program:
*) Executing openssl command
+ openssl enc -aes-256-cbc -k edb5cdd18eceaf3128c8faae318478aec931b80b38023d54 -in tests/file003.bin -nosalt -p -out /tmp/tmp.7kJ4uykvq8/file003.bin.cmd.crypt
key=E2EDDDF68F9473F7FE4539A1911FFFA0EF34D3BD8C8784DBC2A6CB10ACAF803D
iv =9A2AD36A65E720BF54CFFC90BB65A112
+ set +x

*) Executing crypt command
+ ./crypt decrypt -i /tmp/tmp.7kJ4uykvq8/file003.bin.cmd.crypt -o /tmp/tmp.7kJ4uykvq8/file003.bin.cmd.plain -p edb5cdd18eceaf3128c8faae318478aec931b80b38023d54
Key: e2edddf68f9473f7fe4539a1911fffa0ef34d3bd8c8784dbc2a6cb10acaf803d
IV: 9a2ad36a65e720bf54cffc90bb65a112
Reading "/tmp/tmp.7kJ4uykvq8/file003.bin.cmd.crypt" file... done
Decrypting "/tmp/tmp.7kJ4uykvq8/file003.bin.cmd.crypt" file to "/tmp/tmp.7kJ4uykvq8/file003.bin.cmd.plain"... done
Writting "/tmp/tmp.7kJ4uykvq8/file003.bin.cmd.plain" file... done
+ set +x
tests/file003.bin OK command-line


========================================================================================

Processing tests/file004.bin file...

Using key:29476e36a3a9fc027381a6cb29d0fdcd3a934f86a8913418
- Testing encrypting and decrypting using C program:
*) Executing crypt command
+ ./crypt encrypt -i tests/file004.bin -o /tmp/tmp.wIZQVN9pWb/file004.bin.crypt -p 29476e36a3a9fc027381a6cb29d0fdcd3a934f86a8913418
Key: 39526688a6e3e5a917ee0f9ad4f9cc0cf51a64ce794c4ebab96f8d9f42d91c39
IV: 611ec8ead07ba2a34d2f04ab2b889efc
Reading "tests/file004.bin" file... done
Encrypting "tests/file004.bin" file to "/tmp/tmp.wIZQVN9pWb/file004.bin.crypt"... done
Writting "/tmp/tmp.wIZQVN9pWb/file004.bin.crypt" file... done
+ set +x

*) Executing crypt command
+ ./crypt decrypt -i /tmp/tmp.wIZQVN9pWb/file004.bin.crypt -o /tmp/tmp.wIZQVN9pWb/file004.bin.plain -p 29476e36a3a9fc027381a6cb29d0fdcd3a934f86a8913418
Key: 39526688a6e3e5a917ee0f9ad4f9cc0cf51a64ce794c4ebab96f8d9f42d91c39
IV: 611ec8ead07ba2a34d2f04ab2b889efc
Reading "/tmp/tmp.wIZQVN9pWb/file004.bin.crypt" file... done
Decrypting "/tmp/tmp.wIZQVN9pWb/file004.bin.crypt" file to "/tmp/tmp.wIZQVN9pWb/file004.bin.plain"... done
Writting "/tmp/tmp.wIZQVN9pWb/file004.bin.plain" file... done
+ set +x
tests/file004.bin OK

----------------------------
- Testing encrypting using openssl command-line and decrypting using C program:
*) Executing openssl command
+ openssl enc -aes-256-cbc -k 29476e36a3a9fc027381a6cb29d0fdcd3a934f86a8913418 -in tests/file004.bin -nosalt -p -out /tmp/tmp.wIZQVN9pWb/file004.bin.cmd.crypt
key=39526688A6E3E5A917EE0F9AD4F9CC0CF51A64CE794C4EBAB96F8D9F42D91C39
iv =611EC8EAD07BA2A34D2F04AB2B889EFC
+ set +x

*) Executing crypt command
+ ./crypt decrypt -i /tmp/tmp.wIZQVN9pWb/file004.bin.cmd.crypt -o /tmp/tmp.wIZQVN9pWb/file004.bin.cmd.plain -p 29476e36a3a9fc027381a6cb29d0fdcd3a934f86a8913418
Key: 39526688a6e3e5a917ee0f9ad4f9cc0cf51a64ce794c4ebab96f8d9f42d91c39
IV: 611ec8ead07ba2a34d2f04ab2b889efc
Reading "/tmp/tmp.wIZQVN9pWb/file004.bin.cmd.crypt" file... done
Decrypting "/tmp/tmp.wIZQVN9pWb/file004.bin.cmd.crypt" file to "/tmp/tmp.wIZQVN9pWb/file004.bin.cmd.plain"... done
Writting "/tmp/tmp.wIZQVN9pWb/file004.bin.cmd.plain" file... done
+ set +x
tests/file004.bin OK command-line
