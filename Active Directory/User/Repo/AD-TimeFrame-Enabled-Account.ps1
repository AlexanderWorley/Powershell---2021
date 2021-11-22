$Server = "SERVERNAME"
$SearchBaseVar =  "DC=DCNAME,DC=DCNAME,DC=DCNAME,DC=DCNAME"
$Creds = "Username"

        $Enabled = "Enabled -eq False"
        $PassLS = "Passwordlastset -lt MM/DD/YYYY"
        $AccountExp = "accountexpirationdate -lt MM/DD/YYYY"
        $AccountExpires = "AccountExpires -ne 9223372036854775807 -and -AccountExpires -ne 0"

Get-ADUser -server $Server -Credential $Creds -FIlter * -SearchBase $SearchBaseVar   -Properties * | Select-Object SamAccountName,Enabled,ObjectClass,distinguishedName,AccountExpires,AccountExpirationdate,Passwordlastset|Where $AccountExpires|Where $AccountExp| Where $PassLS|  Where $Enabled|Export-CSV -path C:\Users\USERNAME\Desktop\ServicesCSV.csv
