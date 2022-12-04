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


loop_number_main:
    mov ah,09h  ; dos function 09h to print a string
    mov dx,offset inputnumber    ; memory location of message "Please select an option (1 to 5): "
    int 21h     ; dos interrupt 21h
    
    mov number,0    ; set initial value of number to 0
loop_read_number:

    mov ah,1  ; dos function to read a character with echo from keyboard
                ; result (character entered) is stored in al
    int 21h     ; dos interrupt 21h
    
    cmp al,0dh  ; check if enter key is pressed
    je numbercomplete   ; jump to numbercompletd if enter key is pressed
    
    cmp al,31h  ; check if input character is less then 1, 
                ; here we are validating user input to check if entered character is betwen 1 and 5 both included
    jl invalidcharacter ; jump to display invalid character
 
    cmp al,39h  ; check if input character is great then 5
    jg invalidcharacter ; jump to display invalid option
    
    
    sub al,30h  ; subtract 30h character code of character 0 from input to get numeric value
                ; as input is ascii and to convert from ascii to numeric you subtract ascii - 30h 
    mov ah,00                            
    mov bx,ax   ; temporarily store value of read character in bx 
    
    mov ax,number   ; copy number to ax
    mul numberplace ; we multipley number with 10. 
                    ; first time the number is 0 so multiplication with 10 it will remain same
    
    add ax,bx       ; add the newly entered number to number variable
    mov number,ax
    
    cmp al,1
    je entermoney
    cmp al,2
    je entermoney
    cmp al,3
    je balancefunction
    cmp al,4
    je loanfunction
    cmp al,5
    je exitfunction
    cmp al,5
    jg invalidcharacter
    
    
    
invalidcharacter:
    mov ah,09h  ; dos function 09h to print a string
    mov dx,offset invalidoption   ; memoery location of message "Invalid Option"
    int 21h     ; dos interrupt 21h
    
    jmp loop_number_main           
        
numbercomplete:
    ; When the user press enter the control will transfer to this location
    ; decimal value of input numeric charaters  is stored in variable number 
    
    mov ax,number ; this line can be removed. I am addint this only so that 
                  ; you can check the value of number in ax register in emu8086


    ; Here you can write code to display the number 
    ; or use entered number as an input for other program 
    jmp main
    
     
    
    
entermoney:
    mov money, 0 ;money is the variable that we scan deposit / withraw in 
    mov ah,09h ; dos function 09h to print a string
    mov dx,offset entermoneymessage    ; memory location of message "enter money: "
    int 21h    ; dos interrupt 21h
scan_money:
    mov ah,1  ; dos function to read a character with echo from keyboard
    int 21h   ; dos interrupt 21h
    mov bl,al ; save scanned input in temporary variable
    cmp al,0dh ; check if user pressed enter and didn't enter any money yet
    je checkemptynumber
notempty:
    cmp al,0dh ; check if user pressed enter and entered moeny already
    je numberdone
    mov al,bl  ; return scanned input in temporary variable
    cmp al,30h  ; check if input character is less then 1, 
                ; here we are validating user input to check if entered character is betwen 0 and 9 both included
    jl invalidcharacter ; jump to display invalid character
 
    
    cmp al,39h  ; check if input character is great then 9
    jg invalidcharacter ; jump to display invalid option
    
    
    mov bl, al ; save scanned input in temporary variable and subtracting 30 to get numeric value
    mov bh,00h
    sub bx, 30h
    
    mov ax,money ; puting old value of money in ax and multiplying it by 10 to move whole number one digit to left
    mul numberplace ; numberplace is 10 
    mov money,ax ; returning the amount of money to money variable after last addition then adding bx to it   
    add money,bx ; bx is last scanned digit
    
    add bl,30h   ; adding 30h to bl to return to ascii code of input 
    mov al,bl
    cmp al,0dh   ; check if enter key is pressed ( number is completed )
    jne scan_money ; if not ( the last input wasn't enter , loop again to scan another digit
numberdone:
    mov ah,09h  ; dos function 09h to print a string
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h     ; dos interrupt 21h
    mov ax, money  ; we moved money into ax as we later will add/sub money to/from balancemoney and we can't do add/sub variable variable
    
    cmp number ,1  ; if the input option was 1 or 2 it'll go to depoist or withdraw
    je depositfunction
    
    cmp number ,2 
    je withdrawfunction
    
    
    jmp main
checkemptynumber:
    cmp money, 0 ;check if enter is pressed but money is still 0
    je  emptynumber
    jmp notempty ; if not empty then return to continue 
    
emptynumber:
    mov ah,09h
    mov dx,offset zeromoney    ; memory location of message "Youdidn't enter money yet"
    int 21h
    mov dx,offset newline    ; memory location of message "new line"
    int 21h
    jmp entermoney
    
        
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
numberplace dw 10
number dw 0
money dd 0
;withdrawmoney dd 0
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