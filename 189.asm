;在屏幕中间分别显示绿色，绿底红色，白底蓝色的字符串
assume cs:code
data segment
db'welcome to masm!'  ;字符串
data ends

code segment
start:mov ax,data  ;ds数据段
mov ds,ax

mov ax,0b800h      ;显示缓存区，一行80个字符，占160字节
                   ;一个字符占两个字节，低位字节存储ASCLL吗，高位字节存储字符属性
mov es,ax
mov bx,0720h       ;第12行中间首地址=11×160 + 32×2 = 1824 = 720h
mov si,0

mov cx,16          ;字符串长度16
s:mov ax,[si]
mov ah,82h          ;字符属性
mov es:[bx],ax

mov ah,24h           ;字符属性
mov es:[bx+0a0h],ax  ;+a0h=160即换行

mov ah,71h               ;字符属性
mov es:[bx+0a0h+0a0h],ax ;+a0h=160即换行
inc si
add bx,2
loop s

mov ax,4c00h
int 21h

code ends
end start