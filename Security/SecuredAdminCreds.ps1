Function Creds
{
      $SAM = Read-Host "Enter username: "
$Password = Read-Host "Enter Password: " -AsSecureString
$global:Creds = new-object -typename System.Management.Automation.PSCredential -argumentlist "SERVERNAME\$SAM", $password
}Creds
