;将data数据段中的字符串转化为大写

assume cs:code

data segment
db 'conversation'
data ends

code segment
start:
mov ax,data
mov ds,ax
mov si,0

mov cx,12         ;字符串长度
call capital      ;子程序

mov ax,4c00h
int 21h

capital:
and byte ptr [si],11011111b ;第五位变为0
inc si
loop capital     ;子程序循环

code ends
end start
