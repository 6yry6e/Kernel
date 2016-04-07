;Boot sector "Hello World!", prints "Hello World!"
    
[org 0x7c00]		; Boot sector starts at 0x7c00 address
			; we say assembler where this code would be loaded

mov bx, HELLO_WORLD	; Set string address
call print_string

jmp $                   ; Jump to current address (endless loop)

HELLO_WORLD:
db 'Hello World!',0
;Prints string bx - address of string
print_string:
push bx
push ax
print_string_loop:
mov al, [bx]		; Set current char	
cmp al,0		; Check end of the string
jz print_string_return
mov ah,0x0e		; Set iterrupt command for int 0x10
int 0x10 		; Call BIOS interrupt call (Video Services)
			; it tooks char from al register and prints it
add bx,1		; Go to next char
jmp print_string_loop
print_string_return:
pop ax
pop bx
ret

times 510-($-$$) db 0   ;Fill out file with zero-s until 510 byte
			;boot sector must be 512 bytes long with
			;"magic value" at the end of file
			;explained below

dw 0xaa55		;Set last two bytes of file with "aa55"
			;To form BIOS "magic value" so it exec out code
			;As a boot sector
