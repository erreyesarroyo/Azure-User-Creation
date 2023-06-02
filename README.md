# Azure-User-Creation version 1 (User Creation on Personal Account)
#As seen below this is step one next steps are how to manipulate middle initials, add the user to a group, and with a switch statement other stuff. 

# Connect to Azure
Connect-AzAccount

# Prompt for the number of users to create
$userCount = Read-Host -Prompt "Enter the number of users to create"

# Loop to create multicleaple users
for ($i = 1; $i -le $userCount; $i++) {
    Write-Host "Creating User $i"

    # Prompt for user details
    $firstName = Read-Host -Prompt "Enter the first name of User $i"
    $lastName = Read-Host -Prompt "Enter the last name of User $i"
    $displayName = "$firstName $lastName"
    $password = Read-Host -Prompt "Enter the password for User (https://lazyadmin.nl/office-365/azure-ad-password-policy/) $i" -AsSecureString
    #next step use auto generate 
    #nect step auto email encripted with org encripted standards
    $Domain = "@kickingtires.onmicrosoft.com"
    $MailNickName = "$firstName.$lastName"
    $UPN = "$firstName.$lastName$Domain"
   

    # Create the user
    New-AzADUser -DisplayName $displayName -UserPrincipalName $UPN -UserType Member -Password $password -MailNickname $MailNickName 

    # Output success message
    Write-Host "User $i created successfully!"
}

