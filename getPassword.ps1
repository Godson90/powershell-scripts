function GetPassword {
    $token = Read-Host -Prompt "Please enter your App ID"
    $username = Read-Host -Prompt "Please enter your username"
    $safe = Read-Host -Prompt "Please enter your safe name"
    #$address = Read-Host -Prompt "Please enter the address"
    #$database = Read-Host -Prompt "Please enter the database name"
    #$accountName = Read-Host -Prompt "Please enter the Account Name"

    if ($token -notmatch "^[a-zA-Z0-9_-]*$") {
        throw "Error message: appid must be an alphanumeric string including hyphen."
    }
    if ($username -isnot [string]) {
        throw "Error message: username must be a string."
    }

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    try {
        $url = 'https://cyril-app3.strsoh.org'
        $appID = 'CP-' + $token

        if ($address) {
            $downtown_url = "$url/AIMWebService/api/Accounts?AppID=$appID&Query=UserName=$username;Address=$address"
        }
        elseif ($database) {
            $downtown_url = "$url/AIMWebService/api/Accounts?AppID=$appID&Query=UserName=$username;Database=$database"
        }
        elseif ($safe) {
            $downtown_url = "$url/AIMWebService/api/Accounts?AppID=$appID&Query=UserName=$username;Safe=$safe"
        }
        else {
            $downtown_url = "$url/AIMWebService/api/Accounts?AppID=$appID&Query=UserName=$username"
        }

        $httpresponse = Invoke-RestMethod -Uri $downtown_url -Method Get -UseBasicParsing
        if ($httpresponse.StatusCode -ne 200) {
            foreach ($pair in $httpresponse) {
                Write-Host "$($pair.Key)  $($pair.Value) "
            }
        }
        Write-Host $httpresponse.Content
    }
    catch {
        try {
            $url_dr = 'https://cyril-dr-ccp.strsoh.org'
            $appID = 'CP-' + $token

            if ($address) {
                $dr_url = "$url_dr/AIMWebService/api/Accounts?AppID=$appID&Query=UserName=$username;Address=$address"
            }
            elseif ($database) {
                $dr_url = "$url_dr/AIMWebService/api/Accounts?AppID=$appID&Query=UserName=$username;Database=$database"
            }
            elseif ($safe) {
                $dr_url = "$url_dr/AIMWebService/api/Accounts?AppID=$appID&Query=UserName=$username;Safe=$safe"
            }
            else {
                $dr_url = "$url_dr/AIMWebService/api/Accounts?AppID=$appID&Query=UserName=$username"
            }

            $http_response = Invoke-RestMethod -Uri $dr_url -Method Get -UseBasicParsing
            if ($http_response.StatusCode -ne 200) {
                foreach ($pair in $http_response) {
                    Write-Host "$($pair.Key)  $($pair.Value) )"
                }
            }
            Write-Host $http_response.Content
        }
        catch {
            Write-Host "CCP server failed. ($($_.Exception.Message))"
        }
    }
}
GetPassword