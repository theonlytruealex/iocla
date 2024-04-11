%include "../utils/printf32.asm"

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    mov eax, 211    ; to be broken down into powers of 2
    mov ebx, 1      ; stores the current power
    mov ecx, 8

start_loop:
    mov edx ,eax 
    AND edx, ebx
    test edx, edx
    jz no_print
    PRINTF32 `%u\n\x0`, ebx
no_print:
    SHL ebx, 1
    loop start_loop
    leave
    ret
