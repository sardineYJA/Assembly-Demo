;子程序描述
;名称：dtoc2
;功能：将dword型数据转变为表示十进制的字符串，字符串以0为结束符
;参数：ax = dword型数据的低16位
;      dx = dword型数据的高16位
;      ds:si指向字符串的首地址
;返回：无

;将数据4294967295以十进制的形式在屏幕的8行3列，用绿色显示出来

assume cs:code , ds:data
data segment
db 15 dup (0)
data ends

code segment
start:
mov ax,0ffffh     ;数据4294967295的16进制数
mov dx,0ffffh

mov bx,data
mov ds,bx
mov si,0     ;指向字符串首地址

call dtoc2

mov dh,8
mov dl,3
mov cl,2

call show_str

mov ax,4c00h
int 21h

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

dtoc2:
push ax
push bx
push cx
push dx
push si
push di

mov di,0     ;字符个数为0
d20:
mov cx,10    ;除数为10

call divdw

add cx,30h   ;余数+30h,转为字符
push cx      ;字符入栈
inc di       ;记录字符个数

mov cx,ax
jcxz d21     ;低位商 = 0时，转到d21检测高位商
jmp d20

d21:
mov cx,dx
jcxz d22     ;低高位商全 = 0时，转到d22
jmp d20

d22:
mov cx,di

d23:
pop ax          ;字符出栈
mov ds:[si],al
inc si          ;指向下一个单元
loop d23

mov al,0
mov ds:[si],al  ;设置结尾符0

pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;子程序描述
;名称：show_str
;功能：在制定的位置，用指定的颜色，显示一个用0结束的字符串。
;参数：（dh） = 行号（取值范围0-24），（dl） = 列号（取值范围0-79），
;      （cl） = 颜色，ds:si指向字符串的首地址
;返回：无
show_str:
push ax
push bx
push es
push si

mov ax,0b800h
mov es,ax
mov ax,160     ;一行160字节
mul dh
mov bx,ax      ;bx = 160*dh

mov ax,2
mul dl         ;ax = 2*dl
add bx,ax      ;设置es:bx指向显存首页地址

mov al,cl      ;颜色 
mov cl,0  

show0:
mov ch,ds:[si]     ;data段的内容
jcxz show1;        ;ds:[si] = 0或cx = 0 即字符为0，跳转show1
mov es:[bx],ch
mov es:[bx].1,al   ;高位储存属性
inc si
add bx,2
jmp show0

show1:
pop si
pop es
pop bx
pop ax
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;子程序描述
;名称：divdw
;功能：进行不会产生溢出的除法运算，被除数为dword型，除数为word型，结果为dword型
;参数：ax = dword型数据的低16位
;      dx = dword型数据的高16位
;      cx = 除数
;返回：dx = 结果的高16位 
;      ax = 结果的低16位  
;      cx = 余数
;公式：x/n = int(h/n)*65536 + [rem(h/n)*65536+l]/n
divdw:
push si
push bx
push ax

mov ax,dx     ;被除数的高位运算
mov dx,0
div cx        ;被除数的高位/cx，商在ax，余数在dx
mov si,ax     ;将被除数高位/cx的商保存在si

pop ax        ;被除数的低位运算

;add ax,dx     ;高位余数*65536 + ax
;因为16位除法，(dx,ax)/cx，所以上一句多余
div cx        ;商在ax，余数在dx

mov cx,dx     ;余数保存在cx
mov dx,si     ;高位的商在dx,低位的商在ax

pop bx
pop si
ret

code ends
end start


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




