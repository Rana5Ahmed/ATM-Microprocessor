# What is ATM ?
An automated teller machine (ATM) is an electronic banking outlet that allows customers to complete basic transactions without the aid of a branch representative or teller. Anyone with a credit card or debit card can access cash at most ATMs.
# ATM-8086
 ATM assembly project presented by a group of students at third year Computer Engineering.
 A miniproject on implementation of operation of Atm machine which includes:
 Deposit, Withdraw of money and Balance enquiry of an account 
   
# Features
Since it is an ATM Machine. Initially we declared some existing accounts . And doing following operations on that account:
1. Deposit:
 
   Saved users can deposit in this atm till his account reach 50.000 $ 

2. Withdrawal:

    Function which allows the user to withdraw money from his account and the user must have enough money in his account. By default when the withdraw operation is           completed the balance money decrease

3. Balance Money:

   Function that calculate and display the current money in User's account untill reaching 50.000 $  

4. Exit:

   Function that handel the end of program 

# Programflow
 ### Scan
 
 ### Deposit
 In this function we will face 3 Cases:
   1. Deposit all money in account at once time (Deposit 50.000$ in one operation):
   Then the balance money equals to 50.000$ and the user recives a massage congraulate him of reaching 50K  
   2. Deposit money over the required money in card (Deposit over 50.000$)
   Then the user get a massage that "The limit of card is 50.000$ only " 
   3. Deposit money within the limit of required money in card(money<50.000$)
 Then we have to check the balance money:
 
    1. if the balance reached the maximum limit--> (Congraulate massage)
    2. balance > limit (Overflow)--> "The limit of card is 50.000$ only "
 
   ![WhatsApp Image 2022-12-23 at 7 10 05 PM](https://user-images.githubusercontent.com/82416493/209380660-4530adf2-b506-4254-9cf1-38660e85ff28.jpeg)
   
 ### Withdrawal
   Withdrawl function allows the user to take his own money from his account, the amount of withdraw must be less than the balance money and can't be greater than
     it, if there is no enough money to withdraw, the atm will jump to failed withdraw function which is telling the user there is no enough money and this operation
     can't be completed
 
 ![WhatsApp Image 2022-12-23 at 7 24 56 PM](https://user-images.githubusercontent.com/82416493/209377541-2e999664-7e2d-4823-ac96-15536a46939c.jpeg)


 ### Balance Money
