;Boot sector
    
[org 0x7c00]		; Boot sector starts at 0x7c00 address
			; we say assembler where this code would be loaded

KERNEL_OFFSET equ 0x1ff	; Offset to our kernel code

mov [BOOT_DRIVE], dl	; Store boot drive from DL

mov bp, 0x9000		; Set stack to free space
mov sp, bp

mov bx, IN_REAL_MODE	; Set string address
call print_string_via_bios
call load_kernel
call switch_to_protected_mode	; Switch from 16 bit real mode to 32 bit protected mode

jmp $

%include "PrintStringViaBIOS.asm"
%include "LoadDiskViaBios.asm"
%include "GDT.asm"
%include "ProtectedModeActivator.asm"
%include "PrintStringInPM.asm"

[bits 16]

load_kernel:
mov bx, LOADING_KERNEL
call print_string_via_bios

mov bx, KERNEL_OFFSET
mov dh, 1
mov dl, [BOOT_DRIVE]
call load_disk_via_bios

ret

[bits 32]

BEGIN_PM:
mov ebx, IN_PROTECTED_MODE
call print_string_pm
call KERNEL_OFFSET
jmp $                   ; Jump to current address (endless loop)

IN_REAL_MODE:
db '16-bit Real mode started ',0

IN_PROTECTED_MODE:
db 'Switched to 32-bit protected mode ',0

LOADING_KERNEL:
db 'Loading kernel ',0x0a,0

BOOT_DRIVE:
db 0



times 510-($-$$) db 0   ;Fill out file with zero-s until 510 byte
			;boot sector must be 512 bytes long with
			;"magic value" at the end of file
			;explained below

dw 0xaa55		;Set last two bytes of file with "aa55"
			;To form BIOS "magic value" so it exec out code
			;As a boot sector
