
SYS_exit        equ     60
EXIT_SUCCESS    equ     0


section .text

global expFunc
expFunc:
    push rbp                    ; prologue
    mov  rbp, rsp
    ; allocate local vars 1 counter, array with 100 elements
    sub  rsp, 404
    push rbx
    push r12
    
    ; initialize counter var to 0
    mov  dword [rbp-404], 0
    
    inc  dword [rbp-404]        ; counter++ (example)
    
    ; loop to init array all to 0
    lea  rbx, dword [rbp-400]   ; address of array
    mov  r12, 0                 ; index
zeroLoop:
    mov  dword [rbx+r12*4], 0   ; array[index] = 0
    inc  r12
    cmp  r12, 100
    jl   zeroLoop
    
; -- here would come the work of the function

    pop  r12                    ; epilogue
    pop  rbx
    mov  rsp, rbp               ; clear locals
    pop  rbp
    ret


global _start
_start:

    call expFunc
    
last:
    mov  rax, SYS_exit
    mov  rdi, EXIT_SUCCESS
    syscall
