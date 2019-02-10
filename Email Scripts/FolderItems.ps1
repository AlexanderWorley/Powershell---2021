$Exch2013 = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri EMAIL SERVERNAME -Authentication TYPEOFAUTH
Import-PSSession $Exch2013
$ID = 'USERNAME'

Get-MailboxFolderStatistics -identity $ID | Select name,Folderpath,ItemsinFolder | Sort DeletedItems
