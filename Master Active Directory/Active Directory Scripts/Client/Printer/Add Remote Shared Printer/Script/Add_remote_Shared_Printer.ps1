Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Press_any_key_prompt.psm1"
Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Convert_DellST_AD.psm1" -ArgumentList $Global:ADMachineName -Force

$servername = "CMHPRDPRNTQ01"
if(Test-Connection $ADMachinename){
$printers = Get-Printer -ComputerName $servername | Sort Name
$single_output = $printers | Out-GridView -Title "Select the printer that you want to install" -OutputMode Single

Write-Host "Installing Printer" $single_output.Name -BackgroundColor Cyan -ForegroundColor Black
$printer = $single_output.Name
$printServer = $single_output.ComputerName
Enter-PSSession -ComputerName $ADMachinename
Add-Printer -ConnectionName \\$servername\$printer
Write-host "$($Printer) added to: $($ADMachinename)" -BackgroundColor Cyan -ForegroundColor Black
Exit-PSSession

pause}else{
Write-Error -Message "Unable to connect to target machine" -Category ConnectionError
pause
}