//c program to apply xor operation on raw payload
//argument list
//argv[1] = Name of the file which contain the raw payload
//argv[2] = Name of the key file
//argv[3] = Name of the file to store encrypted payload

#include <stdio.h>
#include <stdlib.h>
#include "headers/file_handler.h"


// XORs the plaintext with key bytes and stores the result in ciphertext.

void xor_encode(const unsigned char *plaintext, const int plaintext_length, const unsigned char *key, const int key_length, unsigned char *ciphertext) {
    for(int i = 0; i < plaintext_length; i++) {
		ciphertext[i] = plaintext[i] ^ key[i % key_length];
	}
}



int main(int argc, char **argv) {	
	int payload_size;
    int key_length;	

    //printf("Starting XOR encoder...\n");
    
	// Read payload from file into memory
    printf("[*] Reading payload from file %s, expecting raw format.\n", argv[1]);	
    unsigned char *payload = data_from_file_raw(argv[1], &payload_size);
    printf("[*] payload size in bytes is %d\n", payload_size);

    // Read encryption key from file into memory
    printf("[*] Reading key from file %s, expecting raw format.\n", argv[2]);
    unsigned char *key = data_from_file_raw(argv[2], &key_length);
    printf("[*] Key length in bytes is %d\n", key_length);

    // Encrypt and write ciphertext to file
	unsigned char *ciphertext = (unsigned char *) malloc(payload_size);
    //printf("Applying XOR algorithm\n");
	xor_encode(payload, payload_size, key, key_length, ciphertext);	
    printf("[*] Writing payload to file %s\n", argv[3]);
	data_to_file_raw(ciphertext, payload_size, argv[3]);
	return 0;
}
