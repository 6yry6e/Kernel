[org 0x1ff]
[bits 32]
main:
call print

jmp main

ret

print:
mov edx, 0xb8000
mov ebx, 0
print_loop:
mov al, ' '
call get_color
mov [edx], ax
add edx, 2
add ebx, 1
cmp ebx, 0x7CF ;1999
jnz print_loop
ret


get_color:
add ah,0x01
jc zero_color
ret
zero_color:
mov ah,0x0f
ret
