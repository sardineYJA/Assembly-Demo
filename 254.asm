; 编写，安装中断7ch的中断例程
; 功能：将一个全是字母，以0结束的字符串，转为大写
; 参数：ds:si指向字符串的首地址

assume cs:code
data segment
    db 'conversation',0
data ends

code segment
start:
    mov ax,data
	mov ds,ax
	mov si,0
	int 7ch
	
	mov ax,4c00h
	int 21h
code ends
end start


; 安装中断7ch的中断例程
assume cs:code 
code segment
start:
    mov ax,cs
	mov ds,ax
	mov si,offset capital
	
	mov ax,0
	mov es,ax         ;将例程复制到0:200h处
	mov di,200h
	
	mov cx,offset capitalend - offset capital
	cld
	rep movsb
	
	; 设置中断向量
	mov ax,0
	mov es,ax
	mov word ptr es:[7ch*4],200h
	mov word ptr es:[7ch*4+2],0
	
	mov ax,4c00h
	int 21h
	
capital:
    push cx
	push si
change:
    mov cl,ds:[si]
	mov ch,0
	jcxz ok
	and byte ptr [si],11011111b ; 将其转换为大写
	inc si
	jmp short change
ok:
    pop si
	pop cx
	iret
capitalend:
    nop
	
code ends
end start

	
	