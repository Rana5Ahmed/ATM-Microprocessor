.model ATM
.stack 100h
;org 100h
.data
    numberplace dw 10
    number dw 0
    money dd 0
    maxmoney dd 50000
    balancemoney dd 0
    invalidoption db 0ah,0dh,"Invalid Option$"
    inputnumber db 0ah,0dh,"Please select an option (1 to 5): $"
    incbankmessage db 0ah,0dh,"Welcome To the incredibles bank $"
    incbankdescription db 0ah,0dh,"The incredibles bank is bank for student which you can deposit to 50,000$"
    depositmessage db 0ah,0dh,"1.Deposit $"
    withdrawmessage db 0ah,0dh,"2.Withdraw $"
    balancemessage db 0ah,0dh,"3.Balance Inquiry $"
    extmessage db 0ah,0dh,"4.Exit $"
    temp db 0ah,0dh,"Function done $"
    newline db 0ah,0dh,"$"
    goodbye db 0ah,0dh,"It was our pleasure to serve you $"
    entermoneymessage db 0ah,0dh,"Enter amount of money : $"
    dashedline db 0ah,0dh,"--------------------------------------------$"
    donthavemoney db 0ah,0dh,"Sorry you don't have enough money $"
    zeromoney db 0ah,0dh,"You didn't enter any money Yet!! $"
    reached_50k db 0ah,0dh,"Congratulations, You have reached your first 50k, now you can open Bank an account $"
    morethan_50k db 0ah,0dh,"Sorry you can not have more than 50k in your account $"
    ;-------------------------------------------------------------------------------
    fname db 'first2.txt',0
    fhandle dw ?
    msgun db 0ah,0dh, 'Enter Username: $'
    msgpw1 db 0ah,0dh,'Enter Password: $'
    msgpw2 db 0ah,0dh,'Confirm Password: $'
    mgspw3 db 0ah,0dh,'Password invalid $'
    msgpw4 db 0ah,0dh,"Password Doesn't match $"
    buffer db 100 dup<'$'>
    bufferpw db 100 dup<'$'>
    bufferbalance db 100 dup<'$'>
    err db 'Error $'
    num1 dw 0
    num2 dw 0
    ten db 10
    reversedbalance dd 0
    tempmoney dd 0
    ;-------------------------------------------------------------------------------
    createaccountmsg db 0ah,0dh,"1-Create account $"
    loginmsg db 0ah,0dh,"2-Login $"
    extaccmsg db 0ah,0dh,"3-Exit $"
    soption db 0ah,0dh,"Please select an option (1 to 3) note that only 1 and 3 work others not done yet: $"
    ;-------------------------------------------------------------------------------
.code
main proc
    
     mov ax,@data
     mov ds,ax
        
                  
mov balancemoney, 0  ; balance money is always initally zero
    mov ah,09h  ; dos function 09h to print a string
    mov dx,offset dashedline    ; memory location of message "----------------------------------"
    int 21h     ; dos interrupt 21h
    mov dx,offset incbankmessage    ; memory location of message "Welcome To the incredibles bank"
    int 21h     ; dos interrupt 21h
    mov dx,offset incbankdescription    ; memory location of message "Welcome To the incredibles bank"
    int 21h     ; dos interrupt 21h
    

    mov ah,09h
    mov dx,offset createaccountmsg
    int 21h
    mov ah,09h
    mov dx,offset loginmsg
    int 21h
    mov ah,09h
    mov dx,offset extaccmsg  
    int 21h
    mov ah,09h
    mov dx,offset soption
    int 21h
    

    mov ah,01h
    int 21h
    cmp al,31h
    je  create
    cmp al,32h
    je  login
    cmp al,33h
    je  exitfunction
    cmp al,31h
    jl  invalid
    cmp al,31h
    jg  invalid
    
create:
    lea dx,msgun
        mov ah,09h
        int 21h
        
        mov si,0
        mov cx,0        
