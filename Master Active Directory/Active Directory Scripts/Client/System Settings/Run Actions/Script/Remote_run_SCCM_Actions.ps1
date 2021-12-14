#runs ALL actions on a remote machine. Run the script and it will request for the machine name. 
Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Press_any_key_prompt.psm1"
Import-Module "\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Base_Scripts\Convert_DellST_AD.psm1" -ArgumentList $Global:ADMachineName -Force

function run-ActionsTarget{

$Items = @("{00000000-0000-0000-0000-000000000121}",
            "{00000000-0000-0000-0000-000000000003}",
            "{00000000-0000-0000-0000-000000000010}",
            "{00000000-0000-0000-0000-000000000001}",
            "{00000000-0000-0000-0000-000000000021}",
            "{00000000-0000-0000-0000-000000000002}",
            "{00000000-0000-0000-0000-000000000031}",
            "{00000000-0000-0000-0000-000000000114}",
            "{00000000-0000-0000-0000-000000000114}",
            "{00000000-0000-0000-0000-000000000113}",
            "{00000000-0000-0000-0000-000000000111}",
            "{00000000-0000-0000-0000-000000000026}",
            "{00000000-0000-0000-0000-000000000027}",
            "{00000000-0000-0000-0000-000000000032}",
            "{00000000-0000-0000-0000-000000000022}"
            )
$Repeat = 0
if (Test-connection $script:ADMachineName -Quiet -Count 1) {
    Do{
    $Items | % {     
        Invoke-WMIMethod -ComputerName $script:ADMachineName -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule $items
        sleep 1
            }
            $Repeat++
     }While($Repeat -lt 2)
            
          }else{
          Write-Error -Message "Machine is offline to your machine" -ErrorId 04
          } 
Pause}run-ActionsTarget
