Import-Module ActiveDirectory 
$csv = import-csv "C:\Users\AWorley\OneDrive - NetJets\Desktop\Userlist.csv"

foreach($user in $csv.name){
$users = get-aduser -server "luk.netjets.com" -Filter {cn -eq $user} -properties DistinguishedName | select name | select DistinguishedName
Get-ADGroup -filter {name -LIKE "APP-TAB-ENT-EJMAvail-QAViewer"} | ForEach-Object {Add-ADGroupMember -identity $_ -Members $users}
}


