
$cloud_url = ''

function pvwa {
    $cloudid = 'strsohio_admin'
    $passwd = Read-Host -Prompt 'Please enter CyberArk admin password:' -AsSecureString
    $logon_url = "$cloud_url/api/auth/Cyberark/Logon"
    $credentials = @{
        username = $cloudid
        password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($passwd))
        concurrentSession = $true
    } | ConvertTo-Json

    $headers = @{
        'Content-Type' = 'application/json'
    }

    $auth_token = Invoke-RestMethod -Uri $logon_url -Method Post -Headers $headers -Body $credentials
    $autheticationToken = $auth_token.Trim(' "')
    return $autheticationToken
}



Function Add-Account {
    $add_url = "$cloud_url/API/Accounts/"
    $headers = @{
        "Content-Type" = "application/json"
        "Authorization" = (pvwa)
    }
    $Username = Read-Host "Please enter privileged account name:"
    $address = Read-Host "Please enter name or address of the machine where the account will be used (FQDN):"
    $platformId = Read-Host "Please enter the platform name assigned to this account:"
    $safeName = Read-Host "Please enter the safe name where the account will be created:"
    $secretType = Read-Host "Please enter secretType (password/key):"
    $secret = Read-Host "Please enter accounts secret if there is one:"
    $automaticManagementEnabled = Read-Host "Please enter whether the account secret is automatically managed by the CPM (true/false):"
    $manualManagementReason = Read-Host "Please enter reason for disabling automatic secret management:"

    $body = @{
        "platformId" = $platformId
        "safeName" = $safeName
        "address" = $address
        "userName" = $Username
        "secretType" = $secretType
        "secret" = $secret
        "platformAccountProperties" = @{}
        "secretManagement" = @{
            "automaticManagementEnabled" = $automaticManagementEnabled
            "manualManagementReason" = $manualManagementReason
        }
    } | ConvertTo-Json

    $http_response = Invoke-RestMethod -Uri $add_url -Method Post -Headers $headers -Body $body
    Write-Output $http_response
}

Add-Account
