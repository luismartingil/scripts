$ make test
rm -f *.o *~ *.crypt crypt
gcc -g -Wall -Wextra -Werror -c crypt.c -o crypt.o
gcc -g -Wall -Wextra -Werror -c utils.c -o utils.o
gcc  crypt.o  utils.o -g -Wall -Wextra -Werror -o crypt -lm -lssl -lcrypto
./test.sh


========================================================================================

Processing tests/file001.bin file...

Using key:66f4d2241081c67b1cb599b2547dcbf5410b9671390e83aa0598d383277f11691638098afb9ccd361b22d28df7d95e86
- Testing encrypting and decrypting using C program:
*) Executing crypt command
+ ./crypt encrypt -i tests/file001.bin -o /tmp/tmp.5iRxxhS0YQ/file001.bin.crypt -p 66f4d2241081c67b1cb599b2547dcbf5410b9671390e83aa0598d383277f11691638098afb9ccd361b22d28df7d95e86
Key: 70f10376342c92f802af80e928b10c44376221122f8c90f8987385af2c1b1083
IV: 36f70c5b6208c833a177fead5d4ae4b9
Reading "tests/file001.bin" file... done
Encrypting "tests/file001.bin" file to "/tmp/tmp.5iRxxhS0YQ/file001.bin.crypt"... done
Writting "/tmp/tmp.5iRxxhS0YQ/file001.bin.crypt" file... done
+ set +x

*) Executing crypt command
+ ./crypt decrypt -i /tmp/tmp.5iRxxhS0YQ/file001.bin.crypt -o /tmp/tmp.5iRxxhS0YQ/file001.bin.plain -p 66f4d2241081c67b1cb599b2547dcbf5410b9671390e83aa0598d383277f11691638098afb9ccd361b22d28df7d95e86
Key: 70f10376342c92f802af80e928b10c44376221122f8c90f8987385af2c1b1083
IV: 36f70c5b6208c833a177fead5d4ae4b9
Reading "/tmp/tmp.5iRxxhS0YQ/file001.bin.crypt" file... done
Decrypting "/tmp/tmp.5iRxxhS0YQ/file001.bin.crypt" file to "/tmp/tmp.5iRxxhS0YQ/file001.bin.plain"... done
Writting "/tmp/tmp.5iRxxhS0YQ/file001.bin.plain" file... done
+ set +x
tests/file001.bin OK

----------------------------
- Testing encrypting using openssl command-line and decrypting using C program:
*) Executing openssl command
+ openssl enc -aes-256-cbc -k 66f4d2241081c67b1cb599b2547dcbf5410b9671390e83aa0598d383277f11691638098afb9ccd361b22d28df7d95e86 -in tests/file001.bin -nosalt -p -out /tmp/tmp.5iRxxhS0YQ/file001.bin.cmd.crypt
key=70F10376342C92F802AF80E928B10C44376221122F8C90F8987385AF2C1B1083
iv =36F70C5B6208C833A177FEAD5D4AE4B9
+ set +x

*) Executing crypt command
+ ./crypt decrypt -i /tmp/tmp.5iRxxhS0YQ/file001.bin.cmd.crypt -o /tmp/tmp.5iRxxhS0YQ/file001.bin.cmd.plain -p 66f4d2241081c67b1cb599b2547dcbf5410b9671390e83aa0598d383277f11691638098afb9ccd361b22d28df7d95e86
Key: 70f10376342c92f802af80e928b10c44376221122f8c90f8987385af2c1b1083
IV: 36f70c5b6208c833a177fead5d4ae4b9
Reading "/tmp/tmp.5iRxxhS0YQ/file001.bin.cmd.crypt" file... done
Decrypting "/tmp/tmp.5iRxxhS0YQ/file001.bin.cmd.crypt" file to "/tmp/tmp.5iRxxhS0YQ/file001.bin.cmd.plain"... done
Writting "/tmp/tmp.5iRxxhS0YQ/file001.bin.cmd.plain" file... done
+ set +x
tests/file001.bin OK command-line


========================================================================================

Processing tests/file002.bin file...

Using key:b4adabcd37acbdbf7a834582e69f935286fa815158373d752a690d4a1568c8696e2542e9b58829fb53c8b9f978854097
- Testing encrypting and decrypting using C program:
*) Executing crypt command
+ ./crypt encrypt -i tests/file002.bin -o /tmp/tmp.8ulDjIkjoP/file002.bin.crypt -p b4adabcd37acbdbf7a834582e69f935286fa815158373d752a690d4a1568c8696e2542e9b58829fb53c8b9f978854097
Key: 59dcda8648fcac48f616f02f454ed9fd2d0438bf7dc95b412433f2f0377b580f
IV: 2e1d65d23e0262bc6653ca3d5906904c
Reading "tests/file002.bin" file... done
Encrypting "tests/file002.bin" file to "/tmp/tmp.8ulDjIkjoP/file002.bin.crypt"... done
Writting "/tmp/tmp.8ulDjIkjoP/file002.bin.crypt" file... done
+ set +x

