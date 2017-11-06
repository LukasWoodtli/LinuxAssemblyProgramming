; example for a function that is called like:
; stats2(arr, len, min, med1, med2, max, sum, ave)

EXIT_SUCCESS    equ     0
SYS_exit        equ     60


section .data

len     dd   5
arr     dd   1, 2, 3, 4, 5


section .bss

min     resd    1
max     resd    1
ave     resd    1
sum     resd    1
med1    resd    1
med2    resd    1


section .text

; function calculates sum, average, median 1, meidan2,
; min and max of an array
; HLL call: stats1(arr, len, min, med1, med2, max, sum, ave);
; Args:
;   arr, address - rdi
;   len, value -rsi
;   min, address -rdx
;   med1, address -rcx
;   med2, address -r8
;   max, address -r9
;   sum, address - stack (rbp + 16)
;   ave, address - stack (rbp+24)
global stats2
stats2:
    push    rbp         ; prologue
    mov     rbp, rsp
    push    rbx
    push    r12

; --- get min and max (array is sorted)
    mov     eax, dword [rdi]    ; get min
    mov     dword [rdx], eax    ; return min
    
    mov     r12, rsi
    dec     r12                 ; --len
    mov eax, dword [rdi+r12*4]  ; get max
    mov dword [r9], eax         ; return max

; --- get medians
    mov rax, rsi
    mov rdx, 0
    mov r12, 2
    div r12                     ; rax = len/2
    
    cmp rdx, 0                  ; even/odd
    je  evenLength

    mov r12, qword [rdi+rax*4]  ; get arr[len/2]
    mov qword [rcx], r12
    mov qword [r8], r12
    jmp medDone

evenLength:
    mov r12, qword [rdi+rax*4]  ; get arr[len/2]
    mov qword [r8], r12
    dec rbx
    mov r12, qword [rdi+rax*4]  ; get arr[len/2-1]
    mov qword [rcx], r12
    
medDone:

; --- find sum

    mov r12, 0      ; counter/index
    mov rax, 0      ; running sum

sumLoop:    
    add     eax, dword [rdi+r12*4]  ; sum += arr[i]
    inc     r12
    cmp     r12, rsi
    jl      sumLoop
    
    mov     r12, qword [rbp+16]     ; get sum addr
    mov     dword [r12], eax        ; return sum
    
; --- calc average
    
    cdq
    idiv    rsi                 ; compute ave
    mov     r12, qword [rbp+24] ; get ave addr
    mov     dword [r12], eax
    
    pop     r12                 ; epilogue
    pop     rbx
    pop     rbp
    ret


global _start
_start:
  ; ...
  
  push  ave               ; 8th arg
  push  sum               ; 7th arg
  mov   r9, max           ; 6th arg
  mov   r8, med2          ; 5th arg
  mov   rcx, med1         ; 4th arg
  mov   rdx, min          ; 3rd arg
  mov   esi, dword [len]  ; 2nd ard
  mov   rdi, arr          ; 1st arg
  call  stats2
  add   rsp, 16           ; clear passed args

last:
    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall
