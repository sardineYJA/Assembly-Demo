;用push指令将a段中的前8个字型数据，逆序存储到b段
assume cs:code 
a segment 
dw 1,2,3,4,5,6,7,8
a ends

b segment
dw 0,0,0,0,0,0,0,0
b ends

code segment 
start:
mov ax,a
mov ds,ax   ;ds指向a段

mov ax,b
mov bx,0
mov ss,ax   ;栈顶为b段
mov sp,16   ;设置栈顶指向b:16 

mov cx,8
s:push ds:[bx]
add bx,2
loop s 

mov ax,4c00h
int 21h

code ends
end start