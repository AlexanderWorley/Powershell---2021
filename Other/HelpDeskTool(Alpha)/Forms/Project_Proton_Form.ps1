function Start-Logging(){
    param(
                    $log
    )
}

    #File Locations for Modules, root location.
    $Global:rootLocation= "V:\HelpDesk\Powershell Automation\ServiceDesk\HelpDeskTool(Alpha)\Modules"
    #Erase logs older than 30 days and starts the new log after that
    $Script:limit= (Get-Date).AddDays(-30)
    #Get-ChildItem -Path "$Global:rootLocation\Logs" -Recurse -Force | Where-Object { !$_.PSIsContainer-and $_.CreationTime-lt$limit } | Remove-Item -Force
    Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - Proton Core: `"Executing Transcript`""
    #Start-Transcript -Path "$Global:rootLocation\Logs\Log_$(Get-Date -UFormat"%Y-%m-%d_%H-%M").log"
    Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - Proton Core: `"Importing Modules`""
    Import-Module -DisableNameChecking -name "$Global:rootlocation\User_Modules\HDT_Table Source.psm1"
    Import-Module -DisableNameChecking -name "$Global:rootlocation\Client_Modules\Client_Lookup_Table.psm1"
    Import-Module -DisableNameChecking -name "$Global:rootlocation\Client_Modules\NJClientFunctions.psm1"
    Import-Module -DisableNameChecking -name "$Global:rootlocation\AD_Modules\GetADInfo.psm1"
    Import-Module -DisableNameChecking -name "V:\HelpDesk\Powershell Automation\ServiceDesk\HelpDeskTool(Alpha)\forms\Config_Manager_Form.psm1"
    #imports AD module and assemblies.
    Import-Module ActiveDirectory
    $Server = 'cmh.netjets.com'
                


