;记录公司从1975年到1995年的基本情况
assume cs:code, ds:data, es:table

data segment
;年份 21年乘4个字节
db '1975','1976','1977','1978','1979','1980','1981','1982'
db '1983','1984','1985','1986','1987','1988','1989','1990'
db '1991','1992','1993','1994','1995'

;收入 21年乘4个字节
dd 16,22,382,1356,2390,8000,16000,24561
dd 51303,96451,124652,145678,194562,324567,593124,845612
dd 1213456,2314657,3214657,4651327,5132789

;员工数
dw 3,7,9,12,23,45,56,123
dw 456,789,1001,1234,1345,1564,1789,1912
dw 2341,2856,3123,3456,3789
data ends

table segment
db 21 dup('year summ ne??')   ;定义了21个year summ ne??
table ends

code segment 

start:mov ax,data
mov ds,ax       ;ds数据段

mov ax,table 
mov es,ax 

mov bx,0
mov si,0
mov di,0
mov cx,21      ;总21年份

s:
;年份
mov ax,[bx]
mov es:[si],ax
mov ax,[bx].2
mov es:[si].2,ax 

;收入
mov ax,[bx].84    ;21年乘4个字节,低位
mov es:[si].5,ax  ;4个字节加一个空格
mov dx,[bx].86    ;高位
mov es:[si].7,dx 

;人均收入
div word ptr ds:[di].168   ;21年乘4个字节 + 21个4字节
mov es:[si].13,ax          ;年份4字节+空格1字节+收入4字节+空格1字节+员工数2字节+空格1字节
                           ;余数在dx中
;员工数
mov ax,[di].168
mov es:[si].10,ax

add di,2
add bx,4
add si,16
loop s

mov ax,4c00h
int 21h

code ends
end start  