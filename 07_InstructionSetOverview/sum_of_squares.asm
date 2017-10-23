
section .data

SUCCESS   equ     0
SYS_exit  equ    60

n               dd    10
sumOfSquares    dq    0


section .text
global _start
_start:


; compute sum of squares from 1 to n


  mov rbx, 1
  mov ecx, dword [n]

sumLoop:
  mov rax, rbx
  mul rax;                        ; i^2
  add qword [sumOfSquares], rax
  inc rbx
  loop sumLoop

last:
  mov rax, SYS_exit
  mov rdi, SUCCESS
  syscall
