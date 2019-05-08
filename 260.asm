;int 10h 中断例程是BIOS提供的中断例程，其中包括了多个和屏幕输出相关的子程序

assume cs:code
code segment

    mov ah,2    ; 置光标，int 10h的2号子程序
	mov bh,0    ; 第0页（显示缓冲区分8页）
	mov dh,5    ; dh放行号
	mov dl,12   ; dl放列号
	int 10h
	
	mov ah,9          ; 置光标 
  	mov al,'a'        ; 字符
	mov bl,11001010b  ; 颜色属性
	mov bh,0          ; 第0页 
	mov cx,3          ; 字符重复个数
	int 10h
	
	mov ax,4c00h
	int 21h
code ends
end

