$Exch2013 = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri AWorley@netjets.com cmh.netjets.com -Authentication TYPEOFAUTH
Import-PSSession $Exch2013
$ID = 'AWorley'

Get-MailboxFolderStatistics -identity $ID | Select name,Folderpath,ItemsinFolder | Sort DeletedItems