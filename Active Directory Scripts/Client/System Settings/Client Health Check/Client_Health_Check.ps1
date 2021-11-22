<#
   ############################.Synopsis#################################
    This script is designed to report on a machine's over all health on the CCM platform and BIOS reports. 
    Script tasks: 
    1. Validate WMI is enabled and working.
    2. Check to CCM Client is installed and healthy; if not, install it then recheck.
    3. CHeck Secureboot is enabled. If not, enabled it, then recheck.
    4. Check if Bitlocker and TPM are encrypting the drive in windows.



    ########## How to use########################
    1. Press F5 or start. 
    2. Enter the DELL SERVICE TAG NUMBER (Usually the ending hostname) Note: This is just the unique identifyer at the end of a hostname. So you can enter any value that is unique to that machine at the end of the string. 
        2a. Example: Hostname: TEST-TESTER-AWORLEYDT value to enter in the script: AWORLEYDT | This will pull the machine Test-Tester-AWorleyDT. 
    3. Enter the Dell BIOS password when prompted. If you are checking multiple machines please modify line @138 Variable: $DellBIOSPassword to the string of the bios password. 
        3a. If needed the below Command instead of the module "Convert_DellST_AD.psm1 
            - $computerSystem = Read-Host "Input Dell Service Tag" - Change this to the Foreach object in a list to use the script
            - $computerSystem = "*"+$computerSystem
            - Get-ADComputer -filter {name -LIKE $computerSystem} | Select -expandproperty Name
            - Change $ComputerSystem to the hostname you want to identify for pass in a for loop and import a mass amount of hostnames to check. 
    4. Should spit out A list of values and a final report in console. 
#>


#Modules
Import-Module "\\cmhprdfps53\Data\HelpDesk\Powershell Automation\EUT\Base_Scripts\SecuredAdminCredsTemplate.psm1"
Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Convert_DellST_AD.psm1" -ArgumentList $Global:ADMachineName -Force

#Variables
$Clientpath = "\\cmhprdcod01\source\SCCM Client and Console\Client\"
$mp_address = "https://cmhprdsccm10.cmh.netjets.com"
$site_code = "CM1"
$Connect = test-Connection $Global:ADMachineName -Count 1 -Quiet
$SMSCli = [wmiclass] "root\ccm:sms_client"
$MachinePolicyRetrievalEvaluation = "{00000000-0000-0000-0000-000000000021}"
$SoftwareUpdatesScan = "{00000000-0000-0000-0000-000000000113}"
$SoftwareUpdatesDeployment = "{00000000-0000-0000-0000-000000000108}"


############################### Check if WMI is working #######################
function WMIValidate{
    if($Connect){
                if((Get-WmiObject -Namespace root\ccm -Class SMS_Client) -and (Get-WmiObject -Namespace root\ccm -Class SMS_Client)){
	            $WMI_Status = "Working"
            }else{
                Stop-Service -Force winmgmt -ErrorAction SilentlyContinue
                cd  C:\Windows\System32\Wbem\
                del C:\Windows\System32\Wbem\Repository.old -recurse -Force -ErrorAction SilentlyContinue
                ren Repository Repository.old  -ErrorAction SilentlyContinue
                Start-Service winmgmt 
        }
    }else{
      Write-Host "Connection error: Unable to connect" -ForegroundColor Red
    }
}WMIValidate

