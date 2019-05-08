;利用栈，将程序中定义的数据逆序存放
assume cs:codesg
codesg segment
dw 0123h,0234h,0345h,0456h,0567h,0678h,0789h,0899h ;8个字
dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0                 ;16个字

start:mov ax,cs
mov ss,ax
mov sp,20h      ;将设置栈顶ss:sp指向cs:30

mov bx,0
mov cx,8
s:push cs:[bx]
add bx,2
loop s

mov bx,0 
mov cx,8
s0:pop cs:[bx]
add bx,2
loop s0

mov ax,4c00h
int 21h

codesg ends
end start 