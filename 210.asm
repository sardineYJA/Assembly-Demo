;子程序描述
;名称：dtoc
;功能：将word型数据转变为表示十进制的字符串，字符串以0为结束符
;参数：ax = word型数据
;      ds:si指向字符串的首地址
;返回：无

;将数据12666以十进制的形式在屏幕的8行3列，用绿色显示出来

;？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？
;问题：第二个子程序检测以0结束的字符串，那么数字10060应该会提前结束
;然而正常运行？？？？？？？？？？？？？？？？？？？？？？？？？？？？
;原因：
;十进制数码字符对应的ASCLL码 = 十进制数码值 + 30h
;所以字符0的码值=30h,而子程序检测的0应该是ASCLL码为0的

assume cs:code
data segment
db 10 dup(0)  ;综上问题，那么这里的0是数字0，而不是字符0
data ends

code segment
start:
mov ax,10060  ;要显示在屏幕上的数字

mov bx,data   ;显示的内容存放位置
mov ds,bx
mov si,0

call dtoc

mov dh,15
mov dl,8
mov cl,2

call show_str

mov ax,4c00h
int 21h

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
dtoc:
push ax
push bx
push cx
push dx
push si
push di

mov di,0        ;字符个数为0
d10:
mov dx,0        ;设置被除数高位为0
mov bx,10       ;除数10
div bx

add dx,30h      ;ax/10的余数+30h，转为字符
push dx         ;字符入栈
inc di          ;记录字符个数

mov cx,ax
jcxz d11        ;当ax/10的商 = 0时，转到d11执行
jmp d10

d11:
mov cx,di       ;字符数为循环次数

d12:
pop dx          ;字符出栈
mov ds:[si],dl  ;将字符存放到data段
inc si          ;指向下一个单元
loop d12

mov dl,0
mov ds:[si],dl  ;设置结束符0

pop di
pop si
pop dx
pop cx
pop bx
pop ax
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

code ends
end start

