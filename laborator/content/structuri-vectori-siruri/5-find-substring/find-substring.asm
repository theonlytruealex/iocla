%include "printf32.asm"

section .data
source_text: db "ABCABCBABCBABCBBBABABBCBABCBAAACCCB", 0
substring: db "BABC", 0

print_format: db "Substring found at index: %d", 10, 0

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp
    xor eax, eax
    xor ebx, ebx
    xor edx, edx
    xor ecx, ecx
    mov esp, -1

    lea eax, [source_text]
    lea ebx, [substring]

start_loop:
    mov ecx, esp
    inc ecx
    mov esp, ecx
    mov dl, [eax + ecx]
    cmp dl, 0
    jz final
    cmp [ebx + ecx], dl
    jnz start_loop

word_check:
    inc ecx
    mov dl, [ebx + ecx]
    cmp dl, 0
    jz printer
    cmp [eax + ecx], dl
    jnz start_loop
    jmp word_check

printer:
    jmp start_loop

final:
    leave
    ret