*) Executing crypt command
+ ./crypt decrypt -i /tmp/tmp.8ulDjIkjoP/file002.bin.crypt -o /tmp/tmp.8ulDjIkjoP/file002.bin.plain -p b4adabcd37acbdbf7a834582e69f935286fa815158373d752a690d4a1568c8696e2542e9b58829fb53c8b9f978854097
Key: 59dcda8648fcac48f616f02f454ed9fd2d0438bf7dc95b412433f2f0377b580f
IV: 2e1d65d23e0262bc6653ca3d5906904c
Reading "/tmp/tmp.8ulDjIkjoP/file002.bin.crypt" file... done
Decrypting "/tmp/tmp.8ulDjIkjoP/file002.bin.crypt" file to "/tmp/tmp.8ulDjIkjoP/file002.bin.plain"... done
Writting "/tmp/tmp.8ulDjIkjoP/file002.bin.plain" file... done
+ set +x
tests/file002.bin OK

----------------------------
- Testing encrypting using openssl command-line and decrypting using C program:
*) Executing openssl command
+ openssl enc -aes-256-cbc -k b4adabcd37acbdbf7a834582e69f935286fa815158373d752a690d4a1568c8696e2542e9b58829fb53c8b9f978854097 -in tests/file002.bin -nosalt -p -out /tmp/tmp.8ulDjIkjoP/file002.bin.cmd.crypt
key=59DCDA8648FCAC48F616F02F454ED9FD2D0438BF7DC95B412433F2F0377B580F
iv =2E1D65D23E0262BC6653CA3D5906904C
+ set +x

*) Executing crypt command
+ ./crypt decrypt -i /tmp/tmp.8ulDjIkjoP/file002.bin.cmd.crypt -o /tmp/tmp.8ulDjIkjoP/file002.bin.cmd.plain -p b4adabcd37acbdbf7a834582e69f935286fa815158373d752a690d4a1568c8696e2542e9b58829fb53c8b9f978854097
Key: 59dcda8648fcac48f616f02f454ed9fd2d0438bf7dc95b412433f2f0377b580f
IV: 2e1d65d23e0262bc6653ca3d5906904c
Reading "/tmp/tmp.8ulDjIkjoP/file002.bin.cmd.crypt" file... done
Decrypting "/tmp/tmp.8ulDjIkjoP/file002.bin.cmd.crypt" file to "/tmp/tmp.8ulDjIkjoP/file002.bin.cmd.plain"... done
Writting "/tmp/tmp.8ulDjIkjoP/file002.bin.cmd.plain" file... done
+ set +x
tests/file002.bin OK command-line


========================================================================================

Processing tests/file003.bin file...

Using key:e2d4da463be98036349947b58175b5ee467e8e4f256e266bb2883bc32f738315dafa5234ddc105f19b9049fde88752ad
- Testing encrypting and decrypting using C program:
*) Executing crypt command
+ ./crypt encrypt -i tests/file003.bin -o /tmp/tmp.oYXQC0C5Fi/file003.bin.crypt -p e2d4da463be98036349947b58175b5ee467e8e4f256e266bb2883bc32f738315dafa5234ddc105f19b9049fde88752ad
Key: 54cbd08f63ac1f0e1f0fef9d75e6555adf5c8abfaad94a5b5780e30b8152630c
IV: 6e50af5d943ddc4f6354b871ecc79b5d
Reading "tests/file003.bin" file... done
Encrypting "tests/file003.bin" file to "/tmp/tmp.oYXQC0C5Fi/file003.bin.crypt"... done
Writting "/tmp/tmp.oYXQC0C5Fi/file003.bin.crypt" file... done
+ set +x

*) Executing crypt command
+ ./crypt decrypt -i /tmp/tmp.oYXQC0C5Fi/file003.bin.crypt -o /tmp/tmp.oYXQC0C5Fi/file003.bin.plain -p e2d4da463be98036349947b58175b5ee467e8e4f256e266bb2883bc32f738315dafa5234ddc105f19b9049fde88752ad
Key: 54cbd08f63ac1f0e1f0fef9d75e6555adf5c8abfaad94a5b5780e30b8152630c
IV: 6e50af5d943ddc4f6354b871ecc79b5d
Reading "/tmp/tmp.oYXQC0C5Fi/file003.bin.crypt" file... done
Decrypting "/tmp/tmp.oYXQC0C5Fi/file003.bin.crypt" file to "/tmp/tmp.oYXQC0C5Fi/file003.bin.plain"... done
Writting "/tmp/tmp.oYXQC0C5Fi/file003.bin.plain" file... done
+ set +x
tests/file003.bin OK

----------------------------
- Testing encrypting using openssl command-line and decrypting using C program:
*) Executing openssl command
+ openssl enc -aes-256-cbc -k e2d4da463be98036349947b58175b5ee467e8e4f256e266bb2883bc32f738315dafa5234ddc105f19b9049fde88752ad -in tests/file003.bin -nosalt -p -out /tmp/tmp.oYXQC0C5Fi/file003.bin.cmd.crypt
key=54CBD08F63AC1F0E1F0FEF9D75E6555ADF5C8ABFAAD94A5B5780E30B8152630C
iv =6E50AF5D943DDC4F6354B871ECC79B5D
+ set +x

