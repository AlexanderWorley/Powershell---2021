$arrays = @("Group1","Group2","Group3")



foreach ($object in $arrays){

Get-ADGroup -filter {Name -like $Object } -Properties managedBy |ForEach-Object {
    # Find the managedBy user
    $GroupManager = Get-ADUser -Identity $_.managedBy

    # Create a new custom object based on the group properties + managedby user
    New-Object psobject -Property @{
        Name       = $_.Name
        ManagedBy  = $GroupManager.Name
       
    }
    } 
}