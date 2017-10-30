; convert an integer into an ASCII string

section .data

NULL            equ     0
EXIT_SUCCESS    equ     0
SYS_exit        equ     60


section .data

intNum      dd      1498


section .bss

strNum      resb    10


section .text
global _start
_start:

; A) Successive division

    mov eax, dword [intNum]
    mov rcx, 0                  ; digit count = 0
    mov ebx, 10                 ; divisor
    
divideLoop:
    mov edx, 0
    div ebx                     ; divide by 10
    
    push rdx                    ; push remainder
    inc  rcx                    ; increment digit count
    
    cmp eax, 0
    jne divideLoop


; B) Convert remainders

    mov rbx, strNum             ; address of string
    mov rdi, 0                  ; idx = 0
    
popLoop:
    pop rax                     ; pop digit
    add al, "0"                 ; int to ASCII (char = int + "0")
    
    mov byte [rbx+rdi], al      ; string[idx] = char
    inc rdi
    loop popLoop
    
    mov byte [rbx+rdi], NULL    ; string[idx] = NULL
    
last:
    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall
