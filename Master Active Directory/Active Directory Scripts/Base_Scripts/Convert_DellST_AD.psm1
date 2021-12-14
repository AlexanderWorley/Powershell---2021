function Convert-DellST{

$computerSystem = Read-Host "Input Dell Service Tag"

#Converts the service tag for CMH machines into their AD property. Used to pass the hostname in via scripts for all CMH machines.
$computerSystem = "*"+$computerSystem 
$Global:ADMachineName = Get-ADComputer -filter {name -LIKE $computerSystem} | Select -expandproperty Name
Write-Host "Targeted Machine: $($Global:ADMachineName)" -Fore magenta
}Convert-DellST