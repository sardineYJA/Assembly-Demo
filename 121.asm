;将内存ffff:0-ffff:b单元中的数据复制到0:200-0:20b单元中
assume cs:code

code segment
mov ax,0ffffh
mov ds,ax

mov ax,0020h
mov es,ax 

mov bx,0 

mov cx,12

s:mov dl,[bx]
mov es:[bx],dl
inc bx 
loop s

mov ax,4c00h        ;程序结束
int 21h
code ends
end 