######################### CCM Client###################
function CCMClientInstall{
If(Get-Service -Name CcmExec)
{
	$Client_Status = "Yes"	
	########### Check if services are running ################################
    $CcmExec_Status = Get-Service -Name CcmExec
	$BITS_Status = Get-Service -Name BITS
	$wuauserv_Status = Get-Service -Name wuauserv
	$Winmgmt_Status = Get-Service -Name Winmgmt
	$RRegistry_Status = Get-Service -Name RemoteRegistry


	if($CcmExec_Status.status -eq "Stopped")
	{
		$CcmExec_Status | Start-Service
	}

	if($BITS_Status -eq "Stopped")
	{
		$BITS_Status | Start-Service
	}

	if($wuauserv_Status -isnot "Running")
	{
		$wuauserv_Status | Start-Service
	}

	if($Winmgmt_Status -eq "Stopped")
	{
		$Winmgmt_Status | Start-Service
	} 
	

	#################### check if Scan cycles are working ###################
	$machine_status = Invoke-WmiMethod -ComputerName $Global:ADMachineName -Namespace root\ccm -Class sms_client -Name TriggerSchedule $MachinePolicyRetrievalEvaluation
   	$software_status = Invoke-WmiMethod -ComputerName $Global:ADMachineName -Namespace root\ccm -Class sms_client -Name TriggerSchedule $SoftwareUpdatesScan	
    $softwaredeploy_Status = Invoke-WmiMethod -ComputerName $Global:ADMachineName  -Namespace root\ccm -Class sms_client -Name TriggerSchedule $SoftwareUpdatesDeployment
   
	if($machine_status -and $software_status -and $softwaredeploy_Status)
	{
		$machine_Rstatus = "Successful"
	}else
	{
		$SMSCli.RepairClient()
	}

}else{
############## Install SCCM Client ###############################
	"$path\ccmsetup.exe /mp:$mp_address SMSSITECODE=$site_code"	

	Add-Content "C:\OSDLogs\SCCMClientRepair.txt"  "Reinstalling client" -Force 

	Start-Sleep -seconds 120
    ##### Rerun validation#####
    CCMClientInstall
}
}CCMClientInstall

##############SecureBootValidation#########################

 function secureboot_Execute{   

    if($Connect){
                Invoke-Command -computerName $Global:ADMachineName -Credential $Creds -ScriptBlock{
                $TestPath = Test-Path c:\Program Files\WindowsPowerShell\Modules\DellBIOSProvider
                if($TestPath -eq "False"){
                Copy-item -Path "\\cmhprdfprd53\data\helpdesk\powershell automation\EUT\Modules\DellBIOSProvider" -Destination "c:\Program Files\WindowsPowerShell\Modules\" -Recurse -Force
                }else{
                    Write-Host "Path Detected, exiting copy function"
        }
            $ExecutionPolicy = Get-ExecutionPolicy
            If($ExecutionPolicy -isnot "Bypass"){
            Set-ExecutionPolicy Bypass
        }
        #Import Module to initialize dellsmBios PS Drive.
        Import-Module DellBiosProvider
        #Get SecureBoot status
        $CurrentValue = (get-item -Path "dellsmbios:\SecureBoot\SecureBoot").CurrentValue
        if($CurrentValue -eq "Disabled"){
        $BIOSPassword = read-host "Enter the BIOS Password for this machine:" -AsSecureString
        (Set-item -Path "dellsmbios:\SecureBoot\SecureBoot" enabled -Password $BIOSPassword)
        secureboot_Execute
        }        
       }

    }else{
        Write-Host "Connection error: Unable to connect" -ForegroundColor Red
    }
}secureboot_Execute


function run-Encryptionvalidation{

$TPMValue = Get-WmiObject -class Win32_Tpm -namespace root\CIMV2\Security\MicrosoftTpm -ComputerName $script:ADMachineName -Authentication PacketPrivacy | select -ExpandProperty IsActivated_InitialValue
$Bitlocker = Manage-bde -status C: -computername $script:ADMachineName
if($Bitlocker[13] -eq "    Protection Status:    Protection On"){
    $Bitlockstatus = "Protection On"
}

if($TPMValue -eq "True"){
$TPMValueresult = "Enabled"
}else{
Write-Host "TPM IS NOT ENABLED"
}
$Results = @{
"TPM" = $TPMValueresult
"Bitlocker" =  $Bitlockstatus
}
}run-Encryptionvalidation




Function Health_Check{
write-Host "$Global:ADMachineName"
Write-Host "SecureBoot: $CurrentValue"
Write-Host "CCMEXEC: $($CcmExec_Status.Status)"
Write-Host "BITS: $($BITS_Status.Status)"
Write-Host "wuauserv: $($wuauserv_Status.Status)"
Write-Host "Winmgmt: $($Winmgmt_Status.Status)"
Write-Host "RemoteRegistry: $($RRegistry_Status.Status)"
Write-Host "CCM Actions Status: $machine_Rstatus"
Write-Host "Bitlocker: $($Results.Bitlocker)"
Write-Host "TPM: $($Results.TPM)"

}Health_Check