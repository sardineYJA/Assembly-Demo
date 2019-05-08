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

;计算1000000/10 ( F4240h/0ah )

assume cs:code
code segment 
start:
mov ax,4240h
mov dx,000fh
mov cx,0ah

call divdw

mov ax,4c00h
int 21h

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
