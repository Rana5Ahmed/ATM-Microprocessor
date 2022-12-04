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