Function Open-GUI{
    Add-Type -AssemblyName Microsoft.VisualBasic
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.Application]::EnableVisualStyles()
    #Launches the main form    
    $Image = [system.drawing.image]::FromFile("$Global:rootlocation\Images\bg.png")           
    Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - Proton Core: `"Initializing Form`""
    $Script:Server= 'cmh.netjets.com'
    $Form = New-Object system.Windows.Forms.Form
    $Form.ClientSize= '610,375' 
    $Form.text= "Proton (Beta v1.1)"
    $Form.TopMost= $false
    $form.backgroundImage = $Image
                
    #region MenuBar
    #Rendering the menu and the parent options

    $Proton_MenuMS= New-Object System.Windows.Forms.MenuStrip
    $Proton_User_Tools= New-Object System.Windows.Forms.ToolStripMenuItem
    $Proton_AD_Tools= New-Object System.Windows.Forms.ToolStripMenuItem
    $proton_File = New-Object System.Windows.Forms.ToolStripMenuItem
    $Proton_Client_Tools = New-Object System.Windows.Forms.ToolStripMenuItem
    

    #Rendering the sub Options

    #File Sub
    $proton_File_Help = New-Object System.Windows.Forms.ToolStripMenuItem
    #User Tools Sub
    $Proton_User_Tools_Option1 = New-Object System.Windows.Forms.ToolStripMenuItem
    #Client Tools Sub
    $Proton_Client_Tools_cShare = New-Object System.Windows.Forms.ToolStripMenuItem
    $Proton_Client_Tools_Installed_Apps = New-Object System.Windows.Forms.ToolStripMenuItem
    $Proton_Client_Tools_Installed_Updates = New-Object System.Windows.Forms.ToolStripMenuItem
    $Proton_Client_Tools_Config_Menu = New-Object System.Windows.Forms.ToolStripMenuItem
    $Proton_Client_Tools_Office = New-Object System.Windows.Forms.ToolStripMenuItem
    $Proton_Client_Tools_Restart = New-Object System.Windows.Forms.ToolStripMenuItem
    $Proton_Client_Tools_Event = New-Object System.Windows.Forms.ToolStripMenuItem
    

    #AD Tools Sub
    
    $Proton_AD_Tools_User_Groups = New-Object System.Windows.Forms.ToolStripMenuItem

    #Adding the drop down options to the menu strip
    $Proton_MenuMS.Items.AddRange(@($proton_File,$Proton_User_Tools,$Proton_AD_Tools,$Proton_Client_Tools)) | Out-Null
    $Proton_MenuMS.Location= '0,0'
    $Proton_MenuMS.Size= '475,24'
    $Proton_MenuMS.TabIndex= '0'
    $Form.Controls.Add($Proton_MenuMS)


    #Adding the sub options under the file drop down

    #File Option
    $proton_File.Size= '35,20'
    $proton_File.Name= 'File'
    $proton_File.Text= "&File"
    $proton_File.DropDownItems.AddRange(@($proton_File_Help)) | Out-Null
    
    #file sub options.
    $proton_File_Help.Size= '35,20'
    $proton_File_Help.Name= 'Help'
    $proton_File_Help.Text= "Help"
   

    #User Tools Option
    $Proton_User_Tools.Size= '35,20'
    $Proton_User_Tools.Name= 'User Tools'
    $Proton_User_Tools.Text= "User Tools"
    $Proton_User_Tools.DropDownItems.AddRange(@($Proton_User_Tools_Option1)) | Out-Null

    #User Tools sub Option
    $Proton_User_Tools_Option1.Size= '35,20'
    $Proton_User_Tools_Option1.Name= 'Option1'
    $Proton_User_Tools_Option1.Text= "Option1"

    #AD Tools Option
    $Proton_AD_Tools.Size= '182,20'
    $Proton_AD_Tools.Name = 'AD Tools'
    $Proton_AD_Tools.Text= "AD Tools"
    $Proton_AD_Tools.DropDownItems.AddRange(@($Proton_AD_Tools_User_Groups)) | Out-Null

    #AD Tools sub Option
    $Proton_AD_Tools_User_Groups.Size= '182,20'
    $Proton_AD_Tools_User_Groups.Name = 'Group Membership'
    $Proton_AD_Tools_User_Groups.Text= "Group Membership"
    $Proton_AD_Tools_User_Groups.Add_Click({
       
       Get-NJGroupMembers -User_Account $Script:Employee_Lookup_TextBox.text
    
    })

    #Client Tools option
    $Proton_Client_Tools.Size= '182,20'
    $Proton_Client_Tools.Name = 'Client Tools'
    $Proton_Client_Tools.Text= "Client Tools"
    $Proton_Client_Tools.DropDownItems.AddRange(@($Proton_Client_Tools_cShare,$Proton_Client_Tools_Installed_Apps,
    $Proton_Client_Tools_Installed_Updates,$Proton_Client_Tools_Config_Menu,$Proton_Client_Tools_Office,
    $Proton_Client_Tools_Event,$Proton_Client_Tools_Restart)) | Out-Null

    #Client Tools sub option
    $Proton_Client_Tools_cShare.Size= '182,20'
    $Proton_Client_Tools_cShare.Name = 'C$ Share'
    $Proton_Client_Tools_cShare.Text= "c$ Share"
    $Proton_Client_Tools_cShare.Add_Click({
       
        Get-MapCDrive -WorkingSystem $Script:Client_Lookup_Textbox.text
    
    })
    
    


    $Proton_Client_Tools_Installed_Apps.Size= '182,20'
    $Proton_Client_Tools_Installed_Apps.Name = 'Installed Apps'
    $Proton_Client_Tools_Installed_Apps.Text= "Installed Apps"
    $Proton_Client_Tools_Installed_Apps.Add_Click({
       
        Get-BasicInfoApps -WorkingSystem $Script:Client_Lookup_Textbox.text
    
    })
    $Proton_Client_Tools_Installed_Updates.Size= '182,20'
    $Proton_Client_Tools_Installed_Updates.Name = 'Installed Updates'
    $Proton_Client_Tools_Installed_Updates.Text= "Installed Updates"
    $Proton_Client_Tools_Installed_Updates.Add_Click({
       
        Get-InstalledUpdates -WorkingSystem $Script:Client_Lookup_Textbox.text
    
    })
    $Proton_Client_Tools_Config_Menu.Size= '182,20'
    $Proton_Client_Tools_Config_Menu.Name = 'Configuration Manager Menu'
    $Proton_Client_Tools_Config_Menu.Text= "Configuration Manager Menu"
    $Proton_Client_Tools_Config_Menu.Add_Click({
       
        Run-ConfigMan
    
    })
    $Proton_Client_Tools_Office.Size= '182,20'
    $Proton_Client_Tools_Office.Name = 'Gather Office Information'
    $Proton_Client_Tools_Office.Text= "Gather Office Information"
    $Proton_Client_Tools_Office.Add_Click({
       
         Get-OfficeVersion -WorkingSystem $Script:Client_Lookup_Textbox.text
    
    })
    $Proton_Client_Tools_Restart.Size= '182,20'
    $Proton_Client_Tools_Restart.Name = 'Restart Client'
    $Proton_Client_Tools_Restart.Text= "Restart Client"
    $Proton_Client_Tools_Restart.Add_Click({
       Set-SystemReboot -WorkingSystem  $Script:Client_Lookup_Textbox.text
        
    
    })
    $Proton_Client_Tools_Event.Size= '182,20'
    $Proton_Client_Tools_Event.Name = 'Event Viewer'
    $Proton_Client_Tools_Event.Text= "Event Viewer"
    $Proton_Client_Tools_Event.Add_Click({
       
        Get-EventViewer -WorkingSystem $Script:Client_Lookup_Textbox.text
    
    })


    
    #endregion MenuBar
 
 $client_Lookup = {
     if ($_.KeyCode-eq "Enter") {
            
            
            $Client_hold = UpdateClientData -Client_Lookup_Value  $Script:Client_Lookup_Textbox.text
            $Client_Lookup_Grid.datasource = $Client_hold.Tables[0]
            $Client_Lookup_Grid.Update()
}
}

    #Gridview for Machine Information and pass thru for Client Tools.
    $Script:Client_Lookup_Textbox= New-Object system.Windows.Forms.TextBox
    $Script:Client_Lookup_Textbox.multiline= $false
    $Script:Client_Lookup_Textbox.width= 146
    $Script:Client_Lookup_Textbox.height= 20
    $Script:Client_Lookup_Textbox.location= New-Object System.Drawing.Point(5,60)
    $Script:Client_Lookup_Textbox.Font= 'Microsoft Sans Serif,10'
    $Script:Client_Lookup_Textbox.Add_KeyDown($Client_Lookup)


    $Client_Lookup_Label= New-Object system.Windows.Forms.Label
    $Client_Lookup_Label.text= "Client LookUp"
    $Client_Lookup_Label.AutoSize= $true
    $Client_Lookup_Label.width= 25
    $Client_Lookup_Label.height= 10
    $Client_Lookup_Label.backcolor= [System.Drawing.Color]::FromName("Transparent")
    $Client_Lookup_Label.location= New-Object System.Drawing.Point(5,35)
    $Client_Lookup_Label.forecolor= "White"
    $Client_Lookup_Label.font= New-Object System.Drawing.Font('Calibri',12,[System.Drawing.FontStyle]::Bold)

    $Client_Lookup_Grid= New-Object system.Windows.Forms.DataGridView
    $Client_Lookup_Grid.AllowUserToAddRows=$false
    $Client_Lookup_Grid.width= 295
    $Client_Lookup_Grid.height= 244
    $Client_Lookup_Grid.ReadOnly= $True
    $Client_Lookup_Grid.ColumnHeadersVisible= $true
    $Client_Lookup_Grid.AutoGenerateColumns= $true;
    $Client_Lookup_Grid.AllowUserToAddRows=$false
    $Client_Lookup_Grid.location= New-Object System.Drawing.Point(5,120)


    #Gridview for Employee Lookup (Right most Grid)            
    $users_Lookup_Grid= New-Object system.Windows.Forms.DataGridView
    $users_Lookup_Grid.AllowUserToAddRows=$false
    $users_Lookup_Grid.width= 264
    $users_Lookup_Grid.height= 244
    $users_Lookup_Grid.ReadOnly= $True
    $users_Lookup_Grid.ColumnHeadersVisible= $true
    $users_Lookup_Grid.AutoGenerateColumns= $true;
    $users_Lookup_Grid.AllowUserToAddRows=$false

    foreach ($row in $users_Lookup_GridData){
                    $users_Lookup_Grid.Rows.Add($row)
    }
    $users_Lookup_Grid.location= New-Object System.Drawing.Point(340,120)
 
 
    #Filter drop box for employee Name/EmpID
    $Employee_Selection_Filter= New-Object system.Windows.Forms.ComboBox
    $Employee_Selection_Filter.text= "Name"
    #$Employee_Selection_Filter.Dropdownstyle = 'DropDownList'
    $Employee_Selection_Filter.width= 100
    $Employee_Selection_Filter.height= 20 
    $Employee_Selection_Filter.location= New-Object System.Drawing.Point(350,60)
    $Employee_Selection_Filter.Font= 'Calibri,10'
    #Employee Filter Array - Add to the array then call the string in the if-Elseif statement listed in the Employee Lookup Module
    @('Name','Employee ID') | ForEach-Object {[void] $Employee_Selection_Filter.Items.Add($_)}
    $Employee_Selection_Filter.SelectedIndex= 0
 
 
    #Employee Lookup Label in Black.
    $Employee_Lookup_label= New-Object system.Windows.Forms.Label
    $Employee_Lookup_label.text= "Employee LookUp"
    $Employee_Lookup_label.AutoSize= $true
    $Employee_Lookup_label.width= 25
    $Employee_Lookup_label.height= 10
    $Employee_Lookup_label.backcolor= [System.Drawing.Color]::FromName("Transparent")
    $Employee_Lookup_label.location= New-Object System.Drawing.Point(455,40)
    $Employee_Lookup_label.forecolor= "White"
    $Employee_Lookup_label.font= New-Object System.Drawing.Font('Calibri',12,[System.Drawing.FontStyle]::Bold)
 
    #Employee Look up text box and enter key logic to pass thro$Script_Duplicateugh to the module referedabove
