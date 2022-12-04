.model ATM
.code
org 100h
mov balancemoney, 0  ; balance money is always initally zero
main proc near
    mov ah,09h  ; dos function 09h to print a string
    mov dx,offset dashedline    ; memory location of message "----------------------------------"
    int 21h     ; dos interrupt 21h
    mov dx,offset incbankmessage    ; memory location of message "Welcome To the incredibles bank"
    int 21h     ; dos interrupt 21h 
    
    mov dx,offset depositmessage    ; memory location of message "1.Deposit"     
    int 21h     ; dos interrupt 21h         
    
    mov dx,offset withdrawmessage    ; memory location of message "2.Withdraw"
    int 21h     ; dos interrupt 21h
    
    mov dx,offset balancemessage    ; memory location of message "3.Balance Inquiry"
    int 21h     ; dos interrupt 21h
    
    mov dx,offset loanmessage    ; memory location of message "4.Take Loan"
    int 21h     ; dos interrupt 21h
                                                             
    mov dx,offset extmessage    ; memory location of message "5.Exit"
    int 21h     ; dos interrupt 21h
    mov dx,offset dashedline    ; memory location of message "----------------------------------"
    int 21h     ; dos interrupt 21h
    
numberplace dw 10
number dw 0
money dd 0
balancemoney dd 0
invalidoption db 0ah,0dh,"Invalid Option$"
inputnumber db 0ah,0dh,"Please select an option (1 to 5): $"
incbankmessage db 0ah,0dh,"Welcome To the incredibles bank $"
depositmessage db 0ah,0dh,"1.Deposit $"
withdrawmessage db 0ah,0dh,"2.Withdraw $"
balancemessage db 0ah,0dh,"3.Balance Inquiry $"
loanmessage db 0ah,0dh,"4.Take Loan $"
extmessage db 0ah,0dh,"5.Exit $"
temp db 0ah,0dh,"Function done $"
newline db 0ah,0dh,"$"
goodbye db 0ah,0dh,"Goodbye $"
entermoneymessage db 0ah,0dh,"Enter amount of money : $"
dashedline db 0ah,0dh,"--------------------------------------------$"
donthavemoney db 0ah,0dh,"Sorry you don't have enough money $"
zeromoney db 0ah,0dh,"You didn't enter any money Yet!! $"
end main
