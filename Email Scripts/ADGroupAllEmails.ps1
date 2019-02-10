$adgroup = "ACTIVE DIRECTORY GROUP"
$domain = "DOMAIN"
$adgroup | foreach {
$groupmembers = Get-ADGroupMember -Identity $adgroup -Recursive -Server $domain
foreach ($user in $groupmembers){
Get-ADUser -Identity $user.DistinguishedName -Server $domain -Properties displayname,mail | Select-Object displayname,mail
}} | Export-Csv "C:\Users\USERNAME\Desktop\EXPORTPS1.csv" -NoTypeInformation
