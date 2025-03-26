.386
.model flat, stdcall
option casemap:none

include C:\masm32\include\windows.inc
include C:\masm32\include\user32.inc
include C:\masm32\include\kernel32.inc

includelib C:\masm32\lib\user32.lib
includelib C:\masm32\lib\kernel32.lib

.const
IDC_EDIT    equ 1001
IDC_BUTTON  equ 1002

.data
ClassName   db "WinClass",0
AppName     db "Show message",0
ButtonText  db "Show",0
EditClass   db "EDIT",0
ButtonClass db "BUTTON",0
MsgTitle    db "Message",0

.data?
hInstance   dd ?
hwnd        dd ?
hwndEdit    dd ?
hwndButton  dd ?
msg         MSG <>
wc          WNDCLASSEX <>
buffer      db 256 dup(?)

.code
WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
    cmp [uMsg], WM_CREATE
    je wm_create
    cmp [uMsg], WM_COMMAND
    je wm_command
    cmp [uMsg], WM_DESTROY
    je wm_destroy
    jmp def_proc

wm_create:
    ; T?o Edit control
    invoke CreateWindowEx, 0, addr EditClass, 0,
           WS_CHILD or WS_VISIBLE or WS_BORDER,
           20, 20, 200, 25,
           [hWnd], IDC_EDIT,
           [hInstance], 0
    mov [hwndEdit], eax

    ; T?o Button control
    invoke CreateWindowEx, 0, addr ButtonClass, addr ButtonText,
           WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,
           20, 50, 80, 30,
           [hWnd], IDC_BUTTON,
           [hInstance], 0
    mov [hwndButton], eax
    xor eax, eax
    ret

wm_command:
    mov eax, [wParam]
    cmp ax, IDC_BUTTON
    jne cmd_exit
    ; L?y text t? Edit control
    invoke GetWindowText, [hwndEdit], addr buffer, 256
    ; Hi?n th? MessageBox
    invoke MessageBox, [hWnd], addr buffer, addr MsgTitle, MB_OK or MB_ICONINFORMATION
cmd_exit:
    xor eax, eax
    ret

wm_destroy:
    invoke PostQuitMessage, 0
    xor eax, eax
    ret

def_proc:
    invoke DefWindowProc, [hWnd], [uMsg], [wParam], [lParam]
    ret
WndProc endp

start:
    invoke GetModuleHandle, NULL
    mov [hInstance], eax

    ; Kh?i t?o WNDCLASSEX
    mov [wc.cbSize], sizeof WNDCLASSEX
    mov [wc.style], CS_HREDRAW or CS_VREDRAW
    mov [wc.lpfnWndProc], offset WndProc
    mov [wc.cbClsExtra], 0
    mov [wc.cbWndExtra], 0
    mov eax, [hInstance]
    mov [wc.hInstance], eax
    invoke LoadIcon, NULL, IDI_APPLICATION
    mov [wc.hIcon], eax
    mov [wc.hIconSm], eax
    invoke LoadCursor, NULL, IDC_ARROW
    mov [wc.hCursor], eax
    mov [wc.hbrBackground], COLOR_WINDOW+1
    mov [wc.lpszMenuName], NULL
    mov [wc.lpszClassName], offset ClassName

    ; Ðãng k? class
    invoke RegisterClassEx, addr wc

    ; T?o window
    invoke CreateWindowEx, 0,
           addr ClassName,
           addr AppName,
           WS_OVERLAPPEDWINDOW,
           CW_USEDEFAULT, CW_USEDEFAULT, 300, 150,
           NULL, NULL,
           [hInstance], NULL
    mov [hwnd], eax

    ; Hi?n th? window
    invoke ShowWindow, [hwnd], SW_SHOW
    invoke UpdateWindow, [hwnd]

    ; Message loop
msg_loop:
    invoke GetMessage, addr msg, NULL, 0, 0
    cmp eax, 0
    je exit
    invoke TranslateMessage, addr msg
    invoke DispatchMessage, addr msg
    jmp msg_loop

exit:
    invoke ExitProcess, [msg.wParam]
end start