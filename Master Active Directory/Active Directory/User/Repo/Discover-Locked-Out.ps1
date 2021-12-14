Import-module ActiveDirectory
Function Invoke()
{

    $Password = Read-Host "Enter Password: " -AsSecureString
    $global:Creds = new-object -typename System.Management.Automation.PSCredential -argumentlist "Corp\$env:Username", $password | Select Name
}
$server = "cmh-netjets.com"
Search-ADAccount -Server $Server –LockedOut