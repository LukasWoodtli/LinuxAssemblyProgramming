
section .data
; no data for this example

section .text

; Function stats(lst, len, &sum, &ave);

global stats
stats:
    push    r12

; find and return sum
    mov     r11, 0      ; i=0
    mov     r12d, 0     ; sum=0
    
sumLoop:
    mov     eax, dword [rdi+r11*4]  ; get lst[i]
    add     r12d, eax               ; update sum
    inc     r11                     ; i++
    cmp     r11, rsi
    jb      sumLoop

    mov     dword [rdx], r12d       ; return sum

; find and return average
    mov     eax, r12d
    cdq
    idiv    esi

    mov     dword [rcx], eax        ; return average
    
; return to calling function
    pop     r12
    ret

