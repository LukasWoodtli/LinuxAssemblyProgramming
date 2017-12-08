; calculate average

section .data

EXIT_SUCCESS    equ     0
SYS_exit        equ     60

dZero           dq      0.0
dNegOne         dq      -1.0

fltVal          dq      -8.25


section .text
global _start
_start:

; abs
    movsd       xmm0, qword [fltVal]
    ucomisd     xmm0, qword [dZero]
    jae         isPos
    mulsd       xmm0, qword [dNegOne]
    movsd       qword [fltVal], xmm0
isPos:

; done
last:
    mov     eax, SYS_exit
    mov     ebx, EXIT_SUCCESS
    syscall
