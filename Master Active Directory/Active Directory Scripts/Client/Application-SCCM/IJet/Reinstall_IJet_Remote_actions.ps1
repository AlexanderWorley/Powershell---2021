function Reinstall-Ijetii{

#Converts the service tag for CMH machines into their AD property. Used to pass the hostname in via scripts for all CMH machines.
$computerSystem = Read-Host "Please enter the Dell service tag"
$computerSystem = "*"+$computerSystem
$ADMachineName = Get-ADComputer -filter {name -LIKE $computerSystem} | Select -expandproperty Name

$item = Test-Path "\\$ADMachineName\c$\IntelliJet-II\Client64\confirm*"
#checks for and removes the item in Client64 of the IJet Root Folder then runs the app eval
if($item -eq $True){
    #Removes file from Ijet Client64 Root folder.
    Write-Host "File Exists, Removing file" -ForegroundColor Magenta
    Remove-Item -Path "\\$ADMachineName\c$\IntelliJet-II\Client64\confirm*"
    $item_Confirm = Test-Path "\\$ADMachineName\c$\IntelliJet-II\Client64\confirm*"
        if($item_Confirm -eq $False){
        #runs a If command to check if the file is still there. If its false it will continue. 
            Write-Host "File has been removed." -ForegroundColor DarkGreen
        }
    #Invokes the Application Eval Cycle option in Config Manager.
        Write-Host "Invoking app evaluation cycle please wait" -ForegroundColor Magenta
   Invoke-WMIMethod -ComputerName $ADMachineName -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000121}"
}else{
    #If the file is not in the location it will run the App evaluation cycle to get the file. 
        write-Host "Confirm Version file is not detected. Running Application evaluation cycle. Please wait." -ForegroundColor Magenta
   Invoke-WMIMethod -ComputerName $ADMachineName -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000121}"
    }
}Reinstall-Ijetii