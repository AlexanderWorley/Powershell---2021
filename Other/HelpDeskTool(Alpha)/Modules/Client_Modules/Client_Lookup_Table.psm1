#Primary function for the datagridview.
function UpdateClientData{
#Passes the Client lookup Value as a parameter.
param(
$Client_Lookup_Value
    )
        Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Start - $Client_Lookup_Value`""
$Server = 'cmh.netjets.com'
Start-Logging $Client_Lookup_Value
 
        Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Creating Datatable- $Client_Lookup_Value`""

$Client_Lookup_GridDataTable= New-Object System.Data.DataTable
$Client_Lookup_GridDataTable.Columns.add("Attributes",[string]) |Out-Null
$Client_Lookup_GridDataTable.Columns.add("Values",[string]) |Out-Null

$Client_Lookup_GridDataTable.rows.add("Name","") | Out-Null <#0#>
$Client_Lookup_GridDataTable.rows.add("Created","") | Out-Null <#1#>
$Client_Lookup_GridDataTable.rows.add("Description","") | Out-Null <#2#>
$Client_Lookup_GridDataTable.rows.add("Enabled","") | Out-Null <#3#>
$Client_Lookup_GridDataTable.rows.add("IP Address","") | Out-Null <#4#>
$Client_Lookup_GridDataTable.rows.add("LastLogonDate","") | Out-Null <#5#>
$Client_Lookup_GridDataTable.rows.add("Modified","") | Out-Null <#6#>
$Client_Lookup_GridDataTable.rows.add("OperatingSystem","") | Out-Null <#7#>
$Client_Lookup_GridDataTable.rows.add("OS Version","") | Out-Null <#9#>
 
        Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Pulling AD Object - $Client_Lookup_Value`""
        $Clientvalues = Get-ADComputer -Server $Server -filter{cn -eq $Client_Lookup_Value} -properties cn,Created,Description,Enabled,IPv4Address,LastLogonDate,Modified,OperatingSystem,OperatingSystemVersion

 
        Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Filerting AD Object - $Client_Lookup_Value`""
$Client_Lookup_GridDataTable.rows[0].Values = $Clientvalues | Select -ExpandProperty cn
$Client_Lookup_GridDataTable.rows[1].Values = $Clientvalues | Select -ExpandProperty Created
$Client_Lookup_GridDataTable.rows[2].Values = $Clientvalues | Select -ExpandProperty Description
$Client_Lookup_GridDataTable.rows[3].Values = $Clientvalues | Select -ExpandProperty Enabled
$Client_Lookup_GridDataTable.rows[4].Values = $Clientvalues | Select -ExpandProperty IPv4Address
$Client_Lookup_GridDataTable.rows[5].Values = $Clientvalues | Select -ExpandProperty LastLogonDate
$Client_Lookup_GridDataTable.rows[6].Values = $Clientvalues | Select -ExpandProperty Modified
$Client_Lookup_GridDataTable.rows[7].Values = $Clientvalues | Select -ExpandProperty OperatingSystem
$Client_Lookup_GridDataTable.rows[8].Values = $Clientvalues | Select -ExpandProperty OperatingSystemVersion
                       
        Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Exporting Data - $Client_Lookup_Value`""
#Passes the table as a dataset. Returns the data set. This is what processes the datagridview.
$Client_ds= New-Object System.Data.DataSet
$Client_ds.Tables.Add($Client_Lookup_GridDataTable)
 
        Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Stop - $Client_Lookup_Value`""
Return $Client_ds
}