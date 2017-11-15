; Write a message to the screen

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


O_CREAT         equ         0x40
O_TRUNC         equ         0x200
O_APPEND        equ         0x400

O_RDONLY        equ         000000q
O_WRONLY        equ         000001q
O_RDWR          equ         000002q

S_IRUSR         equ         00400q
S_IWUSR         equ         00200q
S_IXUSR         equ         00100q


; variables

newLine         db      LF, NULL
header          db      LF, "File Write Example."
                db      LF, LF, NULL

fileName        db      "url.txt", NULL
url             db      "http://www.google.com"
                db      LF, NULL

; $ evaluates to the assembly position at
; the beginning of the line containing the expression
len             dq      $-url-1

writeDone       db      "Write Completed.", LF, NULL
fileDescriptor  dq      0
errorMsgOpen    db      "Error opening file.", LF, NULL
errorMsgWrite   db      "Error writing to file.", LF, NULL


section .text
global _start
_start:

    mov     rdi, header
    call    printString

    
; open file

openInputFile:
    mov     rax, SYS_creat
    mov     rdi, fileName
    mov     rsi, S_IRUSR | S_IWUSR
    syscall
    
    cmp     rax, 0      ; check for success
    jl      errorOnOpen
    
    mov     qword [fileDescriptor], rax

; write to file

    mov     rax, SYS_write
    mov     rdi, qword [fileDescriptor]
    mov     rsi, url
    mov     rdx, qword [len]
    syscall
    
    cmp     rax, 0
    jl      errorOnWrite

    mov     rdi, writeDone
    call    printString
    
    jmp     exampleDone
    
; error on open
; rax would contain error code, not used here

errorOnOpen:
    mov     rdi, errorMsgOpen
    call    printString
    
    jmp     exampleDone

; error on open
; rax would contain error code, not used here
errorOnWrite:
    mov     rdi, errorMsgWrite
    call    printString
    
    jmp     exampleDone

    
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
