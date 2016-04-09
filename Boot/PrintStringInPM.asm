;This function prints null-terminated string at the start of VGA video memory in 32 bit protected mode
[bits 32]
VIDEO_MEMORY equ 0xb8000	;Address of video memory
WHITE_ON_BLACK equ 0x0f		;Set the font properties

;address of first char stored in edx
print_string_pm:
push edx
push ebx
push ax

mov edx, VIDEO_MEMORY	; Set edx to the start of video memory
.loop_pspm:
mov al, [ebx]		; Set current char
mov ah, WHITE_ON_BLACK	; Set font attributes

cmp al, 0		; Check for end of the string
je break_pspm

mov [edx], ax		; Place char and font args at current character position
add ebx, 1		; Go to next char
add edx, 2		; Move to next chracter position in video memory
jmp .loop_pspm
break_pspm:
pop ax
pop ebx
pop edx
ret

