Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Press_any_key_prompt.psm1"
Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Convert_DellST_AD.psm1" -ArgumentList $Global:ADMachineName -Force

function Restart-MachineRemote{

$script:ADMachineName
$testconnection = Test-connection $script:ADMachineName

    if($testconnection -eq $true){
        $confirm = Read-Host "Machine status: Online | Are you sure you wish to restart?" -confirm
            if($confirm -eq "Y"){
                 
            #Restart-Computer $script:ADMachineName -force
            Write-Host "Restarting machine" -fore Red
            }else{
                Write-Host "Exiting" -fore Red
            }
    }else{
        write-Host "Machine Status: Offline | Please validate internet connection and retry"
    }
pause}Restart-MachineRemote