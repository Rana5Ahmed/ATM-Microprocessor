depositfunction:
    add balancemoney,ax
    mov ah,09h
    mov dx,offset newline    ; memory location of message "new line"
    int 21h
    mov dx,offset temp    ; memory location of message "Function done"
    int 21h
    mov dx,offset newline    ; memory location of message "new line"
    int 21h
    jmp main
        
withdrawfunction:
    mov ax,money
    cmp balancemoney,ax
    jl failedwithdraw
    sub balancemoney,ax 
    mov ah,09h
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h
    mov dx,offset temp    ; memory location of message "Function done"     
    int 21h     ; dos interrupt 21h
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h
    jmp main
failedwithdraw:
    mov ah,09h
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h
    mov dx,offset donthavemoney    ; memory location of message "Function done"     
    int 21h     ; dos interrupt 21h
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h
    jmp main
balancefunction: 
    mov ah,09h
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h
    mov dx,offset temp    ; memory location of message "Function done"     
    int 21h     ; dos interrupt 21h
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h
    jmp main
loanfunction: 
    mov ah,09h
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h
    mov dx,offset temp    ; memory location of message "Function done"     
    int 21h     ; dos interrupt 21h
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h
    jmp main
exitfunction: 
    mov ah,09h
    mov dx,offset goodbye    ; memory location of message "Goodbye"
    int 21h     ; dos interrupt 21h 
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h     ; dos interrupt 21h
    mov ah,4ch      ; dos function 4ch to terminate and return to dos
    mov al,00       
    int 21h         ; dos interrupt 21h
    mov ah,4ch      ; dos function 4ch to terminate and return to dos
    mov al,00       
    int 21h         ; dos interrupt 21h


endp