$Lookup = {
    if ($_.KeyCode-eq "Enter") {
                #If statement: pulls the array values for the filter
                $_.SuppressKeyPress= $true
                <#EmployeeID#>
                if($Employee_Selection_Filter.SelectedIndex -eq 1){
                                $hold = updateData -Employee_Lookup_Value $Employee_Lookup_TextBox.Text
                                $users_Lookup_Grid.datasource= $hold.Tables[0]
                                $users_Lookup_Grid.Update()
                                                               
                <#FullName#>
                }
                Elseif($Employee_Selection_Filter.SelectedIndex -eq 0){
                    <#Normal Pass through with cn#>
                    #counts the number of values
                    $Search = "*"+$Script:Employee_Lookup_TextBox.text + "*"
                    $Employee_Selection_Filter.SelectedIndex= 0
                    $Script_Duplicate= get-ADUser -server $Server -filter {(cn -like $Search) -or (sn -like $Search) -or (givenName -like $Search) -or (SAMAccountName -like $Search) } -properties cn, EmployeeID, Title, Department, Manager | Select cn, EmployeeID, Title, Department, Manager
                    $Script_Duplicate_Measure= $Script_Duplicate| measure
                                                 
                    Start-Logging $Script_Duplicate_Measure
                    if($Script_Duplicate_Measure.count -gt 1){
                                    Add-Type -AssemblyName System.Windows.Forms
                                    [System.Windows.Forms.Application]::EnableVisualStyles()
 
                                    $Duplicate_Form = New-Object system.Windows.Forms.Form
                                    $Duplicate_Form.ClientSize= '555,320'
                                    $Duplicate_Form.text= "Form"
                                    $Duplicate_Form.TopMost= $false
                                    $Duplicate_Form.BackgroundImage = $Image
                                    $Duplicate_Form.FormBorderStyle= "FixedDialog"                          
                                    $Duplicate_Form.text = "Proton - Duplicate Users Found!"
 
                                    $Duplicate_Employee_Value= New-Object system.Windows.Forms.DataGridView
                                    $Duplicate_Employee_Value.width  = 545
                                    $Duplicate_Employee_Value.height  = 282
                                    $Duplicate_Employee_Value.ReadOnly= $true
                                    $Duplicate_Employee_Value.MultiSelect= $false
                                    $Duplicate_Employee_Value.AllowUserToAddRows=$false
                                    $Duplicate_Employee_Value.location  = New-Object System.Drawing.Point(2,37)
 
                                    $Duplicate_Select_Button= New-Object system.Windows.Forms.Button
                                    $Duplicate_Select_Button.text= "Select"
                                    $Duplicate_Select_Button.width= 75
                                    $Duplicate_Select_Button.height= 20
                                    $Duplicate_Select_Button.location= New-Object System.Drawing.Point(468,15)
                                    $Duplicate_Select_Button.Font= 'Calibri,10'
                                    $Duplicate_Select_Button.Add_Click({
                                                    $Script:Employee_Lookup_TextBox.Text = $Duplicate_Employee_Value.CurrentRow.Cells[1].Value
                                                    
                                                                    #Checks if the account is enabled, assigns a global variable
                                                    #Pulls the full name of the assoicate, assigns as a global variable. Used for the message boxes that convert empIDto CN. 1
                                                    $global:Employee_Lookup_TextBox_Name= get-aduser -server $Server -Filter{EmployeeID -eq "$($Duplicate_Employee_Value.CurrentRow.Cells[1].Value)"} -Properties * | Select -ExpandProperty cn
                                                    if($Employee_Lookup_TextBox_Name_EnabledCheck -eq $False){
                                                                    #Disabled account message.Pullsthe account information anyways. Will no password reset or account unlock.
                                                                    [System.Windows.Forms.MessageBox]::Show($Employee_Lookup_TextBox_Name + " Is currently Disabled. Unable to make changes to the account.","AccountLookup Reset","Ok")
                                                                    $hold = updateData -Employee_Lookup_Value  $Script:Employee_Lookup_Textbox.text
                                                                    $users_Lookup_Grid.datasource= $hold.Tables[0]
                                                                    $users_Lookup_Grid.Update()
                                                    }Else{
                                                                    #Updates the gridviewwhen you hit enter.
                                                                    $hold = updateData -Employee_Lookup_Value  $Script:Employee_Lookup_Textbox.text
                                                                    $users_Lookup_Grid.datasource= $hold.Tables[0]
                                                                    $users_Lookup_Grid.Update()
                                                    }
                                                    $Duplicate_Form.Close()
                                    })
                                                    #Label above the Duplicate users gridview.
                                    $Store_Duplicate_Label= New-Object system.Windows.Forms.Label
                                    $Store_Duplicate_Label.text= "Select the a user"
                                    $Store_Duplicate_Label.AutoSize  = $true
                                    $Store_Duplicate_Label.width= 25
                                    $Store_Duplicate_Label.height= 10
                                    $Store_Duplicate_Label.location= New-Object System.Drawing.Point(6,18)
                                    $Store_Duplicate_Label.forecolor= "White"               
                                    $Store_Duplicate_Label.backcolor= [System.Drawing.Color]::FromName("Transparent")
                                    $Store_Duplicate_Label.Font= $Store_Duplicate_Label.Font= 'Microsoft Sans Serif,10,style=Bold'
                                    $Duplicate_Form.controls.AddRange(@($Duplicate_Employee_Value,$Duplicate_Select_Button,$Store_Duplicate_Label))
                                    Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Exporting Data - $Script:Employee_Lookup_TextBox`""
                                                                                  
                                    # Duplicate GridviewMain Columns
                                    $Duplicate_GridDataTable= New-Object System.Data.DataTable
                                    #Column A
                                    $Duplicate_GridDataTable.Columns.Add('Name', [string]) | Out-Null
                                    #Column B
                                    $Duplicate_GridDataTable.Columns.Add('EmployeeID', [string]) | Out-Null
                                    #Column C
                                    $Duplicate_GridDataTable.Columns.Add('Title', [string]) | Out-Null
                                    #Column D
                                    $Duplicate_GridDataTable.Columns.Add('Department', [string]) | Out-Null
                                    #Column E
                                    $Duplicate_GridDataTable.Columns.Add('Manager', [string]) | Out-Null
 
                                    #Passes the table as a dataset. Returns the data set. This is what processes the datagridview.
                                    $Duplicate_ds= New-Object System.Data.DataSet
                                    $Duplicate_ds.Tables.Add($Duplicate_GridDataTable)
                                    Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - updateData: `"Stop - $Script:Employee_Lookup_TextBox`""
                                                               
                                    ForEach($possibleEmployee in $Script_Duplicate){
                                                    #Passes the column sets as horizontal. Passes value for Multiple Users using the For loop
                                                    $Name = $possibleEmployee| Select -ExpandProperty cn
                                                    $EmployeeID= $possibleEmployee| Select -ExpandProperty EmployeeID
                                                    $Title = $possibleEmployee| Select -ExpandProperty Title
                                                    $Department=  $possibleEmployee| Select -ExpandProperty Department
                                                    $Manager= $possibleEmployee| Select @{N='Manager';E={(Get-ADUser $_.Manager).Name}}
                                                    $Manager = $Manager.Manager
                                                    $Duplicate_ds.Tables[0].Rows.Add($Name, $EmployeeID, $Title, $Department, $Manager) | Out-Null
                                    }
                                                               
                                    $Duplicate_Employee_Value.DataSource= $Duplicate_ds.Tables[0]
 
                                    $Duplicate_Form.ShowDialog()
                    }
                    elseif($Script_Duplicate_Measure.count -eq 1){                                  
                                    
                                    write-Host "$($Employee_Lookup_TextBox.Text)"
                                    
                                    #Checks if the account is enabled, assigns a global variable                                                           
                                    #Pulls the full name of the assoicate, assigns as a global variable. Used for the message boxes that convert empIDto CN. 1
                                    $Employee_Lookup_TextBox_Exact_Name = get-aduser -server $Server -Filter {CN -eq $Employee_Lookup_TextBox.Text} -Properties EmployeeID | Select -ExpandProperty EmployeeID
                                    $Script:Employee_Lookup_TextBox.Text = $Employee_Lookup_TextBox_Exact_Name
                                    $global:Employee_Lookup_TextBox_Name = get-aduser -server $Server -Filter {EmployeeID -eq $Employee_Lookup_TextBox_Exact_Name} -Properties EmployeeID | Select -ExpandProperty EmployeeID
                                    write-Host $global:Employee_Lookup_TextBox_Name
                                    if($Employee_Lookup_TextBox_Name_EnabledCheck -eq $False){
                                                    $hold = updateData -Employee_Lookup_Value  $global:Employee_Lookup_TextBox_Name
                                                    $users_Lookup_Grid.datasource= $hold.Tables[0]
                                                    $users_Lookup_Grid.Update()
                                    }Else{
                                                    #Updates the gridviewwhen you hit enter.
                                                    $hold = updateData -Employee_Lookup_Value  $Employee_Lookup_Textbox.text
                                                    $users_Lookup_Grid.datasource= $hold.Tables[0]
                                                    $users_Lookup_Grid.Update()
                                    }
                    }
                    else{
                                    [System.Windows.Forms.MessageBox]::Show("Invalid Employee, please retry your action.", 'Employee Look Up','Ok',"Error")
                    }
    }
}
}
    $Script:Employee_Lookup_TextBox= New-Object system.Windows.Forms.TextBox
    $Script:Employee_Lookup_TextBox.multiline= $false
    $Script:Employee_Lookup_TextBox.width= 146
    $Script:Employee_Lookup_TextBox.height= 20
    $Script:Employee_Lookup_TextBox.location= New-Object System.Drawing.Point(454,60)
    $Script:Employee_Lookup_TextBox.Font= 'Microsoft Sans Serif,10'
    $Script:Employee_Lookup_TextBox.Add_KeyDown($Lookup)
 
    #Script that displays the Account Unlock button, and run checks for if the account is disabled.
    $AD_Account_Unlock= New-Object system.Windows.Forms.Button
    $AD_Account_Unlock.text= "Unlock"
    $AD_Account_Unlock.width= 100
    $AD_Account_Unlock.height= 26
    $AD_Account_Unlock.location= New-Object System.Drawing.Point(400,90)
    $AD_Account_Unlock.Font= 'Calibri,10'
    $AD_Account_Unlock.Add_Click({      
    
    $global:Employee_Lookup_TextBox_Name_EnabledCheck=  get-aduser -server $Script:Server -Filter{EmployeeID -eq $Employee_Lookup_TextBox.Text} -Properties * | Select -ExpandProperty enabled
                if($Employee_Lookup_TextBox.text -eq $Null -or $Employee_Lookup_TextBox.text -eq " " ){
                    [System.Windows.Forms.MessageBox]::Show("Error: Employee ID Field is empty! Please provide a user account!","AccountUnlock","Ok","Error")
                }Else{     
                    $Global:GetSAM_FullName= get-aduser -server $Script:Server -Filter{EmployeeID -eq $Employee_Lookup_TextBox.Text} -Properties * | Select -ExpandProperty cn
                    #Checks to see if the account is enabled or disabled.If disabled message box stating so will popupand nothing else will activate.
                    if($global:Employee_Lookup_TextBox_Name_EnabledCheck -eq $False){
                                    [System.Windows.Forms.MessageBox]::Show($Global:GetSAM_FullName+ " Is currently Disabled, Unable to unlock the account!","AccountUnlock","Ok","Error")
                    }Else{
                                    #Unlocks the account if Yes is selected. If no is selected the statement else statement will launch.
                                    if ([System.Windows.Forms.MessageBox]::Show("Are you sure you wish to unlock "+ $Global:GetSAM_FullName,"Account Unlock","YesNo") -eq [System.Windows.Forms.DialogResult]::Yes){
                                                    Start-Logging "Unlocked"           
                                                    $GetSAM= get-aduser -server $Script:Server -Filter{EmployeeID -eq $Employee_Lookup_TextBox.Text} -Properties * | Select -ExpandProperty SAMAccountName
                                                    Unlock-ADAccount -Identity $GetSAM
                                                    [System.Windows.Forms.MessageBox]::Show($Global:GetSAM_FullName+' has been unlocked', 'Account Unlock','Ok')  
                                    }else{
                                                    Start-Logging "locked"           
                                                    [System.Windows.Forms.MessageBox]::Show($Global:GetSAM_FullName  +' has been skipped', 'Account Unlock','Ok')
                                    }
                    }
    }
    })
    #Password Reset button and logic
    $AD_Account_Password_Reset= New-Object system.Windows.Forms.Button
    $AD_Account_Password_Reset.text= "Password Reset"
    $AD_Account_Password_Reset.width= 100
    $AD_Account_Password_Reset.height= 26
    $AD_Account_Password_Reset.location= New-Object System.Drawing.Point(500,90)
    $AD_Account_Password_Reset.Font= 'Calibri,10'
    #Password Reset Logic
    $AD_Account_Password_Reset.Add_Click({
                    $Employee_Lookup_TextBox_Name= get-aduser -server $Script:Server -Filter {EmployeeID -eq $Employee_Lookup_TextBox.Text} -Properties * | Select -ExpandProperty cn
                    #checks to see if the account is disabled. No action will occur other than the messagebox.
                    $Employee_Lookup_TextBox_Name_EnabledCheck=  get-aduser -server $Script:Server -Filter{EmployeeID -eq $Employee_Lookup_TextBox.Text} -Properties * | Select -ExpandProperty enabled       
 
                    if($Employee_Lookup_TextBox_Name_EnabledCheck -eq $False){
                                    [System.Windows.Forms.MessageBox]::Show($Employee_Lookup_TextBox_Name + " Is currently Disabled. Unable to reset the password.","AccountPassword Reset","Ok","Error")
 
                    }Else{
 
                                    #Message box requesting confirmation for whom you are resetting the account for. If Yes, it will ask for the new password and confirm in plain text. If no it will state "User has been skipped".
                                               
                                    if ([System.Windows.Forms.MessageBox]::Show("Are you sure you wish to Reset the password for: "+ $Employee_Lookup_TextBox_Name,"AccountPassword Reset","YesNo") -eq [System.Windows.Forms.DialogResult]::Yes){
                                        $newPass= [Microsoft.VisualBasic.Interaction]::InputBox('Enter Password ', 'Password Reset')
                                        #Tests to see if the string for the new password is Null or Empty. If True it will throw an error and cancel the operation.
                                                    if ([string]::IsNullOrEmpty($newPass)){               
                                                                    [System.Windows.Forms.MessageBox]::Show("Unable to reset the password for:"+ $Employee_Lookup_TextBox_Name+ " , New password field is empty!","AccountPassword Reset","Ok","Error")
                                                                    #continues the operation, asking to force the password to be reset upon login, and confirmed the new password.
                                                    }else{
                                                               
                                                    $GetSAM= get-aduser -server $Script:Server -Filter{EmployeeID -eq $Employee_Lookup_TextBox.Text} -Properties * | Select -ExpandProperty SAMAccountName
                                                    Start-Logging "Unlocked $GetSAM"
                                                    Set-ADAccountPassword -Identity $GetSAM-Reset -NewPassword(ConvertTo-SecureString -AsPlainText"$newPass" -Force)
                                                    if([System.Windows.Forms.MessageBox]::Show("Would you like to force a password reset when the user logs in?", 'Account Password Reset','YesNo') -eq [System.Windows.Forms.DialogResult]::Yes){
                                                    Set-aduser $GetSAM -changepasswordatlogon $true
                                                    [System.Windows.Forms.MessageBox]::Show("Password has been reset to " + $newPass, 'Account Password Reset','Ok')
                                                    }else{
                                                    [System.Windows.Forms.MessageBox]::Show("They will not be prompted to change their password. Password has been changed to: " + $newPass, 'Account Password Reset','Ok')
                                                    } 
                                        }          
                                    }else{
                                                    Start-Logging "Skipped $GetSAM"
                                                    #Exit for the if function that returns you to the main form.
                                                    $GetSAM_No= get-aduser -server $Script:Server -Filter{EmployeeID -eq $Employee_Lookup_TextBox.Text} -Properties * | Select -ExpandProperty cn
                                                    [System.Windows.Forms.MessageBox]::Show($GetSAM_no  +' has been skipped', 'Account Password Reset','Ok')
                                    }
                    }
    })
                                                                                                                 
    #Load form variables to show all functions, set as an array; if you create/add a variable that needs to be visiableto the form (i.etextboxes, buttons, comboboxes, labels, etc) please add that variable to this list to show it.