*) Executing crypt command
+ ./crypt decrypt -i /tmp/tmp.oYXQC0C5Fi/file003.bin.cmd.crypt -o /tmp/tmp.oYXQC0C5Fi/file003.bin.cmd.plain -p e2d4da463be98036349947b58175b5ee467e8e4f256e266bb2883bc32f738315dafa5234ddc105f19b9049fde88752ad
Key: 54cbd08f63ac1f0e1f0fef9d75e6555adf5c8abfaad94a5b5780e30b8152630c
IV: 6e50af5d943ddc4f6354b871ecc79b5d
Reading "/tmp/tmp.oYXQC0C5Fi/file003.bin.cmd.crypt" file... done
Decrypting "/tmp/tmp.oYXQC0C5Fi/file003.bin.cmd.crypt" file to "/tmp/tmp.oYXQC0C5Fi/file003.bin.cmd.plain"... done
Writting "/tmp/tmp.oYXQC0C5Fi/file003.bin.cmd.plain" file... done
+ set +x
tests/file003.bin OK command-line


========================================================================================

Processing tests/file004.bin file...

Using key:5cff21fabb6f0b77ae89f2e08571704aa5956472763e7a980bf4d4e02dc9337fb6fd74809235e3ba57c55c6f9a68d0e4
- Testing encrypting and decrypting using C program:
*) Executing crypt command
+ ./crypt encrypt -i tests/file004.bin -o /tmp/tmp.QZVjJ6hbJE/file004.bin.crypt -p 5cff21fabb6f0b77ae89f2e08571704aa5956472763e7a980bf4d4e02dc9337fb6fd74809235e3ba57c55c6f9a68d0e4
Key: d1ba7a2083ba9604ec837915afc7bb2927055552cf6a278acd8c197be1e384f4
IV: e278baff83a4a8bf68ba2378cbce6073
Reading "tests/file004.bin" file... done
Encrypting "tests/file004.bin" file to "/tmp/tmp.QZVjJ6hbJE/file004.bin.crypt"... done
Writting "/tmp/tmp.QZVjJ6hbJE/file004.bin.crypt" file... done
+ set +x

*) Executing crypt command
+ ./crypt decrypt -i /tmp/tmp.QZVjJ6hbJE/file004.bin.crypt -o /tmp/tmp.QZVjJ6hbJE/file004.bin.plain -p 5cff21fabb6f0b77ae89f2e08571704aa5956472763e7a980bf4d4e02dc9337fb6fd74809235e3ba57c55c6f9a68d0e4
Key: d1ba7a2083ba9604ec837915afc7bb2927055552cf6a278acd8c197be1e384f4
IV: e278baff83a4a8bf68ba2378cbce6073
Reading "/tmp/tmp.QZVjJ6hbJE/file004.bin.crypt" file... done
Decrypting "/tmp/tmp.QZVjJ6hbJE/file004.bin.crypt" file to "/tmp/tmp.QZVjJ6hbJE/file004.bin.plain"... done
Writting "/tmp/tmp.QZVjJ6hbJE/file004.bin.plain" file... done
+ set +x
tests/file004.bin OK

----------------------------
- Testing encrypting using openssl command-line and decrypting using C program:
*) Executing openssl command
+ openssl enc -aes-256-cbc -k 5cff21fabb6f0b77ae89f2e08571704aa5956472763e7a980bf4d4e02dc9337fb6fd74809235e3ba57c55c6f9a68d0e4 -in tests/file004.bin -nosalt -p -out /tmp/tmp.QZVjJ6hbJE/file004.bin.cmd.crypt
key=D1BA7A2083BA9604EC837915AFC7BB2927055552CF6A278ACD8C197BE1E384F4
iv =E278BAFF83A4A8BF68BA2378CBCE6073
+ set +x

*) Executing crypt command
+ ./crypt decrypt -i /tmp/tmp.QZVjJ6hbJE/file004.bin.cmd.crypt -o /tmp/tmp.QZVjJ6hbJE/file004.bin.cmd.plain -p 5cff21fabb6f0b77ae89f2e08571704aa5956472763e7a980bf4d4e02dc9337fb6fd74809235e3ba57c55c6f9a68d0e4
Key: d1ba7a2083ba9604ec837915afc7bb2927055552cf6a278acd8c197be1e384f4
IV: e278baff83a4a8bf68ba2378cbce6073
Reading "/tmp/tmp.QZVjJ6hbJE/file004.bin.cmd.crypt" file... done
Decrypting "/tmp/tmp.QZVjJ6hbJE/file004.bin.cmd.crypt" file to "/tmp/tmp.QZVjJ6hbJE/file004.bin.cmd.plain"... done
Writting "/tmp/tmp.QZVjJ6hbJE/file004.bin.cmd.plain" file... done
+ set +x
tests/file004.bin OK command-line
