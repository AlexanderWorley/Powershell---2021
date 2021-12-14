Import-module ActiveDirectory
Function Invoke()
{

    $Server = "ServerName"
    $Password = Read-Host "Enter Password: " -AsSecureString
    $global:Creds = new-object -typename System.Management.Automation.PSCredential -argumentlist "Corp\$env:Username", $password
}

Search-ADAccount -Server $Server –LockedOut
