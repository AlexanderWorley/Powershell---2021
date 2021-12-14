$adgroup = "appveoci"
$domain = "cmh.netjets.com"
$adgroup | foreach {
$groupmembers = Get-ADGroupMember -Identity $adgroup -Recursive -Server $domain
foreach ($user in $groupmembers){
Get-ADUser -Identity $user.DistinguishedName -Server $domain -Properties displayname,mail | Select-Object displayname,mail
}}