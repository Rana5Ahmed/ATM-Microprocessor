.model ATM
.stack 100h
.data
    numberplace dw 10
    number db 0
    money dd 0
    maxmoney dd 50000
    balancemoney dd 0
    counter db 0
    ;----------------------------------------------Messages----------------------------------------------------
    invalidoption db 0ah,0dh,"Invalid Option$"
    inputnumber db 0ah,0dh,"Please select an option (1 to 5): $"
    incbankmessage db 0ah,0dh,"Welcome To the incredibles bank $"
    incbankdescription db 0ah,0dh,"The incredibles bank is bank for student which you can deposit to 50,000$"
    depositmessage db 0ah,0dh,"1.Deposit $"
    withdrawmessage db 0ah,0dh,"2.Withdraw $"
    balancemessage db 0ah,0dh,"3.Balance Inquiry $"
    logoutmsg db 0ah,0dh,"4.Log out $ "
    extmessage db 0ah,0dh,"5.Exit $"
    temp db 0ah,0dh,"Function done $"
    newline db 0ah,0dh,"$"
    goodbye db 0ah,0dh,"It was our pleasure to serve you $"
    entermoneymessage db 0ah,0dh,"Enter amount of money : $"
    dashedline db 0ah,0dh,"--------------------------------------------$"
    donthavemoney db 0ah,0dh,"Sorry you do not have enough money $"
    zeromoney db 0ah,0dh,"You did not enter any money Yet!! $"
    reached_50k db 0ah,0dh,"Congratulations, You have reached your first 50k, now you can open a new Bank account $"
    morethan_50k db 0ah,0dh,"Sorry you can not Deposit/Withdraw more than 50k in your account $" 
    msgpw1 db 0ah,0dh,'Please Enter Your ID: $'
    msgpw2 db 0ah,0dh,'Confirm ID: $'
    mgspw3 db 0ah,0dh,'invalid ID $'
    wrong_username_pwmsg db 0ah,0dh,"Sorry, Wrong ID $"
    currentbalancemsg db ,"Your current balance is : $"
    sdashedline db 0ah,0dh,"--------------------------------$"

    ;----------------------------------------------End Messages-----------------------------------------------------
    buffer db 100 dup<'$'>
    bufferpw db 100 dup<'$'>
    bufferbalance dd 100 dup<'$'>
    err db 'Error $'
    num1 db 100 dup<'$'>
    tempvar db 0
    num2 dw 0
    ten db 10
    reversedbalance dd 0
    tempmoney dd 0
    fhandle dw ?
    pass dw 0
    ;-------------------------------------------------------------------------------

    ;-------------------------------------------------------------------------------
    ;------------------------user 1 ----------------------- 
     user1msg db 0ah,0dh, "Welcome, [EZZAT] $"
     pass1 dw 1234
     user1file db  "ezzat.txt",0
     ;balance1 dd  250
    ;---------------------End user 1 ----------------------
    
    
    ;------------------------user 2 ----------------------- 
     user2msg db  0ah,0dh, "Welcome, [RANEEM] $"
     pass2 dw 5555
     user2file db  "raneem.txt",0 
     ;balance2 dd  13 
     ;---------------------End user 2 ----------------------
    
    
    ;------------------------user 3 -----------------------
     user3msg db  0ah,0dh, "Welcome, [TAREK] $"
     pass3 dw 6789
     user3file db  "tarek.txt",0
     ;balance3 dd  1234
    ;---------------------End user 3 ----------------------   
    current_user db 0
.code
main proc
    
     mov ax,@data
     mov ds,ax
        
                  

    mov ah,09h  ; dos function 09h to print a string
    mov dx,offset incbankmessage    ; memory location of message "Welcome To the incredibles bank"
    int 21h     ; dos interrupt 21h
    mov dx,offset incbankdescription    ; memory location of message "Welcome To the incredibles bank"
    int 21h     ; dos interrupt 21h

; --------------------------Scan username and password-------------------------------------
    
