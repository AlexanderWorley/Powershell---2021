<# 
   ----------------- BEFORE USING THIS SCRIPT -----------------
   Please note: If the user is not in the same timezone this script will not set the proper time. I have to 
   figureout a way to detect and apply timezones automatically. alternatively you can use this command to 
   set the date and time manually:

   Invoke-Command -ComputerName $hostname -ScriptBlock {Wednesday, April 21, 2021 01:59:59 PM}
   Note that you have to apply the time in that person's timezone HERE rather than your current time. 

#>

$hostname = read-Host "Input target hostname"

$datetime = Get-Date

$trimmedDateTime = $datetime.AddSeconds(–$datetime.Second)

$currentDateonTarget = Invoke-Command -ComputerName $hostname -ScriptBlock {Get-Date}


if(Test-Connection $hostname -Count 1 -ErrorAction SilentlyContinue){

    if($currentDateonTarget -eq $trimmedDateTime){

        Write-Host "Date is set to $($datetime)" -ForegroundColor Green
        write-Host "Exiting application. Time is synced already" -fore red

    }else{

        write-host "Detected sync failure to current date-time: $($currentDateonTarget)" -fore Red

        write-Host "Executing time update on $($hostname)" -fore DarkMagenta

        Invoke-Command -ComputerName $hostname -ScriptBlock { set-date -date $datetime;}

        Write-Host "Time has been updated please confirm the below time is correct with user" -fore DarkMagenta

        Invoke-Command -ComputerName $hostname -ScriptBlock {$using:datetime}
    }

}else{
write-Host "Unable to connect to $($hostname), Please validate hostname spelling or connection to the netjets network" -fore Red
$testconnection
}