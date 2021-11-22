#Primary function for the datagridview.
function updateData{
#Passes the employee lookup Value as a parameter.
param(
$Employee_Lookup_Value
)
        Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Start - $Employee_Lookup_Value`""
$Server = 'cmh.netjets.com'
Start-Logging $Employee_Lookup_Value
 
        Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Creating Datatable- $Employee_Lookup_Value`""
#Rows and columns that are static. Change these and you change the Left most defaults. you can add and remove lines as well.
$users_Lookup_GridDataTable= New-Object System.Data.DataTable
$users_Lookup_GridDataTable.Columns.Add('Attributes', [string]) | Out-Null
$users_Lookup_GridDataTable.Columns.Add('Values', [string]) | Out-Null
$users_Lookup_GridDataTable.rows.add("Username","") | Out-Null <#0#>
$users_Lookup_GridDataTable.rows.add("Name","") | Out-Null <#1#>
$users_Lookup_GridDataTable.rows.add("Manager","") | Out-Null <#2#>
$users_Lookup_GridDataTable.rows.add("eMail","") | Out-Null <#3#>
$users_Lookup_GridDataTable.rows.add("Title","") | Out-Null <#4#>
$users_Lookup_GridDataTable.rows.add("Password Last Set","") | Out-Null <#5#>
$users_Lookup_GridDataTable.rows.add("Last Bad Password","") | Out-Null <#6#>
$users_Lookup_GridDataTable.rows.add("Enabled","") | Out-Null <#7#>
$users_Lookup_GridDataTable.rows.add("Locked Out","") | Out-Null <#8#>
 
#Passes the user's input as values then passes that as a variable to the rows. This is what is pulled from AD when a user looks up an employee.
        Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Pulling AD Object - $Employee_Lookup_Value`""
$values = get-aduser -server $Server -Filter {employeeID -eq $Employee_Lookup_Value} -Properties *
$manager = get-aduser -server $Server -filter {employeeID -eq $Employee_Lookup_Value} -properties * | Select @{N='Manager';E={(Get-ADUser $_.Manager).Name}}
$lastbadpassword= $values | select @{Name="badPasswordTime";Expression={([datetime]::FromFileTime($_.badpasswordtime))}}
 
        Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Filerting AD Object - $Employee_Lookup_Value`""
$users_Lookup_GridDataTable.rows[0].Values = $Values | Select -ExpandProperty Samaccountname
$users_Lookup_GridDataTable.rows[1].Values = $Values | Select -ExpandProperty cn
$users_Lookup_GridDataTable.rows[2].Values = $manager.manager
$users_Lookup_GridDataTable.rows[3].Values = $Values | Select -ExpandProperty mail
$users_Lookup_GridDataTable.rows[4].Values = $Values | Select -ExpandProperty Title
$users_Lookup_GridDataTable.rows[5].Values = $Values | Select -ExpandProperty PasswordLastSet
$users_Lookup_GridDataTable.rows[6].Values = $lastbadpassword.badpasswordtime
$users_Lookup_GridDataTable.rows[7].Values = $Values | Select -ExpandProperty enabled
$users_Lookup_GridDataTable.rows[8].Values = $Values | Select -ExpandProperty lockedout
                       
        Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Exporting Data - $Employee_Lookup_Value`""
#Passes the table as a dataset. Returns the data set. This is what processes the datagridview.
$ds= New-Object System.Data.DataSet
$ds.Tables.Add($users_Lookup_GridDataTable)
 
        Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Stop - $Employee_Lookup_Value`""
Return $ds
}