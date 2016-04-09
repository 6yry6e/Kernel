;This code make switch from 16-bit real mode to 32 bit protected mode
[bits 16]		; Now we are working in 16 bit mode

switch_to_protected_mode:
cli			; Disable interrupt, CPU will ignore any interruprs
lgdt [GDT_DESCRIPTOR]	; Load GDT

mov eax, cr0		; Making switch by setting bit of control regiset
or eax, 0x1		; We can`t set it directly, using eax for it
mov cr0, eax
jmp (GDT_CODE-GDT_NULL):initialize_protected_mode	; Make far jump(to a new segment) to 32 bit code
					; We also force CPU to flush cache of pre-fetched real-mode
					; instructions, whitch can cause expection in 32 bit pr.mode
					; (cleaning the pipeline)
[bits 32]
initialize_protected_mode:
;Set segment registers to DATA_SEG
mov ax, GDT_DATA-GDT_NULL
mov ds, ax
mov ss, ax
mov es, ax
mov fs, ax
mov gs, ax

;Update out stack position to the top of free space
mov ebp, 0x90000
mov esp, ebp

call BEGIN_PM 	;Begin executing in 32 bit protection mode
