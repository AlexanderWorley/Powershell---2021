$list = IMport-csv C:\Users\USERNAME\Desktop\USERS.csv
$Server= "SERVER NAME"
   $Users = Foreach($Object in $list)
    {
        Try{
        Get-ADuser -Identity $Object.SAMAccountname -server $Server -Properties * |Select-Object Displayname,Mail

        }
        Catch{

            Write-host $object.SAMAccountname Does not Exist -ForegroundColor Red

        }
    }

    $Users | Export-Csv -Path C:\Users\USERNAME\Desktop\USERS.csv