password:    
        ;Password Check Level
    mov pass,0
    mov bx,offset pass
    
    mov ah,9
    lea dx,msgpw1
    int 21h
    
    cheekpass:
    cmp pass,9999
    jg worng
    mov ah,8
    int 21h
    
    cmp al,13 
    je testpw
    
    mov bl,al
    sub bl,30h
    mov ax,pass
    mul numberplace
    mov bh,00h
    add ax,bx
    mov pass,ax
    mov ah,2
    mov dl,42
    int 21h
    
    jmp cheekpass
testpw:    
    mov ax,3h
    int 10h
    mov ax,pass
    cmp ax,pass1
    je log_user1
    
    cmp ax,pass2
    je log_user2
    
    cmp ax,pass3
    je log_user3
    
    jmp worng

log_user1:

    mov ah,3dh
    lea dx,user1file
    mov al,0
    int 21h
    mov fhandle,ax
    mov ah ,3fh
    lea dx,bufferbalance
    mov cx,100
    mov bx,  fhandle
    int 21h
    lea dx,bufferbalance
    mov ah,09h
    int 21h
    mov ah,3eh
    mov bx,fhandle
    int 21h
    mov current_user,1
    mov ax,bufferbalance
    mov balancemoney,ax
    jmp below_main_bank
log_user2:
    mov ah,3dh
    lea dx,user2file
    mov al,0
    int 21h
    mov fhandle,ax
    mov ah ,3fh
    lea dx,bufferbalance
    mov cx,100
    mov bx,  fhandle
    int 21h
    lea dx,bufferbalance
    mov ah,09h
    int 21h
    mov ah,3eh
    mov bx,fhandle
    int 21h
    mov current_user,2
    mov ax,bufferbalance
    mov balancemoney,ax

    jmp below_main_bank
log_user3:
    mov ah,3dh
    lea dx,user3file
    mov al,0
    int 21h
    mov fhandle,ax
    mov ah ,3fh
    lea dx,bufferbalance
    mov cx,100
    mov bx,  fhandle
    int 21h
    lea dx,bufferbalance
    mov ah,09h
    int 21h
    mov ah,3eh
    mov bx,fhandle
    int 21h
    mov current_user,3
    mov ax,bufferbalance
    mov balancemoney,ax
    jmp below_main_bank        
    
         
    
    ;Worng Password Level
    worng:
    mov ax,3h
    int 10h
    mov ah,9
    lea dx,wrong_username_pwmsg
    int 21h
    mov pass,0
    jmp password
   

; --------------------------End scan username and password------------------------------------- 

;--------------------------Main processes of the bank-------------------------------------------    
above_main_bank:
    mov ax,3h
    int 10h
    cmp current_user,1
    je u1
    cmp current_user,2
    je u2
    cmp current_user,3
    je u3


u1:

    mov ah,09h  ; dos function 09h to print a string
    mov dx,offset user1msg    ; memory location of message "Welcome To the incredibles bank"
    int 21h     ; dos interrupt 21h
    jmp main_bank
u2:

    mov ah,09h  ; dos function 09h to print a string
    mov dx,offset user2msg    ; memory location of message "Welcome To the incredibles bank"
    int 21h     ; dos interrupt 21h 
    jmp main_bank
u3:

    mov ah,09h  ; dos function 09h to print a string
    mov dx,offset user3msg    ; memory location of message "Welcome To the incredibles bank"
    int 21h     ; dos interrupt 21h
    jmp main_bank
            
    

;--------------------------Main processes of the bank-------------------------------------------    

    
main_bank:
    
    mov ah,09h  ; dos function 09h to print a string
    mov dx,offset incbankmessage    ; memory location of message "Welcome To the incredibles bank"
    int 21h     ; dos interrupt 21h
    mov dx,offset incbankdescription    ; memory location of message "Welcome To the incredibles bank"
    int 21h     ; dos interrupt 21h
    
    
    mov dx,offset dashedline    ; memory location of message "----------------------------------"
    int 21h     ; dos interrupt 21h    
    mov ah,09h  ; dos function 09h to print a string 
    mov dx,offset depositmessage    ; memory location of message "1.Deposit"     
    int 21h     ; dos interrupt 21h         
    
    mov dx,offset withdrawmessage    ; memory location of message "2.Withdraw"
    int 21h     ; dos interrupt 21h
    
    mov dx,offset balancemessage    ; memory location of message "3.Balance Inquiry"logoutmsg
    int 21h     ; dos interrupt 21h
    
    mov dx,offset logoutmsg    ; memory location of message "4.Log out"
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
 
    cmp al,35h  ; check if input character is great then 5
    jg invalidcharacter ; jump to display invalid option
    
    
    sub al,30h  ; subtract 30h character code of character 0 from input to get numeric value
                ; as input is ascii and to convert from ascii to numeric you subtract ascii - 30h 
    mov number,al
    
    cmp al,1
    je entermoney
    
    cmp al,2
    je entermoney
    
    cmp al,3
    je inquire
    cmp al,4
    je logout
    cmp al,5
    je exitfunction
    cmp al,5
    jg invalidcharacter
    
    
    
