Function Invoke()
{

    $Password = Read-Host "Enter Admin Password: " -AsSecureString
    $global:Creds = new-object -typename System.Management.Automation.PSCredential -argumentlist "\$env:Username", $password
}

Function Get-UserStatus()
{
    Param(
        [parameter(Mandatory = $true)]
        [string]$Username,
        [parameter(Mandatory = $true)]
        [string]$DC
    )

    $user = get-aduser -filter { samAccountName -eq $Username } -Server $DC -Credential $global:Creds -Properties * | Select-Object @{Name="BadPasswordTime";Expression={([datetime]::FromFileTime($_.badpasswordtime))}},badpwdCount,@{Name="LockoutTime";Expression={([datetime]::FromFileTime($_.lockoutTime))}},passwordLastSet
    $user | Add-Member -MemberType ScriptProperty -Name "LockedOut" -Value {if ($this.badpwdCount -gt 0) {$true} else {$false}} -Force

    return $user
}


$Server= "SERVER NAME/IP ADDRESS"
$username = Read-Host "Enter the username of the User"
$Domain = "DOMAIN NAME"

$DClist = Get-ADForest -Server $Server -Credential $Global:Creds | Select-object -ExpandProperty globalcatalogs | %{$_ | where-object {$_ -like "*$Domain*"} }
$LockedArray = New-Object System.Collections.ArrayList

foreach ($DC in $DClist)
{

    $user = $null

    Try
    {
        $user = Get-UserStatus -Username $username -DC $DC

        [void]$LockedArray.Add(([PSCustomobject]@{ 'DC' = $DC; 'Username' = $username; 'Bad PW Count' = $user.badpwdCount; 'Previous Status (Locked Out)' = ''; 'Current Status (Locked Out)' = $user.lockedout }))
    }
    Catch
    {
        [void]$LockedArray.Add(([PSCustomobject]@{ 'DC' = $DC; 'Username' = $username; 'Bad PW Count' = $user.badpwdCount; 'Previous Status (Locked Out)' = ''; 'Current Status (Locked Out)' = $null }))
    }

    $UnlockRequired = $LockedArray | ? {$_."CUrrent Status (Locked Out)" -eq $true}
}

if ($UnlockRequired.Count -ne 0)
{
    $UnlockRequired | ft

    Write-Host "Do you want to unlock the domain controllers listed above? " -ForegroundColor Cyan -NoNewline
    switch (Read-Host)
    {
        {$_ -like "Yes" -or $_ -like "Y"} {
            $UnlockRequired | % {
                $_."Previous Status (Locked Out)" = $_."Current Status (Locked Out)";
                Unlock-ADAccount -Server $_.DC -Identity $_.Username -Credential $global:Creds;

                $user = Get-UserStatus -Username $_.Username -DC $_.DC
                $_."Current Status (Locked Out)" = $user.LockedOut
            }

            $lockedArray | ft
        }
        default {Write-Host "Ignoring DCs" -ForegroundColor Yellow}
    }
}
else
{
    Write-Host "User '$username' is not locked on any domain controllers" -ForegroundColor Green
}
