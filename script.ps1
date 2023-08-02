# Connect to Azure GOV
Connect-AzAccount -Environment AzureUSGovernment

# Prompt for the number of users to create
$userCount = Read-Host -Prompt "Enter the number of users to create"

# Loop to create multiple users
for ($i = 1; $i -le $userCount; $i++) {
    Write-Host "Creating User $i"

    # Prompt for user details
    $firstName = Read-Host -Prompt "Enter the first name of User $i"
    $lastName = Read-Host -Prompt "Enter the last name of User $i"
    
    # Generate a random password
    $length = 9
    $complexity = 4
    
    $lowercaseChars = "abcdefghijklmnopqrstuvwxyz"
    $uppercaseChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    $numericChars = "0123456789"
    $specialChars = "!@#$%^&*()_-+=[]{}<>,.?/:"
    
    $characterSet = $lowercaseChars + $uppercaseChars + $numericChars + $specialChars
    
    # Convert the character set to an array of characters
    $charArray = $characterSet.ToCharArray()
    
    # Shuffle the array of characters
    $random = New-Object System.Random
    $shuffledArray = $charArray | Sort-Object { $random.Next() }
    
    # Select the first 9 characters from the shuffled array
    $password = $shuffledArray[0..($length - 1)] -join ''
    
    # Convert the password to a secure string
    $securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force
    
    # Construct and assemblies user properties
    $Domain = "@kickingtires.onmicrosoft.com"
    $MailNickName = "$firstName.$lastName"
    $UPN = "$firstName.$lastName$Domain"
    
    # Create the user
    New-AzADUser -DisplayName $displayName -UserPrincipalName $UPN -UserType Member -Password $securePassword -MailNickname $MailNickName
    
    # Output success message
    Write-Host "User $i created successfully, and the password is <$password>. Dont account for the <>."
}

#### way up ahead, disconnect command. 
#### enable MFA, change upon reciept.
