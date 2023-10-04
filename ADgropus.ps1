Import-Module ActiveDirectory
$groupName =  Read-Host -Prompt "Please enter AD group:"          
$groupMembers = Get-ADGroupMember -Identity $groupName | Select-Object -ExpandProperty SamAccountName
$groupMembers
