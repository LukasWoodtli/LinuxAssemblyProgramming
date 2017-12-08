; calculate average

section .data

EXIT_SUCCESS    equ     0
SYS_exit        equ     60

fltLst      dq 21.34,  6.15,  9.12, 10.05,  7.75
            dq  1.44, 14.50,  3.32, 75.71, 11.87
            dq 17.23, 18.25, 13.65, 24.24,  8.88
length      dq 15
lstSum      dq 0.0
lstAve      dq 0.0


section .text
global _start
_start:

; find sum
    mov     ecx, [length]
    mov     rbx, fltLst
    mov     rsi, 0
    movsd   xmm1, qword [lstSum]

sumLoop:
    movsd   xmm0, qword [rbx+rsi*8]
    addsd   xmm1, xmm0
    inc     rsi
    loop    sumLoop

    movsd   qword [lstSum], xmm1

; compute average
    cvtsi2sd    xmm0, dword [length]
    divsd       xmm1, xmm0
    movsd       qword [lstAve], xmm1

; done
last:
    mov     eax, SYS_exit
    mov     ebx, EXIT_SUCCESS
    syscall
