#! /bin/bash
let count=0

function openAccount(){
read -p "Enter a username: " username

#check if username exists
while [[ -e $username.txt ]]
do
echo -e "Username taken, please try again\n"
read -p "Enter a username: " username
done
###

read -p "Enter your first name: " firstname
read -p "Enter your last name: " lastname

read -p "Enter your email address: " email
#verify email
regex=[[:alnum:]]+@[[:alnum:]]+\.[[:alpha:]]{2,4}
until [[ $email =~ $regex ]]
do
read -p "Enter a valid email address: " email
done
###

read -p "Enter your BVN: " bvn
bvnregex=[[:digit:]]{11}
#verify BVN contains only digits and is 11 digits long
until [[ $bvn =~ $bvnregex ]] && [[ ${#bvn} == 11 ]]
do

if [[ $bvn =~ [^[:digit:]] ]]
then
echo "BVN should contain only numbers"
read -p "Please enter your correct BVN: " bvn

elif [[ ${#bvn} -lt 11 ]]
then
echo "BVN less than 11 digits"
read -p "Please enter your correct BVN: " bvn

elif [[ ${#bvn} -gt 11 ]]
then
echo "BVN greater than 11 digits"
read -p "Please enter your correct BVN: " bvn
fi
done
###

#confirm details
echo ""
echo "Confirm your details:"
echo -e "Username: $username\nFirst Name: $firstname\nLast Name: $lastname\nEmail Address: $email\nBVN: $bvn"
echo -e "Are your details correct?\nType Yes or No"
read confirmation

if [[ $confirmation == "Yes" ]]
then
#assign account number to the user
accountNumber=$(( 0000000000 + $count ))

#create file for user
echo -e "First Name: $firstname\nLast Name: $lastname\nEmail Address: $email\nBVN: $bvn\nAccount Number: $accountNumber" > $username.txt
echo "You will receive an email shortly"
count=$(( count += 1 ))
echo "--------"
homepage
elif [[ $confirmation == "No" ]]
then
echo "--------"
openAccount
fi
}

function viewYourDetails(){
read -p "Enter your username: " username

if [[ -e $username.txt ]]
then
echo -e "These are your details:\n"
cat $username.txt
echo "--------"
homepage
else
echo "Looks like your details do not exist"
echo "--------"
homepage
fi
}

function logout(){
exit
}

function homepage(){
echo -e "Hello, welcome to Bank Cloud Self-Service, choose an option: \n1) Open an account \n2) View your details \n3) Logout"
read -p "Option: " option
echo ""

#verify option
if [[ $option -eq 1 ]]
then
openAccount
elif [[ $option -eq 2 ]]
then
viewYourDetails
elif [[ $option -eq 3 ]]
then
logout
else
until [[ $option -eq 1 || $option -eq 2 || $option -eq 3 ]]
do
echo "Please choose a valid option"
echo "--------"
homepage
done
fi
}

homepage
