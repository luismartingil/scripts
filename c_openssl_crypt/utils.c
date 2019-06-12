#include <openssl/conf.h>
#include <openssl/evp.h>
#include <openssl/err.h>
#include <string.h>

#include "utils.h"

#define BUFFER 40000

int read_file(char ** buf, char * file_name){
  printf("Reading \"%s\" file... ", file_name);
  FILE *f = fopen(file_name, "rb");
  if(f == NULL) {
    printf("failed\nError: File \"%s\" not found\n", file_name);
    exit(EXIT_FAILURE);
  }
  printf("done\n");
  fseek(f, 0, SEEK_END);
  long pos = ftell(f);
  rewind(f);  
  *buf = calloc((pos + 1), sizeof(char)  );
  fread(*buf, sizeof(char), pos, f);
  fclose(f);
  return pos;
}

int write_file(char * buf, int len, char * file_name){
  printf("Writting \"%s\" file... ", file_name);
  FILE *f = fopen(file_name, "w+");
  fwrite(buf, 1, len, f);
  if(f == NULL) {
    exit(EXIT_FAILURE);
  }  
  printf("done\n");
  fclose(f);
  return 1;
}

void handleErrors(void)
{
    ERR_print_errors_fp(stderr);
    abort();
}

int encrypt(unsigned char *plaintext, int plaintext_len, unsigned char *key,
            unsigned char *iv, unsigned char *ciphertext) {
    EVP_CIPHER_CTX *ctx;

    int len;

    int ciphertext_len;

    /* Create and initialise the context */
    if(!(ctx = EVP_CIPHER_CTX_new()))
        handleErrors();

    /*
     * Initialise the encryption operation. IMPORTANT - ensure you use a key
     * and IV size appropriate for your cipher
     * In this example we are using 256 bit AES (i.e. a 256 bit key). The
     * IV size for *most* modes is the same as the block size. For AES this
     * is 128 bits
     */
    if(1 != EVP_EncryptInit_ex(ctx, EVP_aes_256_cbc(), NULL, key, iv))
        handleErrors();

    /*
     * Provide the message to be encrypted, and obtain the encrypted output.
     * EVP_EncryptUpdate can be called multiple times if necessary
     */
    if(1 != EVP_EncryptUpdate(ctx, ciphertext, &len, plaintext, plaintext_len))
        handleErrors();
    ciphertext_len = len;

    /*
     * Finalise the encryption. Further ciphertext bytes may be written at
     * this stage.
     */
    if(1 != EVP_EncryptFinal_ex(ctx, ciphertext + len, &len))
        handleErrors();
    ciphertext_len += len;

    /* Clean up */
    EVP_CIPHER_CTX_free(ctx);

    return ciphertext_len;
}

int decrypt(unsigned char *ciphertext, int ciphertext_len, unsigned char *key,
            unsigned char *iv, unsigned char *plaintext) {
    EVP_CIPHER_CTX *ctx;

    int len;

    int plaintext_len;

    /* Create and initialise the context */
    if(!(ctx = EVP_CIPHER_CTX_new()))
        handleErrors();

    /*
     * Initialise the decryption operation. IMPORTANT - ensure you use a key
     * and IV size appropriate for your cipher
     * In this example we are using 256 bit AES (i.e. a 256 bit key). The
     * IV size for *most* modes is the same as the block size. For AES this
     * is 128 bits
     */
    if(1 != EVP_DecryptInit_ex(ctx, EVP_aes_256_cbc(), NULL, key, iv))
        handleErrors();

    /*
     * Provide the message to be decrypted, and obtain the plaintext output.
     * EVP_DecryptUpdate can be called multiple times if necessary.
     */
    if(1 != EVP_DecryptUpdate(ctx, plaintext, &len, ciphertext, ciphertext_len))
        handleErrors();
    plaintext_len = len;

    /*
     * Finalise the decryption. Further plaintext bytes may be written at
     * this stage.
     */
    if(1 != EVP_DecryptFinal_ex(ctx, plaintext + len, &len))
        handleErrors();
    plaintext_len += len;

    /* Clean up */
    EVP_CIPHER_CTX_free(ctx);

    return plaintext_len;
}

int crypt_file(char* operation, char *input_file, char * output_file,
	       char* password) {
  char* bytes;
  int len;
  long pos;

  const EVP_CIPHER *cipher;
  const EVP_MD *dgst = NULL;
  unsigned char key[EVP_MAX_KEY_LENGTH], iv[EVP_MAX_IV_LENGTH];
  const unsigned char *salt = NULL;
  int i;

  // Lets init the EVP structures - similar to what openssl enc will do:
  // openssl enc -aes-256-cbc -k ${PASSWORD} -in ${f} -nosalt
  // Thanks to: @indiv  https://stackoverflow.com/a/9500692/851428
  OpenSSL_add_all_algorithms();
  cipher = EVP_get_cipherbyname("aes-256-cbc");
  if(!cipher) { fprintf(stderr, "no such cipher\n"); return 1; }
  dgst=EVP_get_digestbyname("md5");
  if(!dgst) { fprintf(stderr, "no such digest\n"); return 1; }
  if(!EVP_BytesToKey(cipher, dgst, salt,
		     (unsigned char *) password,
		     strlen(password), 1, key, iv)) {
    fprintf(stderr, "EVP_BytesToKey failed\n");
    return 1;
  }
  // Going forward we can use this Key and IV
  printf("Key: "); for(i=0; i<cipher->key_len; ++i) { printf("%02x", key[i]); } printf("\n");
  printf("IV: "); for(i=0; i<cipher->iv_len; ++i) { printf("%02x", iv[i]); } printf("\n");

  // Reading the input file
  pos = read_file(&bytes, input_file);
  unsigned char* text = malloc((pos + BUFFER)*sizeof(char));

  // Detecting what the user wants to do
  if (strcmp(operation,"encrypt") == 0) {
    printf("Encrypting \"%s\" file to \"%s\"... ", input_file, output_file);
    len = encrypt((unsigned char*)bytes, pos, key, iv, text);
    printf("done\n");
  }  else if (strcmp(operation,"decrypt") == 0 ) {
    printf("Decrypting \"%s\" file to \"%s\"... ", input_file, output_file);
    len = decrypt((unsigned char*)bytes, pos, key, iv, text);
    printf("done\n");    
  } else {
    exit(EXIT_FAILURE);
  } 

  // Writting the output file
  write_file((char*) text, len, output_file);

  // Cleaning up
  free(text);
  free(bytes);
  return len;
}
