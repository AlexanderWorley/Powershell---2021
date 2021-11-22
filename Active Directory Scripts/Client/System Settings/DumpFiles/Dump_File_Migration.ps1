Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Convert_DellST_AD.psm1" -ArgumentList $Global:ADMachineName -Force

function dumpFileMigration{
$TargetDrive = "\\cmhprdcod01\OSDChecklists\CrashDump\$Global:ADMachineName\"
$TargetPath = "\\$Global:ADMachine\c$\WINDOWS\Minidump\"
#New Folder
$TestPath = Test-Path $TargetDrive
        if($TestPath -eq $false){
            New-Item -path $TargetDrive -ItemType Directory
            Write-Host "New Folder Created for $Global:ADMachineName" -fore Magenta
            sleep 5
        }else{
            write-host "Hostname folder found | Dumping File" -FORE Green
        }
$ItemName = get-childitem -path $TargetPath -Filter "*.dmp" |sort-object -Property $_.LastWriteTime | select-object -First 1
$ItemNewName = $ItemName.CreationTime.ToString("dd_MM_yyyy_HH-MM-s").Trim()
$ItemName | copy-item -Destination ($TargetDrive + "\$ItemNewName.dmp")

$testPath2 = Test-Path "$TargetDrive\$($ItemNewName)*"
        if($TestPath2){
        Write-Host "New File Detected: $ItemNewName" -fore Green
        }
}dumpFileMigration