#Press F5 to run
Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Convert_DellST_AD.psm1" -ArgumentList $Global:ADMachineName -Force
Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\SecuredAdminCredsTemplate.psm1"-ArgumentList $global:Creds -force 

function rename-Comp{
#Assigns new Machine variable
$NewName = Read-Host "New Machine Name"   
#tests connection to machine
$Testcon = Test-Connection $script:ADMachineName
#logic to validate connection
    if($Testcon){
#Logic to confirm the expected resulting action
            $Confirm = read-Host "Confirm this action: Old Name: $($script:ADMachineName) -> New Name: $($newname)" -confirm
    if($Confirm -eq "Y"){
#execution of the requested action
        Rename-Computer -ComputerName $script:ADMachineName -NewName $NewName -domaincredential $global:Creds -Force -PassThru
      
         
     #script exits for invalid connection/results
    }elseif($confirm -eq "N"){
        Write-Host "Exiting script."
    }else{
        Write-host "Expected Result is Y/N; Result given was $($Confirm)"
    }
    #script exits for invalid connection/results
}else{
    Write-Host "Machine is offline to your Connection. Please validate VPN/Domain Connection"}


Pause}rename-Comp

