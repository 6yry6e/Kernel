;Boot sector
[org 0x7c00]		; Boot sector starts at 0x7c00 address
			; we say assembler where this code would be loaded

KERNEL_OFFSET equ 0x1000	; Offset to our kernel code
mov [BOOT_DRIVE], dl	; Store boot drive from DL
mov bp, 0x9000		; Set stack to free space
mov sp, bp
call load_kernel	; Load kernel code from disk
call switch_to_protected_mode	; Switch from 16 bit real mode to 32 bit protected mode

%include "PrintStringViaBIOS.asm"
%include "LoadDiskViaBios.asm"
%include "GDT.asm"
%include "ProtectedModeActivator.asm"


[bits 16]

load_kernel:
mov bx, KERNEL_OFFSET
mov dl, [BOOT_DRIVE]
mov dh, 0x1

call load_disk_via_bios
ret

[bits 32]

BEGIN_PM:
call KERNEL_OFFSET
jmp $

BOOT_DRIVE:
db 0

times 510-($-$$) db 0   ;Fill out file with zero-s until 510 byte
			;boot sector must be 512 bytes long with
			;"magic value" at the end of file
			;explained below

dw 0xaa55		;Set last two bytes of file with "aa55"
			;To form BIOS "magic value" so it exec out code
			;As a boot sector
