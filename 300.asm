;除法溢出例子

assume cs:code
code segment
start:
    ;设置中断向量表0号除法溢出，与248.exe连用
	mov ax,0
	mov es,ax
	mov word ptr es:[0*4],200h
	mov word ptr es:[0*4+2],0 
	
	mov ax,8h
	mov bx,2h
	div bx
	
	mov ax,4c00h
	int 21h
	 
code ends
end start