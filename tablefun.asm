; 
; FILENAME:     tablefun.asm
; CREATED BY:   Brian Hart
; DATE:         03 Dec 2018
; PURPOSE:      Working with tables and arrays of data
;

section .text
    global _start                       ; must be declared for linker (ld)
   
_start:
    ; Note, the TutorialsPoint.com site has the statement below as, e.g.,
    ; mov AL, BYTE_VALUE -- but this is not the correct syntax.  The correct thing
    ; to do in NASM is to put the keyword BYTE, and then to put the BYTE_VALUE in 
    ; square brackets.

    mov  AL, BYTE [BYTE_VALUE]          ; Copies the value contained in BYTE_VALUE into AL                  
    add  BYTE [BYTE_VALUE], 65          ; An immediate operand 65 is added to the value of BYTE_VALUE
    mov  AL, BYTE [BYTE_VALUE]          ; Clobbers the value of AL with the new value of BYTE_VALUE
    mov  AX, 45H                        ; Immediate constant 45H is transferred to AX, clobbering the prev value
    
    ; Okay, now let's work with the memory locations without brackets, and see if this works.
    mov EAX, BYTE_VALUE                 ; *Should* copy the *address of* BYTE_VALUE into register EAX
    ;add BYTE_VALUE, 65H                ; SHOULD add 65 hex to the address of BYTE_VALUE, but does not compile
    ;add BYTE_VALUE, DL                 ; SHOULD add whatever is in register EDX to the address of BYTE_VALUE, but does not compile
    
    ; Time for some fun with tables
    ; TutorialsPoint.com does it wrong, you need to add sq brackets around table/array access
    xor ECX, ECX                        ; zero out the ECX register
    mov CL, [BYTE_TABLE + 2]            ; Access the value at the 3rd position of BYTE_TABLE and copy it to CL
    ;mov CL, BYTE_TABLE[2]              ; Should do the same thing, but this way does not compile
    xor ECX, ECX                        ; zero out the ECX register

    mov ebx, [MY_TABLE]                   ; Effective Address of MY_TABLE in EBX
            
    mov eax,1                           ; system call number (sys_exit)
    mov ebx,0                           ; process exit code
    int 0x80                            ; call kernel
     
section .data                           ; static data
    BYTE_VALUE  DB  150                 ; A byte value is defined
    WORD_VALUE  DW  300                 ; A word value is defined
    
    ; Below is how we declare static arrays in assembly.  Much like in
    ; C: int BYTE_TABLE[] = { 14, 15, 22, 45 };
    
    BYTE_TABLE DB  14, 15, 22, 45      ; Tables of bytes
    WORD_TABLE DW  134, 345, 564, 123  ; Tables of words    

    MY_TABLE TIMES 10 DW 0             ; Allocates 10 words (2 bytes) each initialized to 0   
        
    ; The labels BYTE_TABLE and WORD_TABLE start off by containing the address 
    ; of the first element of each array, indexed starting with zero

section .bss                            ; dynamically-changed variables
    ; TODO: Add dynamically-changed variables here
