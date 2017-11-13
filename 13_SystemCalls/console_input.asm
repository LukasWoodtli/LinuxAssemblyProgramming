; Write a message to the screen and
; read a string from stdin

section .data

LF              equ        10       ; line feed
NULL            equ         0       ; end of string

TRUE            equ         1
FALSE           equ         0

EXIT_SUCCESS    equ         0

STDIN           equ         0
STDOUT          equ         1
STDERR          equ         2

; syscall codes
SYS_read        equ         0
SYS_write       equ         1
SYS_open        equ         2
SYS_close       equ         3
SYS_fork        equ         57
SYS_exit        equ         60
SYS_creat       equ         85
SYS_time        equ         201

; strings
STRLEN          equ     50

pmpt            db      "Enter Text: ", NULL
newLine         db      LF, NULL


section .bss
chr             resb    1
inLine          resb    STRLEN + 2

section .text
global _start
_start:

    mov     rdi, pmpt
    call    printString

    ; read chars from user
    mov     rbx, inLine         ; inLine addr
    mov     r12, 0              ; char count

readCharacters:
    mov     rax, SYS_read       ; sys code for read
    mov     rdi, STDIN
    lea     rsi, [chr]          ; addrees of chr
    mov     rdx, 1              ; count (how many to read)
    syscall

    mov     al, byte [chr]      ; get char
    cmp     al, LF              ; if LF: done
    je      readDone

    inc     r12                 ; count++
    cmp     r12, STRLEN         ; if # chars > STRLEN
    jge     readCharacters      ;   stop placing in buffer

    mov     byte [rbx], al      ; inLine[i] = chr
    inc     rbx                 ; update tmpStr addr

    jmp     readCharacters

readDone:
    ; output line to verify successful read
    mov     rdi, inLine
    call    printString

exampleDone:
    mov     rax, SYS_exit
    mov     rdi, EXIT_SUCCESS
    syscall


; Function to display string on screen
; - count chars (excluding NULL)
; - use syscall to display string
global printString
printString:
    push rbx

    ; count chars
    mov  rbx, rdi         ; address of string
    mov  rdx, 0           ; len of string

strCountLoop:
    cmp  byte [rbx], NULL
    je   strCountDone
    inc  rdx
    inc  rbx
    jmp  strCountLoop

strCountDone:
    cmp  rdx, 0             ; strlen == 0
    je   prtDone

; syscall: write
    mov  rax, SYS_write     ; system code: write()
    mov  rsi, rdi           ; address of string to write
    mov  rdi, STDOUT        ; file descriptor for stdout
                            ; rdx: count (set above)
    syscall

prtDone:
    pop  rdx
    ret
