;Boot sector "Hello World!", prints "Hello World!"

mov ah, 0x0e 	; Set 2-d byte of ax with 0x0e
		; 0x0e says 0x10 BIOS interrupt call to
		; write character in TTY mode

mov al, 'H'     ; Set 1-d byte of ax with 'H'
int 0x10        ; Call BIOS interrupt call (Video Services)
		; With ah set to 0x0e it tooks char from al register
		; And prints it
mov al, 'e'	
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10
mov al, ' '
int 0x10
mov al, 'W'
int 0x10
mov al, 'o'
int 0x10
mov al, 'r'
int 0x10
mov al, 'l'
int 0x10
mov al, 'd'
int 0x10
mov al, '!'
int 0x10

jmp $                   ;Jump to current address (endless loop)

times 510-($-$$) db 0   ;Fill out file with zero-s until 510 byte
			;boot sector must be 512 bytes long with
			;"magic value" at the end of file
			;explained below

dw 0xaa55		;Set last two bytes of file with "aa55"
			;To form BIOS "magic value" so it exec out code
			;As a boot sector
