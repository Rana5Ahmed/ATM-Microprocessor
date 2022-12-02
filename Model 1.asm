.model ATM
.code
org 100h

main proc near
mainprogram:
    mov ah,09h  ; dos function 09h to print a string
    mov dx,offset incbank    ; memory location of message "Welcome To the incredibles bank"
    int 21h     ; dos interrupt 21h 
    
    mov dx,offset deposit    ; memory location of message "1.Deposit"     
    int 21h     ; dos interrupt 21h         
    
    mov dx,offset withdraw    ; memory location of message "2.Withdraw"
    int 21h     ; dos interrupt 21h
    
    mov dx,offset balance    ; memory location of message "3.Balance Inquiry"
    int 21h     ; dos interrupt 21h
    
    mov dx,offset loan    ; memory location of message "4.Take Loan"
    int 21h     ; dos interrupt 21h
                                                             
    mov dx,offset ext    ; memory location of message "5.Exit"
    int 21h     ; dos interrupt 21h


loop_number_main:
    mov ah,09h  ; dos function 09h to print a string
    mov dx,offset inputnumber    ; memory location of message "Please select an option (1 to 5): "
    int 21h     ; dos interrupt 21h
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h     ; dos interrupt 21h
    
    mov number,0    ; set initial value of number to 0
loop_read_number:

    mov ah,01h  ; dos function to read a character with echo from keyboard
                ; result (character entered) is stored in al
    int 21h     ; dos interrupt 21h
    
    cmp al,0dh  ; check if enter key is pressed
    je numbercomplete   ; jump to numbercompletd if enter key is pressed
    
    cmp al,31h  ; check if input character is less then 1, 
                ; here we are validating user input to check if entered character is betwen 1 and 5 both included
    jl invalidcharacter ; jump to display invalid character
 
    cmp al,35h  ; check if input character is great then 5
    jg invalidcharacter ; jump to display invalid option
    
    
    sub al,30h  ; subtract 30h character code of character 0 from input to get numeric value
    mov ah,00                            
    mov bx,ax   ; temporarily store value of read character in bx 
    
    mov ax,number   ; copy number to ax
    mul numberplace ; we multipley number with 10. 
                    ; first time the number is 0 so multiplication with 10 it will remain same
    
    add ax,bx       ; add the newly entered number to number variable
    mov number,ax
    
   
    jmp loop_read_number
    
    
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

    cmp al,1
    je depositfunction
    cmp al,2
    je withdrawfunction
    cmp al,3
    je balancefunction
    cmp al,4
    je loanfunction
    cmp al,5
    je exitfunction
     
    
    
depositfunction: 
    mov ah,09h
    mov dx,offset temp    ; memory location of message "1.Deposit"     
    int 21h     ; dos interrupt 21h
    jmp main
withdrawfunction: 
    mov ah,09h
    mov dx,offset temp    ; memory location of message "1.Deposit"     
    int 21h     ; dos interrupt 21h
    jmp main
balancefunction: 
    mov ah,09h
    mov dx,offset temp    ; memory location of message "1.Deposit"     
    int 21h     ; dos interrupt 21h
    jmp main
loanfunction: 
    mov ah,09h
    mov dx,offset temp    ; memory location of message "1.Deposit"     
    int 21h     ; dos interrupt 21h
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
                    








endp
numberplace db 10
number dw 0
invalidoption db 0ah,0dh,"Invalid Option$"
inputnumber db 0ah,0dh,"Please select an option (1 to 5): $"
incbank db 0ah,0dh,"Welcome To the incredibles bank $"
deposit db 0ah,0dh,"1.Deposit $"
withdraw db 0ah,0dh,"2.Withdraw $"
balance db 0ah,0dh,"3.Balance Inquiry $"
loan db 0ah,0dh,"4.Take Loan $"
ext db 0ah,0dh,"5.Exit $"
temp db 0ah,0dh,"Function done $"
newline db 0ah,0dh,"$"
goodbye db 0ah,0dh,"Goodbye $"
end main