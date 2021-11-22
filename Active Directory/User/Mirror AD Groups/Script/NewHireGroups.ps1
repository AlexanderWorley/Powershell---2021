# Test path for the excel import funcationality
$TestPath = Test-Path "C:\Program Files\WindowsPowerShell\Modules\ImportExcel"
If($TestPath){
Write-Host "Excel Module is installed. Importing Module" -Back DarkCyan
Import-Module ImportExcel
Write-Host "Module Imported" -back DarkCyan
}else{
Install-Module -Name ImportExcel
} 


[System.Collections.ArrayList]$YellowGroups_Confirm = @()
[System.Collections.ArrayList]$RedGroups_Removed = @()
[System.Collections.ArrayList]$groupset = @()
[System.Collections.ArrayList]$YellowGroups_removed = @()
[System.Collections.ArrayList]$WhiteGroups = @()
$CheckFile = import-excel '\\cmhprdfps53\data\HelpDesk\Powershell Automation\ServiceDesk\Active Directory\User\Mirror AD Groups\Data\GroupsCheck.xlsx'
#inputs for mirror and new hire user. This will just be a input field in app.
$MirrorUser = Read-Host "Input the user to mirror"
$NewHire = read-Host "Input the New Hire's username"
#Gets full names of the groups
$grplist = (Get-ADUser –Identity $MirrorUser –Properties MemberOf | Select memberof).Memberof


###################### FILTERING ####################################
#Gathers group names as shown as passed by a user's access
foreach($item in $grplist){
    try{
        $GroupValue = (Get-ADGroup -identity $item | sort-object Name).name
        $groupset += $groupvalue
        $RedGroups_removed += $GroupValue
        }catch{<#Silences error messages from netjets.com domain}#>}
}
#Filters out all red case items that are listed in CheckFile
Foreach($RedItem in $CheckFile.Red){
    Foreach($newitem in $groupset){
        if($newitem -Like "$RedItem*"){
            Write-Host "Removed case RED: $($newItem)" -back Red
            $RedGroups_removed.remove($newitem)
            
    }
  }
}

#Copy Array to new array for Further filtering
$YellowGroups_removed = $YellowGroups_removed + $RedGroups_removed
#Filters out and assigns to a new array the yellow items for adding later if needed
Foreach($YellowItem in $CheckFile.Yellow){
    Foreach($NewYellowItem in $RedGroups_Removed){
        if($NewYellowItem -LIKE "$YellowItem"){
            Write-Host "Removed case Yellow: $($NewYellowItem)" -back DarkYellow
            $YellowGroups_Confirm.Add($NewYellowItem)
            $YellowGroups_removed.remove($NewYellowItem)
        }
    }
}
#Adding white listed groups. 
########################### ADDING ##########################################
$whiteGroups = $whiteGroups + $YellowGroups_removed
    Foreach ($group in $whiteGroups) {
            Try{          
                Add-ADGroupMember -Identity $group -Members $NewHire
                 Write-Host "Added: $group" -back DarkCyan
            }catch{#If error; stay silent 
            }
    }
pause