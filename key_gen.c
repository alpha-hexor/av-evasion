//c program to create a key for xor opration from command line argument
//argument lists
//argv[1] = raw hex key(ex:- aabbcc13df)
//argv[2] = output file name
#include<stdio.h>
#include<stdlib.h>

#include<string.h>

#include "headers/file_handler.h"

unsigned char *generate_key(char *arg1,int *data_size){
    //get key length
    int input_length = strlen(arg1);

    //convert ASCII hex string to raw
    char current_hex[5] = "0xaa";

    //each data byte is represented by 2 ASCII symbols
    *data_size = input_length/2;

    unsigned char *data= (unsigned char * )malloc(*data_size);

    int j=0;
    char *endptr;
    int i;

    for(i=0;i<input_length;i++){
        memcpy(&(current_hex[2]), &(arg1[2*i]), 2);
        data[j] = (unsigned char) strtoul(current_hex, &endptr, 16);
        j++;
    }
    return data;

}

int main(int argc,char **argv){
    int key_length = 0;
    unsigned char *key = 0;

    key = generate_key(argv[1],&key_length);

    data_to_file_raw(key,key_length,argv[2]);

    return 0;
}
