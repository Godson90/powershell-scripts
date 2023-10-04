# Replace 'UserName' with the actual username you want to query
$targetUser = Read-Host -Prompt "Please enter AD user:"


# Query the user in Active Directory
try {
    $user = Get-ADUser -Identity $targetUser -Properties *
} catch {
    Write-Host "Error querying user '$targetUser': $_"
    Exit
}

# Check if the user was found
if ($user -eq $null) {
    Write-Host "User '$targetUser' not found in Active Directory."
} else {
    # Display user information
    Write-Host "User Details:"
    Write-Host "Username: $($user.SamAccountName)"
    Write-Host "Display Name: $($user.DisplayName)"
    Write-Host "Email Address: $($user.EmailAddress)"
    Write-Host "User Principal Name (UPN): $($user.UserPrincipalName)"
    # Add more properties as needed

    # Example: To get a specific property, such as the user's department
    # Write-Host "Department: $($user.Department)"
}
