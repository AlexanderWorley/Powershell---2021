Import-Module ActiveDirectory
Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Press_any_key_prompt.psm1"
#Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Convert_DellST_AD.psm1" -ArgumentList $Global:ADMachineName -Force
#Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\SecuredAdminCredsTemplate.psm1"-ArgumentList $global:Creds -force 

function Get-UsernameFull{
$NJDOMAIN = "Netjets.com"
$Server = @(
"CMH.$NJDOMAIN",
"LUK.$NJDOMAIN",
"LIS.$NJDOMAIN"
)
$Result = @()
$FullNameinput = Read-Host 'Full Name'
    ForEach($CurrentServer in $Server){
         $Filter = "(displayName -like '$FullNameinput*')"
         $User = Get-ADUser -Server $CurrentServer -Filter $Filter -Properties SamAccountName
         }         
        ForEach($CurrentUser in $User){
            $Result += [pscustomobject] @{ "Domain" = $CurrentServer.Replace(".Netjets.com", ""); "Username" = $CurrentUser.SamAccountname}       
       }
$Result
}get-UsernameFull