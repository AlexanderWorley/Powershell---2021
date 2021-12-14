function Run-ConfigMan{
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Proton_Config_Manager_Form      = New-Object system.Windows.Forms.Form
$Proton_Config_Manager_Form.ClientSize  = New-Object System.Drawing.Point(634,303)
$Proton_Config_Manager_Form.text  = "Configuration Manager"
$Proton_Config_Manager_Form.TopMost  = $false

$Proton_App_Deployement_Eval     = New-Object system.Windows.Forms.CheckBox
$Proton_App_Deployement_Eval.text  = "Application Deployment Evaluation Cycle"
$Proton_App_Deployement_Eval.AutoSize  = $false
$Proton_App_Deployement_Eval.width  = 280
$Proton_App_Deployement_Eval.height  = 31
$Proton_App_Deployement_Eval.location  = New-Object System.Drawing.Point(8,71)
$Proton_App_Deployement_Eval.Font  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Proton_Discovery_Data_Collection   = New-Object system.Windows.Forms.CheckBox
$Proton_Discovery_Data_Collection.text  = "Discovery Data Collection Cycle"
$Proton_Discovery_Data_Collection.AutoSize  = $false
$Proton_Discovery_Data_Collection.width  = 289
$Proton_Discovery_Data_Collection.height  = 30
$Proton_Discovery_Data_Collection.location  = New-Object System.Drawing.Point(8,100)
$Proton_Discovery_Data_Collection.Font  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Proton_File_Collection_Cycle    = New-Object system.Windows.Forms.CheckBox
$Proton_File_Collection_Cycle.text  = "File Collection Cycle"
$Proton_File_Collection_Cycle.AutoSize  = $false
$Proton_File_Collection_Cycle.width  = 260
$Proton_File_Collection_Cycle.height  = 37
$Proton_File_Collection_Cycle.location  = New-Object System.Drawing.Point(7,134)
$Proton_File_Collection_Cycle.Font  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Config_Target_TextBox           = New-Object system.Windows.Forms.TextBox
$Config_Target_TextBox.multiline  = $false
$Config_Target_TextBox.width     = 216
$Config_Target_TextBox.height    = 20
$Config_Target_TextBox.location  = New-Object System.Drawing.Point(8,14)
$Config_Target_TextBox.Font      = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Proton_Run_All_Button           = New-Object system.Windows.Forms.Button
$Proton_Run_All_Button.text      = "Run All"
$Proton_Run_All_Button.width     = 60
$Proton_Run_All_Button.height    = 30
$Proton_Run_All_Button.location  = New-Object System.Drawing.Point(4,267)
$Proton_Run_All_Button.Font      = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Config_Button_Target            = New-Object system.Windows.Forms.Button
$Config_Button_Target.text       = "Target"
$Config_Button_Target.width      = 60
$Config_Button_Target.height     = 30
$Config_Button_Target.location   = New-Object System.Drawing.Point(226,14)
$Config_Button_Target.Font       = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Proton_Run_Selected_Button      = New-Object system.Windows.Forms.Button
$Proton_Run_Selected_Button.text  = "Run Selected"
$Proton_Run_Selected_Button.width  = 102
$Proton_Run_Selected_Button.height  = 30
$Proton_Run_Selected_Button.location  = New-Object System.Drawing.Point(70,267)
$Proton_Run_Selected_Button.Font  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Proton_Hardware_Invententory_Cycle   = New-Object system.Windows.Forms.CheckBox
$Proton_Hardware_Invententory_Cycle.text  = "Hardware Invententory Cycle"
$Proton_Hardware_Invententory_Cycle.AutoSize  = $false
$Proton_Hardware_Invententory_Cycle.width  = 205
$Proton_Hardware_Invententory_Cycle.height  = 36
$Proton_Hardware_Invententory_Cycle.location  = New-Object System.Drawing.Point(8,168)
$Proton_Hardware_Invententory_Cycle.Font  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Machine_Policy_RE_Cycle         = New-Object system.Windows.Forms.CheckBox
$Machine_Policy_RE_Cycle.text    = "Machine Policy R&E Cycle"
$Machine_Policy_RE_Cycle.AutoSize  = $false
$Machine_Policy_RE_Cycle.width   = 285
$Machine_Policy_RE_Cycle.height  = 35
$Machine_Policy_RE_Cycle.location  = New-Object System.Drawing.Point(7,205)
$Machine_Policy_RE_Cycle.Font    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Proton_Software_inventory_Cycle   = New-Object system.Windows.Forms.CheckBox
$Proton_Software_inventory_Cycle.text  = "Software Inventory Cycle"
$Proton_Software_inventory_Cycle.AutoSize  = $false
$Proton_Software_inventory_Cycle.width  = 280
$Proton_Software_inventory_Cycle.height  = 27
$Proton_Software_inventory_Cycle.location  = New-Object System.Drawing.Point(342,100)
$Proton_Software_inventory_Cycle.Font  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Proton_Software_Metering        = New-Object system.Windows.Forms.CheckBox
$Proton_Software_Metering.text   = "Software Metering Usage"
$Proton_Software_Metering.AutoSize  = $false
$Proton_Software_Metering.width  = 276
$Proton_Software_Metering.height  = 28
$Proton_Software_Metering.location  = New-Object System.Drawing.Point(342,72)
$Proton_Software_Metering.Font   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Proton_Softwar_Update_Deployment   = New-Object system.Windows.Forms.CheckBox
$Proton_Softwar_Update_Deployment.text  = "Software Updates Deployment Evaluation"
$Proton_Softwar_Update_Deployment.AutoSize  = $false
$Proton_Softwar_Update_Deployment.width  = 303
$Proton_Softwar_Update_Deployment.height  = 25
$Proton_Softwar_Update_Deployment.location  = New-Object System.Drawing.Point(7,237)
$Proton_Softwar_Update_Deployment.Font  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Proton_Software_Update_Scan     = New-Object system.Windows.Forms.CheckBox
$Proton_Software_Update_Scan.text  = "Software Update Scan Cycle"
$Proton_Software_Update_Scan.AutoSize  = $false
$Proton_Software_Update_Scan.width  = 279
$Proton_Software_Update_Scan.height  = 27
$Proton_Software_Update_Scan.location  = New-Object System.Drawing.Point(342,133)
$Proton_Software_Update_Scan.Font  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Proton_User_policy              = New-Object system.Windows.Forms.CheckBox
$Proton_User_policy.text         = "User Policy R&E Cycle"
$Proton_User_policy.AutoSize     = $false
$Proton_User_policy.width        = 271
$Proton_User_policy.height       = 35
$Proton_User_policy.location     = New-Object System.Drawing.Point(342,170)
$Proton_User_policy.Font         = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Proton_Windows_Installer        = New-Object system.Windows.Forms.CheckBox
$Proton_Windows_Installer.text   = "Windows Installer Source List"
$Proton_Windows_Installer.AutoSize  = $false
$Proton_Windows_Installer.width  = 280
$Proton_Windows_Installer.height  = 40
$Proton_Windows_Installer.location  = New-Object System.Drawing.Point(342,206)
$Proton_Windows_Installer.Font   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Proton_Config_Manager_Form.controls.AddRange(@($Proton_App_Deployement_Eval,$Proton_Discovery_Data_Collection,$Proton_File_Collection_Cycle,$Config_Target_TextBox,$Proton_Run_All_Button,$Config_Button_Target,$Proton_Run_Selected_Button,$Proton_Hardware_Invententory_Cycle,$Machine_Policy_RE_Cycle,$Proton_Software_inventory_Cycle,$Proton_Software_Metering,$Proton_Softwar_Update_Deployment,$Proton_Software_Update_Scan,$Proton_User_policy,$Proton_Windows_Installer))

$Proton_Config_Manager_Form.ShowDialog()
}