invalidcharacter:
    mov ax,3h
    int 10h
    mov ah,09h  ; dos function 09h to print a string
    mov dx,offset invalidoption   ; memoery location of message "Invalid Option"
    int 21h     ; dos interrupt 21h
    
    jmp main_bank           
        
numbercomplete:
    ; When the user press enter the control will transfer to this location
    ; decimal value of input numeric charaters  is stored in variable number 
    
    mov ax,03h
    int 10h
    ; Here you can write code to display the number 
    ; or use entered number as an input for other program 
    jmp above_main_bank
entermoney:
    
    mov money, 0 ;money is the variable that we scan deposit / withraw in 
    mov ah,09h ; dos function 09h to print a string
    mov dx,offset entermoneymessage    ; memory location of message "enter money: "
    int 21h    ; dos interrupt 21h
scan_money:
    cmp money , 50000
    ja morefullmoney
    cmp money,50000
    je numberdone
    mov ah,1  ; dos function to read a character with echo from keyboard
    int 21h   ; dos interrupt 21h
    mov bl,al ; save scanned input in temporary variable
    cmp al,0dh ; check if user pressed enter and didn't enter any money yet
    je checkemptynumber

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
    inc counter
    cmp counter,5
    jnl numberdone
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
    jmp main_bank
checkemptynumber:
    cmp money, 0 ;check if enter is pressed but money is still 0
    je  emptynumber
    jmp numberdone ; if not empty then return to continue 
    
emptynumber:
    mov ah,09h
    mov dx,offset zeromoney    ; memory location of message "Youdidn't enter money yet"
    int 21h
    mov dx,offset newline    ; memory location of message "new line"
    int 21h
    jmp entermoney
    
depositfunction:
    cmp ax,maxmoney
    je  fullmoneydeposit
    cmp ax,maxmoney
    jnb morefullmoney
    mov bx,balancemoney
    add bx,money
    cmp bx,maxmoney                     
    je fullmoney
    cmp bx,maxmoney
    jnb morefullmoney
    cmp bx, balancemoney
    jb  morefullmoney 
    mov balancemoney,bx
    mov ax,3h
    int 10h
    mov ah,09h
    mov dx,offset newline    ; memory location of message "new line"
    int 21h
    mov dx,offset temp    ; memory location of message "Function done"
    int 21h
    mov dx,offset newline    ; memory location of message "new line"
    int 21h
    jmp main_bank
fullmoney:
    mov balancemoney,50000
    mov ah,09h
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h
    mov dx,offset reached_50k    ; memory location of message "reached_50k"     
    int 21h     ; dos interrupt 21h
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h
    jmp main_bank
morefullmoney:
    mov ah,09h
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h
    mov dx,offset morethan_50k    ; memory location of message "Function done"     
    int 21h     ; dos interrupt 21h
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h
    jmp main_bank
fullmoneydeposit: 
    cmp balancemoney,0
    je fullmoney
    cmp balancemoney,0
    jne morefullmoney
withdrawfunction:
    mov ax,money
    cmp balancemoney,ax
    jb failedwithdraw
    sub balancemoney,ax
    mov ax,3h
    int 10h 
    mov ah,09h
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h
    mov dx,offset temp    ; memory location of message "Function done"     
    int 21h     ; dos interrupt 21h
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h
    jmp main_bank
