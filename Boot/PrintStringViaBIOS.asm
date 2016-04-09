;This function prints null-terminated string via BIOS interrupt call

;The address of first char stored in bx
print_string_via_bios:
push bx
push ax
.loop_psvb:
mov al, [bx]		; Set current char	

cmp al,0		; Check end of the string
je break_psvb

mov ah,0x0e		; Set iterrupt command for int 0x10
int 0x10 		; Call BIOS interrupt call (Video Services)
			; it tooks char from al register and prints it
add bx,1		; Go to next char
jmp .loop_psvb
break_psvb:
pop ax
pop bx
ret
