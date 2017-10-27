; Reverse a list of numbers

section .data

EXIT_SUCCESS    equ     0
SYS_exit        equ     60

numbers     dq  121, 122, 123, 124, 125
len         dq  5

section .text
global _start
_start:

    mov rcx, qword [len]    ; loop counter
    mov rbx, numbers        ; base address of list (array)
    mov r12, 0              ; index for list

pushLoop:
    push qword [rbx+r12*8]
    inc  r12
    loop pushLoop


; pop the values back
    mov rcx, qword [len]
    mov rbx, numbers
    mov r12, 0
    
popLoop:
    pop rax
    mov qword [rbx+r12*8], rax
    inc r12
    loop popLoop

last:
    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall
