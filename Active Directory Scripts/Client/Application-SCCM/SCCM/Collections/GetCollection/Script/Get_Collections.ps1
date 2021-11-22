Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Press_any_key_prompt.psm1"
Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Convert_DellST_AD.psm1"

function get-collection{
global:Convert-DellST
if($ADMachineName){
Get-CimInstance -ClassName CCM_Application -Namespace "root\ccm\clientSDK" -ComputerName $Script:ADMachineName | Select Name | Sort Name
}
pause}Get-collection