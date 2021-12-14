#targets chrome cache folder and clears all contents. Allows for remote cache clear for managed windows assets.
#Run the script, script will prompt for any information needed. 
$Items = @('Archived History',
            'Cache\*',
            'Cookies',
            'History',
            'Login Data',
            'Top Sites',
            'Visited Links',
            'Web Data')
$user = read-host "Input the username of the user"
$machine = read-host "Input the windows machine hostname"
$Folder = "\\$machine\$user\appdata\local\Google\Chrome\User Data\Default"
$Items | % { 
    if (Test-Path "$Folder\$_") {
        Remove-Item "$Folder\$_" 
        write-host "Cleared cache complete please restart chrome and attempt again"
    }
}