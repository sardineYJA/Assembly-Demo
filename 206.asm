;子程序描述
;名称：show_str
;功能：在制定的位置，用指定的颜色，显示一个用0结束的字符串。
;参数：（dh） = 行号（取值范围0-24），（dl） = 列号（取值范围0-79），
;      （cl） = 颜色，ds:si指向字符串的首地址
;返回：无

;在屏幕的8行3列，用绿色显示data段中的字符创

assume cs:code

data segment
db 'Welcome to 0 masm!',0
data ends

code segment
start:
mov dh,8     ;行号
mov dl,3     ;列号
mov cl,2     ;字体颜色

mov ax,data
mov ds,ax
mov si,0

call show_str

mov ax,4c00h
int 21h

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

code ends
end start