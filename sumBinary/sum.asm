.MODEL small
.STACK 100h

.DATA
so1 dw ?
so2 dw ?
tbao1 db "Nhap so 1 (16 bit): $"
tbao2 db "Nhap so 2 (16 bit): $"
tbao3 db "Tong: $"
.CODE

MAIN PROC
MAIN ENDP
   ; chi duoc nhap 1,0 va CR
   ; ;thuat toan nhap vao so nhi phan
     MOV AX,@DATA
     MOV DS,AX
     XOR BX,BX
     
     ; in ra thong bao nhap so 1
     MOV AH,9
     LEA DX,tbao1
     INT 21h

     MOV AH,1
     INT 21h
     
     nhap_1:
        CMP AL,0Dh
        JE tb_2             
        AND AH,0Fh
        SHL BX,1
        SUB AL,30h
        OR BL,AL
        INT 21h
        JMP nhap_1
     
     tb_2:
     MOV so1,bx
     XOR bx,bx
     
     MOV AH,2
     MOV DL,0Ah
     INT 21h
     MOV AH,2
     MOV DL,0Dh
     INT 21h
     
     ; in ra thong bao nhap so 2          
     MOV AH,9
     LEA DX,tbao2
     INT 21h
     
     MOV AH,1
     INT 21h
     
     nhap_2:
        CMP AL,0Dh
        JE tb_3             
        AND AH,0Fh
        SHL BX,1
        SUB AL,30h
        OR BL,AL
        INT 21h
        JMP nhap_2
     
     ; in ra thong bao tong
     tb_3:
     MOV so2,bx
     XOR bx,bx
     
     MOV AH,2
     MOV DL,0Ah
     INT 21h
     MOV AH,2
     MOV DL,0Dh
     INT 21h
               
     MOV AH,9
     LEA DX,tbao3
     INT 21h
     
     tong:
     MOV bx,so1
     add bx,so2
     
     mov cx,16
     mov dx, 30h
     adc dx,0
     mov ah,2
     int 21h 

     lap3:
     mov dl,30h
     shl bx,1
     adc dl,0
     mov ah,2
     int 21h
     loop lap3  
     
                     
END MAIN                  