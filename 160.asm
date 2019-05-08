;将datasg段中每个单词的前4个字母改为大写字母

assume cs:codesg,ss:stacksg,ds:datasg

stacksg segment
dw 0,0,0,0,0,0,0,0
stacksg ends

datasg segment
db '1. display      '
db '2. brows        '
db '3. replace      '
db '4. modify       ' 
datasg ends

codesg segment
start:
mov ax,datasg
mov ds,ax       ;数据段ds
mov bx,0

mov ax,stacksg
mov ss,ax       ;栈段ss
mov sp,16

mov cx,4
s0:push cx      ;保存第一个循环次数
mov si,0

mov cx,4
s:mov al,ds:[bx+3][si]
and al,11011111b      ;第五位变0，字母变大写
mov [bx+3][si],al
inc si
loop s

add bx,16       ;换行
pop cx
loop s0

mov ax,4c00h   ;程序结束
int 21h

codesg ends 
end start
