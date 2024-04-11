%include "../utils/printf32.asm"

section .data
    num db 100

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp
    xor cl, cl
    mov cl, [num]     ; Use ecx as counter for computing the sum.
    xor ebx, ebx       ; Use eax to store the sum. Start from 0.
    xor eax, eax

add_to_sum:
    xor eax, eax
    mov al, cl
    mul cl
    add ebx, eax
    dec cl
    test cl, cl
    jnz add_to_sum    ; Decrement ecx. If not zero, add it to sum.

    mov ecx, [num]
    PRINTF32 `Sum(%u): %u\n\x0`, ecx, ebx

    leave
    ret
