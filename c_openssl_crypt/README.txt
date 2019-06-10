```

$ make test
rm -f *.o *~ *.crypt crypt
gcc -g -Wall -Wextra -Werror -c crypt.c -o crypt.o
gcc -g -Wall -Wextra -Werror -c utils.c -o utils.o
gcc  crypt.o  utils.o -g -Wall -Wextra -Werror -o crypt -lm -lssl -lcrypto
./test.sh


========================================================================================

Processing tests/file001.bin file...

Using key:38e2ea27d1325ff90e12e4f6743c68684a935579b7030bf45df96a2b4cce090c93574464a1ac212638677de0f589d1eb
- Testing encrypting and decrypting using C program:
*) Executing crypt command
Key: aef7e5586f31d219f6c8e5da28a8226350d79d8c5305aa7fb0ef01cda1f95090
IV: 97247f9bb0eb0d25287c7ce27e970a46
Reading "tests/file001.bin" file... done
Encrypting "tests/file001.bin" file to "/tmp/tmp.MLW4NW4QZo/file001.bin.crypt"... done
Writting "/tmp/tmp.MLW4NW4QZo/file001.bin.crypt" file... done

*) Executing crypt command
Key: aef7e5586f31d219f6c8e5da28a8226350d79d8c5305aa7fb0ef01cda1f95090
IV: 97247f9bb0eb0d25287c7ce27e970a46
Reading "/tmp/tmp.MLW4NW4QZo/file001.bin.crypt" file... done
Decrypting "/tmp/tmp.MLW4NW4QZo/file001.bin.crypt" file to "/tmp/tmp.MLW4NW4QZo/file001.bin.plain"... done
Writting "/tmp/tmp.MLW4NW4QZo/file001.bin.plain" file... done
tests/file001.bin OK

----------------------------
- Testing encrypting using openssl command-line and decrypting using C program:
*) Executing openssl command
+ openssl enc -aes-256-cbc -k 38e2ea27d1325ff90e12e4f6743c68684a935579b7030bf45df96a2b4cce090c93574464a1ac212638677de0f589d1eb -in tests/file001.bin -nosalt -p -out /tmp/tmp.MLW4NW4QZo/file001.bin.cmd.crypt
key=AEF7E5586F31D219F6C8E5DA28A8226350D79D8C5305AA7FB0EF01CDA1F95090
iv =97247F9BB0EB0D25287C7CE27E970A46
+ set +x

*) Executing crypt command
Key: aef7e5586f31d219f6c8e5da28a8226350d79d8c5305aa7fb0ef01cda1f95090
IV: 97247f9bb0eb0d25287c7ce27e970a46
Reading "/tmp/tmp.MLW4NW4QZo/file001.bin.cmd.crypt" file... done
Decrypting "/tmp/tmp.MLW4NW4QZo/file001.bin.cmd.crypt" file to "/tmp/tmp.MLW4NW4QZo/file001.bin.cmd.plain"... done
Writting "/tmp/tmp.MLW4NW4QZo/file001.bin.cmd.plain" file... done
tests/file001.bin OK command-line


========================================================================================

Processing tests/file002.bin file...

Using key:4a7aea2cfa6c0295a168df12d7191e43429ada8f98017ed17e0b02b6e2958e6eb1994ddf9fea4ab5b3e0b45cb6f11c72
- Testing encrypting and decrypting using C program:
*) Executing crypt command
Key: 4ffb327d6ad875e9dbbc383711fa45ac61718647350550b73e8a1432d986f628
IV: 850cc07938a9241c9e7e7cf19aefa7b5
Reading "tests/file002.bin" file... done
Encrypting "tests/file002.bin" file to "/tmp/tmp.tSCLuGEmWj/file002.bin.crypt"... done
Writting "/tmp/tmp.tSCLuGEmWj/file002.bin.crypt" file... done

*) Executing crypt command
Key: 4ffb327d6ad875e9dbbc383711fa45ac61718647350550b73e8a1432d986f628
IV: 850cc07938a9241c9e7e7cf19aefa7b5
Reading "/tmp/tmp.tSCLuGEmWj/file002.bin.crypt" file... done
Decrypting "/tmp/tmp.tSCLuGEmWj/file002.bin.crypt" file to "/tmp/tmp.tSCLuGEmWj/file002.bin.plain"... done
Writting "/tmp/tmp.tSCLuGEmWj/file002.bin.plain" file... done
tests/file002.bin OK

----------------------------
- Testing encrypting using openssl command-line and decrypting using C program:
*) Executing openssl command
+ openssl enc -aes-256-cbc -k 4a7aea2cfa6c0295a168df12d7191e43429ada8f98017ed17e0b02b6e2958e6eb1994ddf9fea4ab5b3e0b45cb6f11c72 -in tests/file002.bin -nosalt -p -out /tmp/tmp.tSCLuGEmWj/file002.bin.cmd.crypt
key=4FFB327D6AD875E9DBBC383711FA45AC61718647350550B73E8A1432D986F628
iv =850CC07938A9241C9E7E7CF19AEFA7B5
+ set +x

*) Executing crypt command
Key: 4ffb327d6ad875e9dbbc383711fa45ac61718647350550b73e8a1432d986f628
IV: 850cc07938a9241c9e7e7cf19aefa7b5
Reading "/tmp/tmp.tSCLuGEmWj/file002.bin.cmd.crypt" file... done
Decrypting "/tmp/tmp.tSCLuGEmWj/file002.bin.cmd.crypt" file to "/tmp/tmp.tSCLuGEmWj/file002.bin.cmd.plain"... done
Writting "/tmp/tmp.tSCLuGEmWj/file002.bin.cmd.plain" file... done
tests/file002.bin OK command-line


========================================================================================

Processing tests/file003.bin file...

Using key:c98c458d836563d9633dd8a970e8b88474a2a3db2363647dc029883015d3e3990f2096277be5b4520d68c1b562a851e0
- Testing encrypting and decrypting using C program:
*) Executing crypt command
Key: 098757663f6458089131d2e5a0b272e811e4ff796b1ba852d11d3ed1d5e99502
IV: 5b0876fbafdd3b78116d555c48b605d0
Reading "tests/file003.bin" file... done
Encrypting "tests/file003.bin" file to "/tmp/tmp.DMEsczXlmH/file003.bin.crypt"... done
Writting "/tmp/tmp.DMEsczXlmH/file003.bin.crypt" file... done

*) Executing crypt command
Key: 098757663f6458089131d2e5a0b272e811e4ff796b1ba852d11d3ed1d5e99502
IV: 5b0876fbafdd3b78116d555c48b605d0
Reading "/tmp/tmp.DMEsczXlmH/file003.bin.crypt" file... done
Decrypting "/tmp/tmp.DMEsczXlmH/file003.bin.crypt" file to "/tmp/tmp.DMEsczXlmH/file003.bin.plain"... done
Writting "/tmp/tmp.DMEsczXlmH/file003.bin.plain" file... done
tests/file003.bin OK

----------------------------
- Testing encrypting using openssl command-line and decrypting using C program:
*) Executing openssl command
+ openssl enc -aes-256-cbc -k c98c458d836563d9633dd8a970e8b88474a2a3db2363647dc029883015d3e3990f2096277be5b4520d68c1b562a851e0 -in tests/file003.bin -nosalt -p -out /tmp/tmp.DMEsczXlmH/file003.bin.cmd.crypt
key=098757663F6458089131D2E5A0B272E811E4FF796B1BA852D11D3ED1D5E99502
iv =5B0876FBAFDD3B78116D555C48B605D0
+ set +x

*) Executing crypt command
Key: 098757663f6458089131d2e5a0b272e811e4ff796b1ba852d11d3ed1d5e99502
IV: 5b0876fbafdd3b78116d555c48b605d0
Reading "/tmp/tmp.DMEsczXlmH/file003.bin.cmd.crypt" file... done
Decrypting "/tmp/tmp.DMEsczXlmH/file003.bin.cmd.crypt" file to "/tmp/tmp.DMEsczXlmH/file003.bin.cmd.plain"... done
Writting "/tmp/tmp.DMEsczXlmH/file003.bin.cmd.plain" file... done
tests/file003.bin OK command-line


========================================================================================

Processing tests/file004.bin file...

Using key:7be87b8de9aa165b707b44997e439028c8f71e4b81de4f2459065204ba0cbbe3598a68621eba0c9d8a4b659b7360bc5a
- Testing encrypting and decrypting using C program:
*) Executing crypt command
Key: bd5db0c711ab2e65538d20480fa5321add312c90717514b185c34ddb71a600e9
IV: eefdd976c2221f0341fcf759e7d6006a
Reading "tests/file004.bin" file... done
Encrypting "tests/file004.bin" file to "/tmp/tmp.dp7FT0lLhC/file004.bin.crypt"... done
Writting "/tmp/tmp.dp7FT0lLhC/file004.bin.crypt" file... done

*) Executing crypt command
Key: bd5db0c711ab2e65538d20480fa5321add312c90717514b185c34ddb71a600e9
IV: eefdd976c2221f0341fcf759e7d6006a
Reading "/tmp/tmp.dp7FT0lLhC/file004.bin.crypt" file... done
Decrypting "/tmp/tmp.dp7FT0lLhC/file004.bin.crypt" file to "/tmp/tmp.dp7FT0lLhC/file004.bin.plain"... done
Writting "/tmp/tmp.dp7FT0lLhC/file004.bin.plain" file... done
tests/file004.bin OK

----------------------------
- Testing encrypting using openssl command-line and decrypting using C program:
*) Executing openssl command
+ openssl enc -aes-256-cbc -k 7be87b8de9aa165b707b44997e439028c8f71e4b81de4f2459065204ba0cbbe3598a68621eba0c9d8a4b659b7360bc5a -in tests/file004.bin -nosalt -p -out /tmp/tmp.dp7FT0lLhC/file004.bin.cmd.crypt
key=BD5DB0C711AB2E65538D20480FA5321ADD312C90717514B185C34DDB71A600E9
iv =EEFDD976C2221F0341FCF759E7D6006A
+ set +x

*) Executing crypt command
Key: bd5db0c711ab2e65538d20480fa5321add312c90717514b185c34ddb71a600e9
IV: eefdd976c2221f0341fcf759e7d6006a
Reading "/tmp/tmp.dp7FT0lLhC/file004.bin.cmd.crypt" file... done
Decrypting "/tmp/tmp.dp7FT0lLhC/file004.bin.cmd.crypt" file to "/tmp/tmp.dp7FT0lLhC/file004.bin.cmd.plain"... done
Writting "/tmp/tmp.dp7FT0lLhC/file004.bin.cmd.plain" file... done
tests/file004.bin OK command-line

```
