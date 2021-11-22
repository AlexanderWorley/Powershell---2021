Set-ExecutionPolicy Bypass
Import-Module "\\cmhprdfps53\data\helpdesk\powershell automation\EUT\Base_scripts\Convert_dellst_ad.psm1" -ArgumentList $Global:ADMachineName -Force
#Check if the machine is online
$TestConnection = Test-Connection $global:ADMachineName -Count 1 -Quiet
#If online execute script
if($TestConnection){
#reach out to machine
Install-Module CredentialManager -Force

#Pull credentials set to targetname
$Credential = Get-StoredCredential -AsCredentialObject
$Credential = $Credential.TargetName
#Run through processes
$processlist = @('outlook','teams','POWERPNT','excel','onenote','OneDrive','Word')
$processList2 = Get-Process -name $processlist -ErrorAction ignore
foreach($process in $processlist2){
     try{        
        Stop-Process -Id $processList2.id -ErrorAction ignore    
        Write-Host "Closing $($process)" -back DarkCyan       
    }catch{
        write-Host "$process not found" -back DarkCyan
          }
}  

Foreach($CredentialName in $Credential ){
if($CredentialName -match "OneDrive"){
try{
Remove-StoredCredential -target $CredentialName
Write-Host "DELETED: $CredentialName " -BackgroundColor DarkCyan
Write-Host '''Please log out/backin to Office then relaunch OneDrive.''' -Fore Green -BackgroundColor Black
}catch{
write-Host "Unable to clear credential. Please try again or manually remove."
}}else{
Write-Host "'$CredentialName' has been ignored" -BackgroundColor Cyan -ForegroundColor Black
            }
        }    
}else{
Write-Host "Unable to connect to $Global:ADMachineName. Please validate WINRM is enabled" -BackgroundColor red

    }
    
pause