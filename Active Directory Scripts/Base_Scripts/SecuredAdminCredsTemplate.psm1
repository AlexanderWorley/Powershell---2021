    Function Creds
    {
$Password = Read-Host "Administrator Domain Password" -AsSecureString
$global:Creds = new-object -typename System.Management.Automation.PSCredential -argumentlist "cmh\$env:USERNAME", $password
    }Creds