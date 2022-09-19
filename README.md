This bash script emulates a consumer bank app. So far, the functionality includes:
* Account creation with automatic account number assignment
* Customer details retrieval
* File creation for each customer
* Logout

In the account creation section, the customer is expected to input their username, name, bank verification number (BVN),
and email address. To avoid duplicates, I added conditions to ensure the username the customer chooses is not taken.
I also added regex to verify that the customer BVN contains 11 digits only and that the email addresses are valid. 
