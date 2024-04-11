%include "../utils/printf32.asm"

%define ARRAY_SIZE    10

section .data
    byte_array db 8, 19, 12, 3, 6, 200, 128, 19, 78, 102
    word_array dw 1893, 9773, 892, 891, 3921, 8929, 7299, 720, 2590, 28891
    dword_array dd 1392849, 12544, 879923, 8799279, 7202277, 971872, 28789292, 17897892, 12988, 8799201
    big_numbers_array dd 20000001, 3000000, 3000000, 23456789, 56789123, 123456789, 987654321, 56473829, 87564836, 777777777
section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    mov ecx, ARRAY_SIZE     ; Use ecx as loop counter.
    xor eax, eax            ; Use eax to store the sum.
    xor edx, edx            ; Store current value in dl; zero entire edx.

add_byte_array_element:
    mov dl, byte [byte_array + ecx - 1]
    add eax, edx
    loop add_byte_array_element ; Decrement ecx, if not zero, add another element.

    PRINTF32 `Array sum is %u\n\x0`, eax

    mov ecx, ARRAY_SIZE
    xor eax, eax            ; Use eax to store the sum.
    xor edx, edx

add_word_array_element:
    mov dx, [word_array + 2 * (ecx - 1)]
    add eax, edx
    loop add_word_array_element

    PRINTF32 `Array sum is %u\n\x0`, eax

    mov ecx, ARRAY_SIZE
    xor eax, eax            ; Use eax to store the sum.
    xor edx, edx

add_dword_array_element:
    mov edx, [dword_array + 4 * (ecx - 1)]
    add eax, edx
    loop add_dword_array_element

    PRINTF32 `Array sum is %u\n\x0`, eax

    mov ecx, ARRAY_SIZE
    xor eax, eax            ; Use eax to store the sum.
    xor edx, edx

add_byte_array_square:
    mov al, byte [byte_array + ecx - 1]
    mul al
    add edx, eax
    loop add_byte_array_square

    PRINTF32 `Array sum is %u\n\x0`, edx


    leave
    ret
