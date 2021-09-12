#!/bin/bash

Red='\e[1;31m'
Green='\e[1;32m'
Ggreen=$'\e[1;32m'

##redirect funtion for cleaner output
redirect(){
	"$@" &> /dev/null

}

##Making folders
echo -e "${Green} [-] Creating Directories"

mkdir output
mkdir tools

if [ -d "output" -a -d "tools" ] 
then
	echo -e "${Green} [-] Directories created"
else
	echo -e "${Green} [-] Can not create"
fi


###Building scripts
echo -e "${Green} [-] Building scripts"

CGEN="tools/c_gen"
ENCRYPTOR="tools/encryptor"
KEYGEN="tools/key_gen"

redirect gcc -o $CGEN c_gen.c
redirect gcc -o $ENCRYPTOR encryptor.c
redirect gcc -o $KEYGEN key_gen.c

if [[ -f $CGEN ]]; then
	echo -e "${Green} [-] C generator is created"
else
	echo -e "${Red} [-] C generator is not created"
fi

if [[ -f $ENCRYPTOR ]]; then
	echo -e "${Green} [-] Encryptor is created"
else
	echo -e "${Red} [-] Encryptor is not created"
fi

if [[ -f $KEYGEN ]]; then
	echo -e "${Green} [-] Key generator is created"
else
	echo -e "${Red} [-] Key generator is not created"
fi

###Installing mingw
echo -n "$Ggreen [-] Do you want to install mingw to compile main exploit here[y/n]: ";read option

if [ $option = "y" ]
then
	echo -e "${Green} [-] Installing mingw"
	redirect sudo apt install mingw-w64 -y
	echo -e "${Green} [-] Setup is done"
else
	echo -e "${Green} [-] Setup is done"
fi






