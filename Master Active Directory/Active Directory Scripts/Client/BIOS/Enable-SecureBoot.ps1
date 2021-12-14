#Set-item -Path DellBiosProvider\DellSmbiosProv::DellSmbios:\Secureboot "Enabled" -Password (Read-Host -Prompt "Please enter BIOS Password" -AsSecureString)

#Install-Module -Name DellBIOSProvider -RequiredVersion 2.6.0


Import-Module "\\cmhprdfps53\Data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Convert_DellST_AD.psm1" -ArgumentList $Global:ADMachineName

#$Global:CurrentMachine = $env:COMPUTERNAME


    Import-Module "\\cmhprdfps53\Data\HelpDesk\Powershell Automation\EUT\Base_Scripts\SecuredAdminCredsTemplate.psm1"
    $computerSystem = "*"+$item 
    $ADMachineName = Get-ADComputer -filter {name -LIKE $computerSystem} | Select-object -expandproperty Name
    $Connect = test-Connection $ADMachineName -Count 1 -ErrorAction SilentlyContinue

    if($Connect){
        Invoke-Command -computerName $ADMachineName -Credential $Creds -ScriptBlock{

        Copy-item -Path "\\cmhprdfprd53\data\helpdesk\powershell automation\EUT\Modules\DellBIOSProvider" -Destination "c:\Program Files\WindowsPowerShell\Modules\" -Recurse -Force

        Set-ExecutionPolicy Bypass
        
        Import-Module DellBiosProvider

        #ACTION
        Get-DellBiosSettings
        $CurrentValue = (get-item -Path "dellsmbios:\SecureBoot\SecureBoot").CurrentValue
        }
        if($CurrentValue -eq "Disabled"){
        $BIOSPassword = read-host "Enter the BIOS Password for this machine:" -AsSecureString
        (Set-item -Path "dellsmbios:\SecureBoot\SecureBoot" enabled -Password $BIOSPassword)
        }    

    }else{
        Write-Error "Host: $ADMachineName" -Category ConnectionError
        #$connect
    }