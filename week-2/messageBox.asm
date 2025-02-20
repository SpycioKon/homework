.386
.model flat, stdcall
option casemap:none

include C:\masm32\include\windows.inc
include C:\masm32\include\user32.inc
include C:\masm32\include\kernel32.inc

includelib C:\masm32\lib\user32.lib
includelib C:\masm32\lib\kernel32.lib

.data
    msgTitle db "Message Box", 0
    msgText db "Hello, this is a message box!", 0

.code
start:
    ; Call MessageBoxW (the Unicode version)
    invoke MessageBox, NULL, addr msgText, addr msgTitle, MB_OK

    ; Exit program
    invoke ExitProcess, 0

end start