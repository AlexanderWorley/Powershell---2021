#launches file explorer to the target system.

Function Get-MapCDrive{ 
param(

$WorkingSystem

)
    Start-process explorer.exe  "\\$WorkingSystem\c$\" 
    }

    #Reboots the target system
    Function Set-SystemReboot{
    
param(

$WorkingSystem

)
     $Connection = if (test-connection cmh-mis-G8FM533 -Count 1 -ErrorAction SilentlyContinue ) {$true} else {$false}
    if($connection -eq $true){
    write-host $workingsystem
        #pop up a yes or no for rebooting the machine. '
            if ([System.Windows.Forms.MessageBox]::Show("Are you sure you wish to restart $WorkingSystem","Restart machine","YesNo") -eq [System.Windows.Forms.DialogResult]::Yes){           
             #ENABLE ONCE APPROVED Restart-Computer $workingSystem  -Force                 
                    [System.Windows.Forms.MessageBox]::Show("$WorkingSystem has been restarted","Restart machine","Ok")
            
            }else{                
                    [System.Windows.Forms.MessageBox]::Show("$WorkingSystem will not be restarted","Restart machine","Ok")
            }
            }else{          
                    #Popup a window that says no machine was able to be connected
                    [System.Windows.Forms.MessageBox]::Show("$WorkingSystem is not online or there is a misspelling.","Restart machine","Ok")
            }
    }


    Function Get-BasicInfoApps{
    param(

$WorkingSystem

)
    #add a label to the output file
    #Get the 32-bit applications
    C:\SysinternalsSuite\psinfo.exe -s Applications -accepteula \\$Workingsystem | Out-GridView -Title "32 Bit Applications"

    #add a label and empty line for the 64 bit apps
    add-content C:\SysinternalsSuite\temp\sysinfo.txt "64bit Applications"
    #get the 64-bit applications
    C:\SysinternalsSuite\psinfo64.exe -s Applications -acceptEULA \\$Workingsystem | Out-GridView -Title "64 Bit Applications"


    }
    #Gets the installed updates
    Function Get-InstalledUpdates{
    param(

$WorkingSystem

)
    #Get Hotfixes
    Get-HotFix -ComputerName $Workingsystem |select PSComputername,InstalledOn,Description,HotfixID,InstalledBy | Out-GridView  -Title "Installed Updates"       

    }

    #Runs the listen application

    Function set-SCCMUpdateCycles(){

    [cmdletbinding]
    
    $MachinePolicyRetrievalEvaluation = "{00000000-0000-0000-0000-000000000021}"
	$SoftwareUpdatesScan = "{00000000-0000-0000-0000-000000000113}"
	$SoftwareUpdatesDeployment = "{00000000-0000-0000-0000-000000000108}"

	#################### Software Update Scan Cycles ###################
	Invoke-WmiMethod -ComputerName $workingsystem -Namespace root\ccm -Class sms_client -Name TriggerSchedule $MachinePolicyRetrievalEvaluation
	Start-Sleep -s 2
    Invoke-WmiMethod -ComputerName $workingsystem -Namespace root\ccm -Class sms_client -Name TriggerSchedule $SoftwareUpdatesScan
	Start-Sleep -s 2  
    Invoke-WmiMethod -ComputerName $workingsystem -Namespace root\ccm -Class sms_client -Name TriggerSchedule $SoftwareUpdatesDeployment
    [System.Windows.Forms.MessageBox]::Show("SCCM Update Cycles triggered" , "Status Message")
    

    }


    Function Set-SCCMAppCycles(){

    [cmdletbinding]
    
    $MachinePolicyRetrievalEvaluation = "{00000000-0000-0000-0000-000000000021}"
	$AppPolicyAction = "{00000000-0000-0000-0000-000000000121}"
	$SoftwareInventory = "{00000000-0000-0000-0000-000000000002}"

	#################### check if Scan cycles are working ###################
	Invoke-WmiMethod -ComputerName $workingsystem -Namespace root\ccm -Class sms_client -Name TriggerSchedule $MachinePolicyRetrievalEvaluation
	Start-Sleep -s 2
    Invoke-WmiMethod -ComputerName $workingsystem -Namespace root\ccm -Class sms_client -Name TriggerSchedule $AppPolicyAction
	Start-Sleep -s 2
    Invoke-WmiMethod -ComputerName $workingsystem -Namespace root\ccm -Class sms_client -Name TriggerSchedule $SoftwareInventory
    [System.Windows.Forms.MessageBox]::Show("SCCM Application Cycles triggered" , "Status Message")

    }
    $SCCMAppCycButton = New-Object System.Windows.Forms.Button
    $SCCMAppCycButton.Text = 'Run SCCM Software Cycles'
    $SCCMAppCycButton.Location = '400,105'
    $SCCMAppCycButton.size = '250,23'
    
    $SCCMAppCycButton.add_click({SCCMAppCycles})


   Function Get-EventViewer{
    param(

$WorkingSystem

)
    Eventvwr $workingsystem | Out-Gridview
    

    }

    Function Get-OfficeVersion{
    param(

$WorkingSystem

)
    
    if(test-path "\\$workingsystem\c$\Program Files (x86)\Microsoft Office\root\Office16\Winword.exe") {$Office = "Installed"}
    Else{$Office = "Not Installed"}
    
    
    if(test-path "\\$workingsystem\c$\Program Files (x86)\Microsoft Office\root\Office16\visio.exe") {$Visio = "Installed"}
    Else{$Visio = "Not Installed"}

    if(test-path "\\$workingsystem\c$\Program Files (x86)\Microsoft Office\root\Office16\WINPROJ.EXE") {$Project = "Installed"}
    Else{$Project = "Not Installed"}
    

    if(test-path "\\$workingsystem\c$\Program Files (x86)\Microsoft Office\root\Office16\MSACCESS.EXE") {$Access = "Installed"}
    Else{$Access = "Not Installed"}
    $access
    
    [System.Windows.Forms.MessageBox]::Show("
    Office 365 is $Office
    Access is $Access
    Visio is $Visio
    Project is $Project" , "Office Status")

    }