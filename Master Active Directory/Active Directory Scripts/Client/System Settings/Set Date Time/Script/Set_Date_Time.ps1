<# 
   ----------------- BEFORE USING THIS SCRIPT -----------------
   Please note: If the user is not in the same timezone this script will not set the proper time. I have to 
   figureout a way to detect and apply timezones automatically. alternatively you can use this command to 
   set the date and time manually:

   Invoke-Command -ComputerName $hostname -ScriptBlock {Wednesday, April 21, 2021 01:59:59 PM}
   Note that you have to apply the time in that person's timezone HERE rather than your current time. 

#>
Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Press_any_key_prompt.psm1"
Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Convert_DellST_AD.psm1" -ArgumentList $Global:ADMachineName


function set-remotedatetime{

        $global:datetime = Get-Date
        $trimmedDateTime = $global:datetime.AddSeconds(–$datetime.Second)
        $currentDateonTarget = Invoke-Command -ComputerName $ADMachineName -ScriptBlock {Get-Date}


if(Test-Connection $ADMachineName -Count 1 -ErrorAction SilentlyContinue){

    if($currentDateonTarget -eq $trimmedDateTime){

        Write-Host "Date is set to $($datetime)" -ForegroundColor Green
        write-Host "Exiting application. Time is synced already" -fore red

    }else{
    $confirm = read-host "Do you want to sync with local time[Y] or set a specific timeframe[N]?" -confirm
     if($confirm -eq "Y"){
        write-host "Detected sync failure to current date-time: $($currentDateonTarget)" -fore Red   
        sleep 3
        Invoke-Command -ComputerName $ADMachineName -ScriptBlock {$using:datetime}
        sleep 3
        write-Host "Executing time update on $($ADMachineName)" -fore DarkMagenta
        sleep 3
        Write-Host "Time has been updated please confirm the below time is correct with user" -fore Magenta
    }elseif($confirm -eq "N"){
        write-host "Detected sync failure to current date-time: $($currentDateonTarget)" -fore Red        
        sleep 3
        $datetime = read-host "Set date and time to this format: Wednesday, April 21, 2021 01:59:59 PM"
        Invoke-Command -ComputerName $ADMachineName -ScriptBlock {set-date -date $using:datetime}
        sleep 3
        write-Host "Executing time update on $($ADMachineName)" -fore DarkMagenta
        sleep 3
        Write-Host "Time has been updated please confirm the below time is correct with user" -fore Magenta
    }

    }
}else{
        write-Host "Unable to connect to $($ADMachineName), Please validate hostname spelling or connection to the netjets network" -fore Red
        $testconnection
        }
   Pause }set-remotedatetime