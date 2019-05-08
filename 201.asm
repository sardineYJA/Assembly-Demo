;计算data段中第一组数据的三次方，结果保存在后面一组dword单元中

assume cs:code
data segment 
dw 1,2,3,4,5,6,7,8
dd 0,0,0,0,0,0,0,0
data ends

code segment 
start:mov ax,data
mov ds,ax
mov si,0   ;ds:si指向第一组word单元
mov di,16  ;ds:di指向第二组dword单元

mov cx,8
s:mov bx,[si]
call cube         ;子程序
mov [di],ax       ;低位结果
mov [di].2,dx     ;高位结果
add si,2
add di,4
loop s

mov ax,4c00h
int 21h

cube:mov bx,ax
mul bx
mul bx
ret

code ends
end start




