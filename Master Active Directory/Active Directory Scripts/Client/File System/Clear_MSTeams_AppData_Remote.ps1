Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Convert_DellST_AD.psm1" -ArgumentList $Global:ADMachineName -Force
Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Press_any_key_prompt.psm1"
function dump-Cache{
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

$TargetUser = read-Host "Please input the end User's username"
#Test Connection
$TestConnection = Test-Connection -ComputerName $ADMachineName
    if($Testconnection){
    Write-Host "Confirmed device is online" -Fore Green
        foreach($FolderNamesArrayExecute in $FolderNamesArray){
            Write-Host "removing $FolderNamesArrayExecute" -fore Magenta
#Deletefile
remove-item "\\$($ADMachineName)\c$\users\$($TargetUser)\Appdata\Roaming\Microsoft\Teams\$foldernamesarrayExecute"
}
}else{
write-error 
    }
}