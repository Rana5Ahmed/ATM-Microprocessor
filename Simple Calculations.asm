.data
	temp3: $t3
	space: .asciiz	 	"\n"
	maxn: .asciiz 		"Maximum digit: "
	minn: .asciiz 		"Minimum digit: "
	sumn: .asciiz 		"Sum of digits : "
	enter: .asciiz 		"Enter number: "
				
.text				
main:				
addi $v0, $zero, 4 		# print_string syscall
la $a0, enter   		# load address of the string ( printing Enter number: )
syscall				
				
li $v0 , 5 			#load data from user ( input INTEGER )
syscall				
				
addi $a0 , $v0 , 0  	 	#pass the number to a0 to be passed to the function 
jal SumMinMax			#calling the function
				
addi $v0, $zero, 4  		# print_string syscall
la $a0, maxn       		# load address of the string ( printing Maximum digit: )
syscall				
				
add $a0 , $0 , $s1   		#putting s1 (max digit) in a0 to be printed
li $v0,1			#printing maximum digit (s1)
syscall				
				
				
addi $v0, $zero, 4  		# print_string syscall
la $a0, space       		# load address of the string ( printing new line )
syscall				
				
addi $v0, $zero, 4  		# print_string syscall
la $a0, minn       		# load address of the string ( printing Minimum digit: )
syscall

add $a0 , $0 , $s2		#putting s2 (min digit) in a0 to be printed
li $v0,1			#printing minimum digit (s2)
syscall
				
addi $v0, $zero, 4  		# print_string syscall
la $a0, space      	 	# load address of the string ( printing new line )
syscall				
				
addi $v0, $zero, 4 		# print_string syscall
la $a0, sumn     		# load address of the string ( printing Sum of digits : ) 
syscall					
						
add $a0 , $0 , $s0 		#putting s0 (sum  of digits) in a0 to be printed
li $v0,1			#printing Sum of  digits (s0)
syscall				
				
li $v0,10			#Exiting the program 
syscall 			
																
SumMinMax:			#Start of the function
add $s0 , $s0 ,$0 		#s0 -> sum of digits and initially 0	
addi $s2 , $s2 , 10		#s2-> min and initially 10
addi $s1 , $s1 , -10		#s1 -> max and initially -10
while:				
div $t0 , $a0 , 10  		#t0=a0/10 -> temp=number/10 --> full number without last digit
mul $t0,$t0,10			#t0=t0*10 -> temp=temp*10 -->  same as number but last digit is zero
sub $t2,$a0,$t0 		#t2=a0-t0 ->temp2=number-temp --> last digit only
	
slt $t5 , $s1 , $t2		#set t5 = 1 if s1 < t2 else t5=0   s1:max , t2:last digit
bne $t5 ,$0, max
         		# if t5 !=0 ( t5==1) go to max 	
cont1:				
slt $t5 , $t2 , $s2		# continue from max 	and set t5 = 1 if t2 < s2 else t5 =0  t2: last digit , s2: min 
bne $t5 ,$0, min
        		        # if t5 !=0 ( t5==1) go to min 
cont2:				
add $s0 , $s0 , $t2 		#continue from min and add t3 to t2 and put it in t3 -> sum = sum + last		
div $a0 , $a0 , 10 		#a0=a0/10 -> number = number /10 --> all number without last digit 
bne $a0 , 0 , while 		#check if number isn't zero go to while again
jr $ra				#End of the function return s0 --> sum of digits -- return s1 --> maximum digit   --  return s2 --> minimum digit
max: 				
add $s1 , $t2 ,$0		
j cont1			
min: 				
add $s2 , $t2 , $0			
j cont2				
