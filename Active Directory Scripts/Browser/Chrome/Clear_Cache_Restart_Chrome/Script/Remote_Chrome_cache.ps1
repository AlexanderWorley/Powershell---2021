function clear-ChromeCache{
Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Press_any_key_prompt.psm1"
Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Convert_DellST_AD.psm1" -ArgumentList $Global:ADMachineName -Force
#Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\SecuredAdminCredsTemplate.psm1"-ArgumentList $global:Creds -force 

#Detects and ends Process. Then executes the clear cache then restarts chrome 
$Process = Invoke-Command -ComputerName $Global:ADMachineName -ScriptBlock  {Get-Process  -name "Chrome" -ErrorAction SilentlyContinue}
If($Process){
$EndProcess = Invoke-Command -ComputerName $Global:ADMachineName -ScriptBlock {Stop-Process -name "Chrome"}
write-host "Closing Chrome"
}
#targets chrome cache folder and clears all contents. Allows for remote cache clear for managed windows assets.
#Run the script, script will prompt for any information needed. 
$Items = @('Archived History',
            'Cache\*',
            'Cookies',
            'Login Data',
            'Top Sites',
            'Visited Links',
            'Web Data')
$user = read-host "Input the username of the user"
$Folder = "\\$Global:ADMachineName\c$\users\$user\AppData\Local\Google\Chrome\User Data\Default"
$Items | % { 
$test = Test-Path "$Folder\$_"
    if ($test) {
        Remove-Item "$Folder\$_" 
         }
         write-host "Removed $($_)"
        }

        write-host "Opening Chrome"    
    Enter-PSSession -ComputerName $Global:ADMachineName
        Start-Process "Chrome"
            
    Exit-PSSession
pause}clear-ChromeCache