Add-Type -AssemblyName System.Windows.Forms
$form=New-Object System.Windows.Forms.Form
$form.StartPosition='CenterScreen'
$form.Size='600,800'


$okButton = New-Object System.Windows.Forms.Button
$form.Controls.Add($okButton)
$okButton.Dock = 'Top'
$okButton.Height = 80
$okButton.Font = New-Object System.Drawing.Font("Times New Roman", 18, [System.Drawing.FontStyle]::Bold)
$okButton.Text = 'Ok'
$okButton.DialogResult = 'Ok'

$checkedlistbox=New-Object System.Windows.Forms.CheckedListBox
$form.Controls.Add($checkedlistbox)
$checkedlistbox.Dock='Fill'
$checkedlistbox.CheckOnClick=$true

$items= @("Discovery Data Collection Cycle","File Collection Cycle","Hardware Invententory Cycle")
$checkedlistbox.DataSource= $items
$checkedlistbox.DisplayMember='Caption'

$form.ShowDialog()

# display items checked
$checkedlistbox.CheckedItems