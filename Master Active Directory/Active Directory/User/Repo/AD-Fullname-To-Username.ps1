Import-Module ActiveDirectory
$Server = "cmh.netjets.com"
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