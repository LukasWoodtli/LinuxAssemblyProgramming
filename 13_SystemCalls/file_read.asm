
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

BUFF_SIZE       equ     255

newLine         db      LF, NULL
header          db      LF, "File Read Example."
                db      LF, LF, NULL

fileName        db      "url.txt", NULL

fileDescriptor  dq      0

errorMsgOpen    db      "Error opening file.", LF, NULL
errorMsgRead    db      "Error reading from file.", LF, NULL


section .bss
readBuffer      resb    BUFF_SIZE

section .text
global _start
_start:

    mov     rdi, header
    call    printString

    
; open file

openInputFile:
    mov     rax, SYS_open
    mov     rdi, fileName
    mov     rsi, O_RDONLY
    syscall
    
    cmp     rax, 0      ; check for success
    jl      errorOnOpen
    
    mov     qword [fileDescriptor], rax

; read from file

    mov     rax, SYS_read
    mov     rdi, qword [fileDescriptor]
    mov     rsi, readBuffer
    mov     rdx, BUFF_SIZE
    syscall
    
    cmp     rax, 0
    jl      errorOnRead

    
; print buffer
    mov     rsi, readBuffer
    mov     qword [rsi+rax], NULL     ; terminate string

    mov     rdi, readBuffer
    call    printString
    
    jmp     exampleDone

; close the file
    mov     rax, SYS_close
    mov     rdi, qword [fileDescriptor]
    syscall

    jmp     exampleDone

; error on open
; rax would contain error code, not used here

errorOnOpen:
    mov     rdi, errorMsgOpen
    call    printString
    
    jmp     exampleDone

; error on open
; rax would contain error code, not used here
errorOnRead:
    mov     rdi, errorMsgRead
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
    push rbp
    mov  rbp, rsp
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
    pop  rbx
    pop  rbp
    ret
