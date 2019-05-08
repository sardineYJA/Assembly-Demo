;子程序描述
;名称：letterc
;功能：将以0结束的字符串中的小写字母转变成大写字母
;参数：ds:si 指向字符串首地址
;返回：无

;小写字母‘a’-'z'对应ASCII码为61h-86h，只要这段区间里的ASCII码减去20h，就改成大写字母


assume cs:codesg
datasg segment
    db "Beginner's All-purpose Symbolic Instruction Code.",0
datasg ends

codesg segment
begin:
mov ax,datasg
mov ds,ax
mov si,0

call letterc

mov ax,4c00h
int 21h

letterc:
push ax
push si

let:
cmp byte ptr [si],0      ;和0进行比较
je let0                  ;程序结束

cmp byte ptr [si],61h    ;和61h比较
jb let1                  ;如果低于，则进行下一轮循环

cmp byte ptr [si],86h    ;和86h比较
ja let1                  ;如果高于，则进行下一轮循环

mov al,[si]
sub al,20h               ;转为大写字母
mov [si],al

;也可以and byte prt [si],11011111b   ASCII码的第五位为0，转为大写


let1:    ;进行下一轮循环
inc si
jmp let

let0:    ;程序结束
pop si
pop ax
ret

codesg ends
end begin

