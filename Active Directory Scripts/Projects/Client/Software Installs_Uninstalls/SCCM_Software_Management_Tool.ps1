Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Press_any_key_prompt.psm1"
Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Convert_DellST_AD.psm1"
Function Trigger-AppInstallation
{
 
Param
(
 [String][Parameter(Mandatory=$True, Position=1)] $AppName,
 [ValidateSet("Install","Uninstall")]
 [String][Parameter(Mandatory=$True, Position=2)] $Method
)
 
Begin {
global:Convert-DellST
$InstalledApps = (Get-CimInstance -ClassName CCM_Application -Namespace "root\ccm\clientSDK" -ComputerName $Script:ADMachineName | Select Name | Sort Name)
$InstalledApps
$Application = $InstalledApps |Where-Object {$_.Name -like $AppName}
 
$Args = @{EnforcePreference = [UINT32] 0
Id = "$($Application.id)"
IsMachineTarget = $Application.IsMachineTarget
IsRebootIfNeeded = $False
Priority = 'High'
Revision = "$($Application.Revision)" }
 
}
 
Process
 
{
 
Invoke-CimMethod -Namespace "root\ccm\clientSDK" -ClassName CCM_Application -ComputerName $Script:ADMachineName -MethodName $Method -Arguments $Args
 
}
 
End {}
 
}Trigger-AppInstallation