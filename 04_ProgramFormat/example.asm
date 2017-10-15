; Simple example


; ******************************************
; Basic data declarations (initialized vars)

section .data

; ----
; Constants
EXIT_SUCCESS    equ 0   ; successful exit code
SYS_exit        equ 60  ; call code for terminate

; ----
; 8-bit variable declarations
bVar1           db  17
bVar2           db  9
bResult         db  0

; ----
; 16-bit (word) variable declarations
wVar1           dw  17000
wVar2           dw  9000
wResult         dw  0

; ----
; 32-bit (double-word) variable declarations
dVar1           dd  17000000
dVar2           dd  9000000
dResult         dd  0

; ----
; 64-bit (quad-word) variable declarations
qVar1           dq  170000000
qVar2           dq  90000000
qResult         dq  0


; ******************************************
; Code section

section .text
global _start
_start:

; Some basic additions

; ----
; Byte examples
; bResult = bVar1 + bVar2

mov     al, byte [bVar1]
add     al, byte [bVar2]
mov     byte [bResult], al

; ----
; Word examples
; wResult = wVar1 + wVar2

mov     ax, word [wVar1]
add     ax, word [wVar2]
mov     word [wResult], ax

; ----
; double-word examples
; dResult = dVar1 + Var2

mov     eax, dword [dVar1]
add     eax, dword [dVar2]
mov     dword [dResult], eax

; ----
; quad-word examples
; qResult = qVar1 + qVar2

mov     rax, qword [qVar1]
add     rax, qword [qVar2]
mov     qword [qResult], rax


; ******************************************
; Done, terminate program

last:
   
mov     rax, SYS_exit       ; call code for exit
mov     rdi, EXIT_SUCCESS   ; exit code
syscall
