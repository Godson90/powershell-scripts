$url = "https://strsohio.privilegecloud.cyberark.com/PasswordVault/api/auth/SAML/logon"

$body = @{

   concurrentSession='true'

   apiUse='true'

   SAMLResponse='PHNhb....+'

}

Invoke-RestMethod -Uri $url -Method Post -body $body -ContentType 'application/x-www-form-urlencoded'