$Form.controls.AddRange(@($AD_Account_Unlock,$AD_Account_Password_Reset,$Client_Lookup_Label,$Client_Lookup_Textbox,$Client_Lookup_Grid,$Duplicate_GridDataTable,$Script_Duplicate,$Duplicate_Select_Button,$Duplicate_Employee_Value,$Employee_Selection_Filter,$Global:Employee_Lookup_Valueform,$users_Lookup_Grid,$Employee_Lookup_TextBox,$Employee_Lookup_label))
    #Sets the form border style.
    $Form.FormBorderStyle= 'Fixed3D'
    #disables the main form to be resized. This prevents scaling issues.
    $Form.MaximizeBox= $false
    #Console log that pulls the date and time when the applicaitonis launch and gives statuses on the DHCP import. Only way to view this besides PowershellISE or Powershellapp. is through the transcript logs.
    If($Global:storeConfig.Settings.ServerSettings.Mode-eq 'Single'){
                    Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - Proton Core: `"Warn user of wait time`""
                    [System.Windows.Forms.MessageBox]::Show("Please wait for DHCP loading to complete. `nThemain form will show up shortly.", "Please Wait...","OK","Information")
                    While($Global:data.IsCompleted-ne $true){}
                    Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - Get-DHCPLIST: `"Closing and Disposing DHCP Job`""
                    $Global:command.EndInvoke($Global:data)
                    $Global:command.Dispose()
    }
    Start-Logging $syncHash.Bug
 
    Start-Logging "INFO: $(Get-Date -UFormat "%Y-%m-%d %r") - Proton Core: `"Opening Form`""
    #Launches the form.
                
    $form.ShowDialog()
}
Open-GUI