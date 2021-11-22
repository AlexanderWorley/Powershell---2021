$SearchOU = "OU=OUNAME,OU=OUNAME ,OU=OUNAME ,OU=OUNAME,DC=DCNAME,DC=DCNAM"
$Server = "SERVER"

Start-Transcript

    $Groups = Get-ADGroup  -server $Server -Credential $creds -Filter "groupcategory -eq 'Distribution'" -SearchBase $SearchOU -Properties Samaccountname,msexchgroupmembercount,Description | where-object {$_.members.Count -eq 0}  | Sort-Object -Property Name|  export-csv -path C:\Users\USERNAME\Desktop\NoMembers.csv
        Import-cvs -path C:\Users\USERNAME\Desktop\NoMembers.csv
       $count = 0
         $cvs[0]

Foreach ($cur in $csv)
{
       $count += 1
       Write-Host “$count) $cur”
       If($Name -eq 0){
       Write-host -ForegroundColor Red "has no/Null members"
}
}

 Stop-Transcript