failedwithdraw:
    mov ax,3h
    int 10h
    mov ah,09h
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h
    mov dx,offset donthavemoney    ; memory location of message "You dont' have money"     
    int 21h     ; dos interrupt 21h
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h
    jmp main_bank
exitfunction:
    cmp current_user,1
    je save_user1
    cmp current_user,2
    je save_user2
    cmp current_user,3
    je save_user3
    jmp ext
inquire:
    mov ax,03h
    int 10h
    
    mov ah,09h
    lea dx,sdashedline
    int 21h
    lea dx,newline
    int 21h
    lea dx,currentbalancemsg
    int 21h
    ;PRINT PROC 
    mov ax,balancemoney		
	
	;initialize count
	mov cx,0
	mov dx,0
	label1:
		; if ax is zero
		cmp ax,0
		je print1	
		
		;initialize bx to 10
		mov bx,10	
		
		; extract the last digit
		div bx				
		
		;push it in the stack
		push dx			
		
		;increment the count
		inc cx			
		
		;set dx to 0
		xor dx,dx
		jmp label1
	print1:
		;check if count
		;is greater than zero
		cmp cx,0
		je endinquire
		
		;pop the top of stack
		pop dx
		
		;add 48 so that it
		;represents the ASCII
		;value of digits
		add dx,48
		
		;interrupt to print a
		;character
		mov ah,02h
		int 21h
		
		;decrease the count
		dec cx
		jmp print1
endinquire:		
	mov ah,09h
    lea dx,sdashedline
    int 21h
    lea dx,newline
    int 21h
    lea dx,newline
    int 21h
    jmp main_bank 
;------------------------------------------------------------
 logout:
    cmp current_user,1
    je save_user1
    cmp current_user,2
    je save_user2
    cmp current_user,3
    je save_user3
cont_logout:
    mov ax,03h
    int 10h    
    jmp main

save_user1:
    ;create a new file 
        mov ah,3ch
        lea dx,user1file 
        mov cl,0
        int 21h
        mov fhandle,ax
    
    ;open file
        mov ah,3dh
        lea dx,user1file
        mov al,2
        int 21h
        mov fhandle,ax
    
    ;write to file
        mov cx,3 
        mov ah,40h
        mov bx,fhandle
        lea dx,balancemoney
        int 21h
        
        ;Close a file
        mov ah,3eh
        mov bx,fhandle
        int 21h
        cmp number,4
        je  cont_logout
        jmp ext

save_user2:
    ;create a new file 
        mov ah,3ch
        lea dx,user2file 
        mov cl,0
        int 21h
        mov fhandle,ax
    
    ;open file
        mov ah,3dh
        lea dx,user2file
        mov al,2
        int 21h
        mov fhandle,ax
    
    ;write to file
        mov cx,3 
        mov ah,40h
        mov bx,fhandle
        lea dx,balancemoney
        int 21h
        
        ;Close a file
        mov ah,3eh
        mov bx,fhandle
        int 21h
        cmp number,4
        je  cont_logout
        jmp ext

save_user3:
    ;create a new file 
        mov ah,3ch
        lea dx,user3file 
        mov cl,0
        int 21h
        mov fhandle,ax
    
    ;open file
        mov ah,3dh
        lea dx,user3file
        mov al,2
        int 21h
        mov fhandle,ax
    
    ;write to file
        mov cx,3 
        mov ah,40h
        mov bx,fhandle
        lea dx,balancemoney
        int 21h
        
        ;Close a file
        mov ah,3eh
        mov bx,fhandle
        int 21h
        cmp number,4
        je  cont_logout
        jmp ext
    
    
    ;----- 
ext:       
    mov ax,03h
    int 10h 
    mov ah,09h
    mov dx,offset goodbye    ; memory location of message "Goodbye"
    int 21h     ; dos interrupt 21h 
    mov dx,offset newline    ; memory location of message "new line"     
    int 21h     ; dos interrupt 21h
    mov ah,4ch      ; dos function 4ch to terminate and return to dos
    mov al,00       
    int 21h         ; dos interrupt 21h 

;--------------------------End main processes of the bank-------------------------------------------    

endp    
end main
