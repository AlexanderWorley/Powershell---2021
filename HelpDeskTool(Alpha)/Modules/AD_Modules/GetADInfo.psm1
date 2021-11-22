<# 
____________________________________ Active Directory Module _______________________________________

Use: Import this module via the import-module cmdlet. then call the functions as normal cmdlets.
#>
Import-Module ActiveDirectory
Import-Module -DisableNameChecking -name "$Global:rootlocation\User_Modules\HDT_Table Source.psm1"

function Get-NJDomain{
$ADServer = @{
    "CMH" = "cmh.netjets.com"
    "LUK" = "luk.netjets.com"
    "JFK" = "jfk.netjets.com"
    "LHR" = "jfk.netjets.com"
    "LIS" = "lis.netjets.com"
}
}


function Get-NJUserAttributes{

}

function Get-NJGroupMembers{
param(
$User_Account

)

$User_Group = Get-ADUser -filter {EmployeeID -eq $User_Account} -Properties * | Select -expandproperty SAMAccountName

Get-ADPrincipalGroupMembership -Identity $User_Group | Select Name,Description | Out-GridView -Title "Group Membership of $User_Group"

}
function Get-NJGroupMembership{

}

function Get-NJ{
}

