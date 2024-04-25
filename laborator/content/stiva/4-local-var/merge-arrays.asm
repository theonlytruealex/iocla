%include "printf32.asm"

%define ARRAY_1_LEN 5
%define ARRAY_2_LEN 7
%define ARRAY_OUTPUT_LEN 12

section .data

array_1 dd 27, 46, 55, 83, 84
array_2 dd 1, 4, 21, 26, 59, 92, 105
array_output times 12 dd 0


section .text

extern printf
global main
main:
mov edi, esp
mov ecx, ARRAY_1_LEN
mov esi, array_1

copy_array_1_loop:
    mov eax, [esi]
    mov [edi], eax 
    add esi, 4
    add edi, 4
    loop copy_array_1_loop

    mov edi, esp
    add edi, ARRAY_1_LEN * 4
    mov ecx, ARRAY_2_LEN
    mov esi, array_2

copy_array_2_loop:
    mov eax, [esi]
    mov [edi], eax
    add esi, 4
    add edi, 4
    loop copy_array_2_loop


    mov eax, 0
    mov ebx, 0
    mov ecx, 0

merge_arrays:
    mov edx, [esp  + 4 * eax]
    cmp edx, [esp +ARRAY_1_LEN * 4 + 4 * ebx]
    jg array_2_lower
array_1_lower:
    mov [esp + ARRAY_1_LEN * 4 + ARRAY_2_LEN * 4 + 4 * ecx], edx
    inc eax
    inc ecx
    jmp verify_array_end
array_2_lower:
    mov edx, [esp + ARRAY_1_LEN * 4 + 4 * ebx]
    mov [esp + ARRAY_1_LEN * 4 + ARRAY_2_LEN * 4 + 4 * ecx], edx
    inc ecx
    inc ebx

verify_array_end:
    cmp eax, ARRAY_1_LEN
    jge copy_array_2
    cmp ebx, ARRAY_2_LEN
    jge copy_array_1
    jmp merge_arrays

copy_array_1:
    mov edx, [esp + 4 * eax]
    mov [esp + ARRAY_1_LEN * 4 + ARRAY_2_LEN * 4 + 4 * ecx], edx
    inc ecx
    inc eax
    cmp eax, ARRAY_1_LEN
    jb copy_array_1
    jmp print_array
copy_array_2:
    mov edx, [esp + ARRAY_1_LEN * 4 + 4 * ebx]
    mov [esp + ARRAY_1_LEN * 4 + ARRAY_2_LEN * 4 + 4 * ecx], edx
    inc ecx
    inc ebx
    cmp ebx, ARRAY_2_LEN
    jb copy_array_2

print_array:
    PRINTF32 `Array merged:\n\x0`
    mov ecx, 0
print:
    mov eax, [esp + ARRAY_1_LEN * 4 + ARRAY_2_LEN * 4 + 4 * ecx]
    PRINTF32 `%d \x0`, eax
    inc ecx
    cmp ecx, ARRAY_OUTPUT_LEN
    jb print

    PRINTF32 `\n\x0`
    xor eax, eax
    mov esp, ebp
    ret
