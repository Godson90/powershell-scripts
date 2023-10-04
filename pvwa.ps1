$url = "https://"

$body = @{

   concurrentSession='true'

   apiUse='true'

   SAMLResponse='PHNhb....+'

}

Invoke-RestMethod -Uri $url -Method Post -body $body -ContentType 'application/x-www-form-urlencoded'
