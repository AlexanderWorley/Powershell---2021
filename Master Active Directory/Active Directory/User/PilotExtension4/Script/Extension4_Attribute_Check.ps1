
$TestPath = Test-Path "C:\Program Files\WindowsPowerShell\Modules\ImportExcel"
If($TestPath){
Write-Host "Excel Module is installed. Importing Module" -Back DarkCyan
Import-Module ImportExcel
Write-Host "Module Imported" -back DarkCyan
}else{
Install-Module -Name ImportExcel
} 
$FiletypePath = Read-Host "Input the full file path of the file you wish to import"
$CSVExcel = dir $FiletypePath | select -ExpandProperty Extension

if($CSVExcel -eq ".xlsx"){
Write-host "EXCEL FILE DETECTED" -back DarkCyan
$List = Import-excel -Path $FiletypePath
}elseif($CSVExcel -eq ".csv"){
Write-host "CSV FILE DETECTED" -back DarkCyan
$List = Import-CSV -Path $FiletypePath
}else{
Write-Host "Invalid file type supported. Please enter a xlsx or csv file" -back red
pause
exit
}
Write-Host "Importing Excel Document" -back DarkCyan
Sleep 2
write-Host "CHECKING USERS"-back DarkCyan
$value = foreach($user in $List.Username){
Get-ADUser -filter{SAMAccountName -eq $user} -properties * | Select Name,Extensionattribute4} 
$env:Path = "C:\temp\Exportfile.xlsx"
Write-Host "Exporting path to $env:Path" -Back DarkGreen
$value | export-excel -Path $env:Path
pause