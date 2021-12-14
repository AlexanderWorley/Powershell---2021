Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Convert_DellST_AD.psm1" -ArgumentList $Global:ADMachineName -Force

function run-validation{

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
$Results
}run-validation