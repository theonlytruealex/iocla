%include "printf32.asm"

%define NUM 5
   
section .text

extern printf
global main
main:
    mov ebp, esp

    ; TODO 1: replace every push by an equivalent sequence of commands (use direct addressing of memory. Hint: esp)
    mov ecx, NUM
push_nums:
    sub esp, 4
    mov [esp], ecx
    loop push_nums

    sub esp, 4
    mov dword [esp], 0
    sub esp, 4
    mov dword [esp], "mere"
    sub esp, 4
    mov dword [esp], "are "
    sub esp, 4
    mov dword [esp], "Ana "

    lea esi, [esp]
    PRINTF32 `%s\n\x0`, esi

    ; TODO 2: print the stack in "address: value" format in the range of [ESP:EBP]
    ; use PRINTF32 macro - see format above

    xor ecx, ecx
    xor edx, edx
    mov ecx, esi
print_bytes:
    cmp ecx, ebp
    mov dl, [ecx]
    jz next
    PRINTF32 `0x%x %d\n\x0`, ecx, edx
    inc ecx
    jmp print_bytes
next:

    ; TODO 3: print the string
    mov ecx, esp
print_string:
    mov edx, [ecx]
    cmp edx, 0
    jz final
    xor edx, edx
    mov dl, [ecx]
    PRINTF32 `%c\x0`, edx
    inc ecx
    jmp print_string

final:
    PRINTF32 `\n\x0`
    mov esp, ecx
    add esp, 4
    xor ecx, ecx
    ; TODO 4: print the array on the stack, element by element.

    xor eax, eax
print_vector:
    mov eax, [4 * ecx+ esp]
    PRINTF32 `%d \x0`, eax
    inc ecx
    cmp ecx, NUM
    jz fin
    jmp print_vector


fin:
    ; restore the previous value of the EBP (Base Pointer)
    mov esp, ebp
    PRINTF32 `\n\x0`

    ; exit without errors
    xor eax, eax
    ret
