; int 21h中断例程是DOS提供的中断例程，其中包含了DOS提供给程序员在编程时调用的子程序
; mov ah,4ch    ;程序返回
; mov al,0      ;返回值
; int 21h    
; 表示调用第21h号中断例程的4ch号子程序，功能为程序返回，可以提供返回值作为参数


; int 21H 中断例程在光标位置显示字符串的功能：
; ds:dx 指向字符串    ; 要显示的字符串需用“$” 作为结束符
; mov ah,9            ; 功能号9，表示在光标位置显示字符串
; int 21h

; 在屏幕的5行12列显示字符串"Welcome to masm!"

assume cs:code 

data segment
    db 'Welcome to masm!','$'
data ends

code segment
start:
    mov ah,2  ; 置光标
	mov bh,0  ; 第0页
	mov dh,5  ; dh中放行数
	mov dl,12 ; dl中放列号
	int 10h
	
	mov ax,data
	mov ds,ax
	mov dx,0     ; ds:dx 指向字符串的首地址data:0
	
	mov ah,9
	int 21h 
	
	mov ax,4c00h
	int 21h
code ends
end start


