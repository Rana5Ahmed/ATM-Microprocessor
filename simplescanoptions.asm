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
