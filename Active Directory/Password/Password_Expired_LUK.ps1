Import-Module ActiveDirectory
$Server = "luk.netjets.com"
$UserName = Read-Host "Input the Username you wish to check"
Get-ADUser -server $Server -filter {samaccountname -eq $UserName} –Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed" | Select-Object -Property "Displayname",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}