Import-Module ActiveDirectory
$Server = 'SERVERNAME1','SERVERNAME2','SERVERNAME3','SERVERNAME4','SERVERNAME5'
$Result = @()
$FullNameinput = Read-Host 'Input the PrimaryServer user Full Name'

ForEach($CurrentServer in $Server){

     $Filter = "(displayName -like '$FullNameinput*')"
    $User = Get-ADUser -Server $CurrentServer -Filter $Filter -Properties SamAccountName

    ForEach($CurrentUser in $User){

    $Result += [pscustomobject] @{"Username" = $CurrentUser.SamAccountname; "Domain" = $CurrentServer}
    }
}

$Result | Write-Output
