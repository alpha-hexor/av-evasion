//c to convert raw things to understandable c format
//payload -> c shellcode
//key -> an array
//arguments
//argv[1] = source file
//argv[2] = destination file
//argv[3] = variable name

#include "headers/file_handler.h"

int main(int argc, char **argv) {
    int data_size;
    unsigned char *data = data_from_file_raw(argv[1], &data_size);
    data_to_file(data, data_size, argv[2], argv[3]);
    return 0;
}