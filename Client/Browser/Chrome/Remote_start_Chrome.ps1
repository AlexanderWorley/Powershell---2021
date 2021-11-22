#starts chrome on a targeted machine. Run the script and it will ask for any information needed. 

$machine = read-host "Input target machine name"
Invoke-Command -ComputerName $machine -ScriptBlock {Start-Process Chrome.exe } 