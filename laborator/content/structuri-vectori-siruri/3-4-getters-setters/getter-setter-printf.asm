%include "printf32.asm"

struc my_struct
    int_x: resb 4
    char_y: resb 1
    string_s: resb 32
endstruc

section .data
    sample_obj:
        istruc my_struct
            at int_x, dd 1000
            at char_y, db 'a'
            at string_s, db 'My string is better than yours', 0
        iend

    new_int dd 2000
    new_char db 'b'
    new_string db 'Are you sure?', 0

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp

    ; TODO
    ; print all three values (int_x, char_y, string_s) from simple_obj
    ; Hint: use "lea reg, [base + offset]" to save the result of
    ; "base + offset" into register "reg"

    mov eax, [sample_obj + int_x]
    PRINTF32 `int_x: %u\n\x0`, eax
    movzx eax, byte [sample_obj + char_y]
    PRINTF32 `char_y: %c\n\x0`, eax
    lea eax, [sample_obj + string_s]
    PRINTF32 `string_s: %s\n\x0`, eax

    ; TODO
    ; write the equivalent of "simple_obj->int_x = new_int"

    mov ebx, [new_int]
    mov [sample_obj + int_x], ebx

    ; TODO
    ; write the equivalent of "simple_obj->char_y = new_char"
    
    mov bl, byte [new_char]
    mov [sample_obj + char_y], bl

    ; TODO
    ; write the equivalent of "strcpy(simple_obj->string_s, new_string)"

    xor ecx, ecx
    lea eax, [sample_obj + string_s] 
    loop:
    mov bl, byte [new_string + ecx]
    mov [eax + ecx], byte bl
    add ecx, 1
    cmp bl, 0
    jnz loop

    ; TODO
    ; print all three values again to validate the results of the
    ; three set operations above

    mov eax, [sample_obj + int_x]
    PRINTF32 `int_x: %u\n\x0`, eax
    movzx eax, byte [sample_obj + char_y]
    PRINTF32 `char_y: %c\n\x0`, eax
    lea eax, [sample_obj + string_s]
    PRINTF32 `string_s: %s\n\x0`, eax

    xor eax, eax
    leave
    ret
