; example for a function that is called like: stats1(arr, len, sum, ave)


EXIT_SUCCESS    equ     0
SYS_exit        equ     60


section .data

len     dd   5
arr     dd   1, 2, 3, 4, 5


section .bss

ave     resd    1
sum     resd    1


section .text

; function calculates sum and average of an array
; HLL call: stats1(arr, len, sum, ave);
; Args:
;   arr, address - rdi
;   len, value -rsi
;   sum, address - rdx
;   ave, address - rcx
global stats1
stats1:
    push    r12         ; prologue

    mov     r12, 0      ; counter/index
    mov     rax, 0      ; running sum

sumLoop:    
    add     eax, dword [rdi+r12*4]  ; sum += arr[i]
    inc     r12
    cmp     r12, rsi
    jl      sumLoop
    
    mov     dword [rdx], eax
    
    cdq
    idiv    rsi                 ; compute ave
    mov     dword [rcx], eax    ; return ave
    
    pop     r12                 ; epilogue
    ret




global _start
_start:
  ; ...
  
  mov rcx, ave          ; 4th arg
  mov rdx, sum          ; 3rd arg
  mov esi, dword [len]  ; 2nd ard
  mov rdi, arr          ; 1st arg
  call stats1

last:
    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall
