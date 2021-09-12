
//function to decode xor
void decode_xor(const unsigned char *encryptedtext, const int encryptedtext_length, const unsigned char *key, const int key_length, unsigned char *plaintext) {

	for(int i = 0; i < encryptedtext_length; i++) {
		plaintext[i] = encryptedtext[i] ^ key[i % key_length];
	}	
}