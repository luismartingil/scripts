/*
  crypt is a tool to encrypt/decrypt a file given a password
*/

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <getopt.h>
#include <string.h>

#include "utils.h"

void print_usage(char* name) {
  printf("crypt is a tool to encrypt/decrypt a file given a password\n");
  printf("\n");
  printf("Usage:\n\tcrypt (encrypt|decrypt) -i <input-file> -o <output-file> -p <password>\n");
  printf("\n");
  printf("Arguments:\n\tinput-file\tfile with the content to encrypt/decrypt\n");
  printf("\toutput-file\tfile to save encrypted/decrypted message\n");
  printf("\tpassword\tprivate key to encrypt/decrypt a message\n");
  printf("\n");
  printf("Examples:\n\t%s encrypt -i message.txt -o private.crypt -p 6de550be1ea85eec994e64a381\n", name);
  printf("\t%s decrypt -i private.crypt -o decrypted.txt -p 6de550be1ea85eec994e64a381\n", name);
  printf("\n");
}

int main(int argc, char*argv[]) {
  int option;
  char* input_file = NULL;
  char* output_file = NULL;
  char* password = NULL;
  char* operation = NULL;
  int counter = 0;
  
  //Specifying the expected options
  while ((option = getopt(argc, argv,"i:o:p:")) != -1) {
    switch (option) {
    case 'i' : input_file = optarg;
      break;
    case 'o' : output_file = optarg;
      break;
    case 'p' : password = optarg;
      break;
    default: print_usage(argv[0]);
      exit(EXIT_FAILURE);
    }
  }
  
  for (option = optind; option < argc; option++) {
    counter = counter + 1;
    operation = argv[option];
  }
  
  if (input_file == NULL || output_file == NULL || password == NULL || counter != 1 ) {
    print_usage(argv[0]);
    exit(EXIT_FAILURE);
  }

  int ret = crypt_file(operation, input_file, output_file, password);
  return ret;
}
