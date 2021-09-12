## Antivirus Evasion
These script will create a custom payload form msfvenom for anti-virus evasion

## Usage
Run the set up script to setup every thing

```bash
chmod +x setup.sh
```
Then 
```bash
./setup.sh
```

To create a 64 bit payload
```bash
cd _x64_builder && chmod +x *.sh
```
To create a 32 bit payload
```bash
cd _x32_builder && chmod +x *.sh
```

To generate payload run the scripts from respective folders

After building every thing will be in output folder and a listner file will be created called meta.rc

## Building the final exploit
The script will automatically build the script but if you want to do it manually then do the following

## Windows
For 32 bit
```bash
gcc -m32 -o output.exe main_exploit.c
```
For 64 bit
```bash
gcc -m64 -o output.exe main_exploit.c
```
## Linux(mingw required)
For 32 bit
```bash
i686-w64-mingw32-gcc -o output.exe main_exploit.c
```
For 64 bit
```bash
x86_64-w64-mingw32-gcc -o output.exe main_exploit.c
```

## Final exploit usage
Run the following command in victim machine
```bash
.\exploit.exe enc_shellcode.txt key.txt [pid]
```
**pid:- Process id**
**Note:- The process should not be running as a elevated user**

## Technique used
The script usage the following techniques for evasion

1. The script will do nothing for first 1 minute to bypass runtime analysis.

2. Then it will try to open a system file to check if it's running in a emulated enviornment.If so then it will exit.

3. The final exe require command line arguments to run properly.

4. The whole payload is encoded with xor algo.The exe will decrypt it on runtime and stores it in memory so the final payload never stored in disk

5. Then it will be injected into a process. If the process is a legit windows process(Like notepad,explorer.exe) then it will not trigger av.

## TODO
1. Create a dropper script

2. Hide everything by alternate data stream

3. Apply the defender exception rules on the malware folder

4. Download the encrypted shellcode and key from a server in runtime

5. Hardcode the variable and function names