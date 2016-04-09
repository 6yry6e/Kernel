;This function load dh number of sectors to ES:BX from drive DL

load_disk_via_bios:
push dx			; Store dx to check how many sectors to read was requested

mov ah, 0x02 		; BIOS interrupt function for loading
mov al, dh		; Read dh sectors
mov ch, 0x00		; Select cylinder 0
mov dh, 0x00		; Select head 0
mov cl, 0x02 		; Read from 2d sector(after boot sector)

int 0x13		; BIOS interrupt call
jc error_ldvb		; BIOS set carry flag on error
pop dx			; Get number of requested sectors
cmp dh, al		; BIOS set number of read sectors to al
jne error_ldvb
ret

error_ldvb:
mov bx, LOAD_DISK_ERROR
call print_string_via_bios
jmp $

LOAD_DISK_ERROR:
db 'Load error',0x0a,0
