; Simple example


; ******************************************
; Basic data declarations (initialized vars)

section .data

; ----
; Constants
EXIT_SUCCESS    equ 0   ; successful exit code
SYS_exit        equ 60  ; call code for terminate


; ----
; 64-bit (quad-word) variable declarations
qFirstVal           dq  0xffffffffffffffff

; ----
; 32-bit (double-word) variable declarations
dVar32           dd  0xabcdefab

; ----
; 16-bit (word) variable declarations
wVar16           dw  0xbdbd



; ******************************************
; Code section

section .text
global _start
_start:


mov     rax, qword [qFirstVal]
mov     ax, word [wVar16]
; now rax has value 0xffffffffffffbdbd
; the upper part of the register is kept

mov     rax, qword [qFirstVal]
mov     eax, dword [dVar32]
; now rax has value 0x00000000abcdefab
; the upper part of the register is cleared!

; ******************************************
; Done, terminate program

last:

mov     rax, SYS_exit       ; call code for exit
mov     rdi, EXIT_SUCCESS   ; exit code
syscall
