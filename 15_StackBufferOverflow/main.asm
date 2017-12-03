; Example for stack overflow

section .data

LF          equ     10
NULL        equ     0
progName    db      "/bin/sh", NULL


TRUE    equ     1
FALSE   equ     0

SYS_exit        equ     60
EXIT_SUCCESS    equ     0



section .text

global _start
_start:

; call extern application
    mov     rax, 59     ; exec
    mov     rdi, progName
    syscall
  

exampleDone:
    mov     rax, SYS_exit
    mov     rdi, EXIT_SUCCESS
    syscall

