;Global Descriptor Table (GDT)
;Basic flat model (see Intel 64 and  IA-32 Architectures Software Developer`s Manual 3.2.1 for more details)

;db - define byte(1 byte) dw - define word(2 bytes) dd - define double world (4 bytes)
GDT_NULL: 	;Mandatory null discriptor
dd 0x0 
dd 0x0 

GDT_CODE:	;Code segment descriptor
;Properties:
;base = 0x0 (defines where out segment starts in physical memory)
;limit = 0xfffff (defines size of segment)
;1st Flags:
;(present)1 (privilege)00 (desctiptor type)1 -> 1001b
;type Flags:
;(code)1 (conformin)0 (readable)1 (accessed)0 -> 1010b
;2d Flags:
;(granularity)1 (32-bit default)1 (64-bit seg)0 (AVL)0 -> 1100b
dw 0xffff 	; Limit(bits 0-15)
dw 0x0		; Base(bits 0-15)
db 0x0		; Base(bits 16-23)
db 10011010b	; 1st Flags, type Flags
db 11001111b   	; 2d flags, Limit (bits 16-19)
db 0x0		; Base(bits 24-31)

GDT_DATA:	;Data segment descriptor
;Properties:
;base = 0x0 (defines where out segment starts in physical memory)
;limit = 0xfffff (defines size of segment)
;1st Flags:
;(present)1 (privilege)00 (desctiptor type)1 -> 1001b
;type Flags:
;(code)0 (expand down)0 (writable)1 (accessed)0 -> 0010b
;2d Flags:
;(granularity)1 (32-bit default)1 (64-bit seg)0 (AVL)0 -> 1100b
dw 0xffff 	; Limit(bits 0-15)
dw 0x0		; Base(bits 0-15)
db 0x0		; Base(bits 16-23)
db 10010010b	; 1st Flags, type Flags
db 11001111b   	; 2d flags, Limit (bits 16-19)
db 0x0		; Base(bits 24-31)

GDT_END: 	;This label needed to calculate whole size of the GDT for GDT descriptor

;GDT descriptor 48 bit long
GDT_DESCRIPTOR:
;Size of GDT:
dw GDT_END - GDT_NULL - 1
;Starto address of GDT:
dd GDT_NULL
