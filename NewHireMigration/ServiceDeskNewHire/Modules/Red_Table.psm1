#Primary function for the datagridview.
function updateRedData{
#Passes the employee lookup Value as a parameter.
param(
$Script:Mirror_TextBox
)
Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Start - $Script:Mirror_TextBox`""
Start-Logging $Script:NewHire_TextBox
 
        Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Creating Datatable- $Script:NewHire_TextBox`""
$Red_users_Lookup_GridDataTable= New-Object System.Data.DataTable
$Red_users_Lookup_GridDataTable.Columns.Add('Group Name', [string]) | Out-Null
 
#Passes the user's input as values then passes that as a variable to the rows. This is what is pulled from AD when a user looks up an employee.
        Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Pulling AD Object - $Script:Mirror_TextBox`""
$values = (Get-ADUser –Identity $Script:Mirror_TextBox –Properties MemberOf | Select memberof).Memberof
 
foreach($item in $values){
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
           
            $newitem += $RedArray
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

Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Filerting AD Object - $Script:Mirror_TextBox`""
$Red_users_Lookup_GridDataTable.rows[0].Values = $RedArray

        Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Exporting Data - $Script:Mirror_TextBox`""
$Red_users_Lookup_GridDataTable.rows.add("Name","") | Out-Null <#0#>
#Passes the table as a dataset. Returns the data set. This is what processes the datagridview.
$Red_ds= New-Object System.Data.DataSet
$Red_ds.Tables.Add($Red_users_Lookup_GridDataTable)
 
        Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Stop - $Script:Mirror_TextBox`""
Return $Red_ds
}