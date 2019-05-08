;当发生除法溢出时，在屏幕中间显示“MyLove!!!”，返回DOS

;将中断处理程序do0放到0000:0200处
;将do0的入口地址0:0200，写入中断向量表的0号表项中，使do0成为0号中断的中断处理程序

assume cs:code

code segment
start:
    mov ax,cs
	mov ds,ax
	mov si,offset do0     ;设置ds:si指向源地址
	
	mov ax,0
	mov es,ax
	mov di,200h            ;设置es:di指向目的地址

	mov cx,offset do0end-offset do0   ;设置cx的传输长度
	cld    ;将df置为0
	rep movsb

	;设置中断向量表
	mov ax,0
	mov es,ax
	mov word ptr es:[0*4],200h
	mov word ptr es:[0*4+2],0 

	;程序结束
	mov ax,4c00h
	int 21h
	
do0:
    jmp short do0start
	db "MyLove!!!"       ;代码段存放数据，程序执行后数据就不会被释放

do0start:
    mov ax,cs
	mov ds,ax
	mov si,202h      ;设置ds:si指向字符串
                 ;偏移地址，0:200h出的指令为jmp short do0start,占两个字节
				 ;所以字符串的偏移地址为202h

	mov ax,0b800h
	mov es,ax
	mov di,12*160+36*2    ;设置es:di指向显存空间的中间位置

	mov cx,9    ;字符串长度
s:
    mov al,[si]
	mov es:[di],al
	inc si
	add di,2 
	loop s 

	mov ax,4c00h		   
	int 21h

do0end:nop
code ends
end start 




