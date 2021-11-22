Import-Module ActiveDirectory

$UserName = Read-Host "Input the Username you wish to check"
Get-ADUser -filter {samaccountname -eq $UserName} –Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed" | Select-Object -Property "Displayname",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}