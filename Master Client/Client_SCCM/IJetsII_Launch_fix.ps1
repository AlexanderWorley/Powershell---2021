0#Machine name for the specific user you are attempting to connect to. 
$Machine = Read-Host "Input Machine Name"
#sets the value from Test path as either True or False to $item, then runs a if statement if the file is there.. 
$item = Test-Path "\\$Machine\c$\IntelliJet-II\Client64\confirm*"
#checks for and removes the item in Client64 of the IJet Root Folder then runs the app eval
if($item -eq $True){
    #Removes file from Ijet Client64 Root folder.
    Write-Host "File Exists, Removing file" -ForegroundColor Magenta
    Remove-Item -Path "\\$Machine\c$\IntelliJet-II\Client64\confirm*"
    $item_Confirm = Test-Path "\\$Machine\c$\IntelliJet-II\Client64\confirm*"
        if($item_Confirm -eq $False){
        #runs a If command to check if the file is still there. If its false it will continue. 
            Write-Host "File has been removed." -ForegroundColor DarkGreen
        }
    #Invokes the Application Eval Cycle option in Config Manager.
        Write-Host "Invoking app evaluation cycle please wait" -ForegroundColor Magenta
   Invoke-WMIMethod -ComputerName $Machine -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000121}"
}else{
    #If the file is not in the location it will run the App evaluation cycle to get the file. 
        write-Host "Confirm Version file is not detected. Running Application evaluation cycle. Please wait." -ForegroundColor Magenta
   Invoke-WMIMethod -ComputerName $Machine -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000121}"
}



