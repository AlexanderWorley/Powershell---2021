#Script used to export the access from a model and apply them to a new user account. 
function Get-ModelAccess{
$ModelUserFromSN = "AWorley"
$AD = get-ADuser -filter {cn -eq "Alex Worley"} -Properties * | select SamaccountName
$Model = Get-ADPrincipalGroupMembership -identity "AWorley" | select -ExpandProperty name
$Model
}Get-ModelAccess

function Set-ModelAccess{

}