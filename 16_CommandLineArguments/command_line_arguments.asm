
section .data

LF              equ     10
NULL            equ     0

EXIT_SUCCESS    equ     0

STDOUT          equ     1

SYS_write       equ     1
SYS_exit        equ     60


newLine         db      LF, NULL

section .text

global _start
_start:

    mov     r12, [rsp]        ; argc is saved at rsp
    mov     r13, rsp          ; argv starts at rsp+8
    add     r13, 8
    
    ; print each argument
    ; the arguments are NULL terminated by the system
printArguments:
    mov     rdi, newLine
    call    printString

    mov     rbx, 0

printLoop:
    mov     rdi, qword [r13+rbx*8]
    call    printString
    
    mov     rdi, newLine
    call    printString 

    inc     rbx
    cmp     rbx, r12
    jl      printLoop

exampleDone:
    mov     rax, SYS_exit
    mov     rdi, EXIT_SUCCESS
    syscall


global printString
printString:
    push    rbp
    mov     rbp, rsp
    push    rbx

    ; count chars
    mov     rbx, rdi
    mov     rdx, 0
strCountLoop:
    cmp     byte [rbx], NULL
    je      strCountDone
    inc     rdx
    inc     rbx
    jmp     strCountLoop

strCountDone:
    cmp     rdx, 0
    je      prtDone
    
    ; syscall for printing
    mov     eax, SYS_write
    mov     rsi, rdi
    mov     edi, STDOUT
    syscall
    
prtDone:
    pop     rbx
    pop     rbp
    ret
    
    
    
    
