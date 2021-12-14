#Dump Teams cache
$FolderNamesArray = @("application cache\cache"
,"blob_storage"
,"Cache"
,"databases"
,"GPUcache"
,"IndexedDB"
,"Local Storage"
,"tmp"
)
$MachineName = read-Host "Please input the machine name"
$TargetUser = read-Host "Please input the end User's username"

#Test Connection
$TestConnection = Test-Connection -ComputerName $MachineName

if($Testconnection){

Write-Host "Confirmed device is online" -Fore Green

foreach($FolderNamesArrayExecute in $FolderNamesArray){

Write-Host "removing $FolderNamesArrayExecute" -fore Magenta
#Deletefile
remove-item "\\$($MachineName)\c$\users\$($TargetUser)\Appdata\Roaming\Microsoft\Teams\$foldernamesarrayExecute"

}
}Else{
Write-Host "Device is offline to your machine" -fore Red
}