<#

_____________________________ WORK IN PROGRESS_______________________________________________
Change Log: 
08/30/2021 - AW
08/31/2021 - AW


#>

#passes Dell service tag into AD and spits out the CN of the hostname to be used in various scripts. 
#"hklm:\HARDWARE\"
$computerSystem = Read-Host "Please enter the Dell service tag"
$computerSystem = "*"+$computerSystem
$ADMachineName = Get-ADComputer -filter {name -LIKE $computerSystem} | Select -expandproperty Name

function remove-RemoteKey{
<#
$regkey: HKLM\Hardware\Description\System
$regname: Identifier


This will delete  HKLM\Hardware\Description\System\Identifier.
#>
Param
    (
     [String][Parameter(Mandatory=$True, Position=0)]$Regkey,
     [String][Parameter(Mandatory=$True, Position=1)]$Keyname
     
    )


$Testpath = Invoke-Command -ComputerName $ADMachineName -ScriptBlock {Test-Path -Path $regkey} 
    If($Testpath){
       $Confirm = Write-Host "Proceed with removing: $($Regkey)?" -confirm
        $Confirm
        if($Confirm){

    #Invoke-Command -ComputerName $ADMachineName -ScriptBlock {remove-ItemProperty -Path $regkey -Name $Keyname -Confirm:$false} 
    }}else{
    
    }
    }


function Get-RemoteKey{
Param
    (
     [String][Parameter(Mandatory=$True, Position=0)]$Regkey,
     [String][Parameter(Mandatory=$True, Position=1)]$Keyname

    )
    If($Regkey){}
Invoke-Command -ComputerName $ADMachineName -ScriptBlock {Get-ItemProperty -Path $regkey -Name $Keyname -Confirm:$false}
}


Function Add-RemoteKey
{
    Param
    (
     [String][Parameter(Mandatory=$True, Position=0)]$Regkey,
     [String][Parameter(Mandatory=$True, Position=1)]$Keyname,
     [String][Parameter(Mandatory=$True, Position=2)]$keyvalue
    )
    $Testpath = Test-Path $Regkey
    If($Testpath){
        Write-Host "Error: Key already Exists" -fore Red
    }else{
        Invoke-Command -ComputerName $ADMachineName -ScriptBlock { New-ItemProperty -Path $Regkey -Name $KeyName -Value $Keyvalue}
    }
}

function Add-KeyValue{
<#Input values as below example: 
$regkey: HKLM\Hardware\Description\System
$regname: Identifier
$keyvalue: AT/AT Compatible

This will change HKLM\Hardware\Description\System\Identifier to whatever value you want it to be.
#> Param
    (
     [String][Parameter(Mandatory=$True, Position=0)]$Regkey,
     [String][Parameter(Mandatory=$True, Position=1)]$Keyname,
     [String][Parameter(Mandatory=$True, Position=2)]$keyvalue
    )
    $Testpath = Test-Path $Regkey
    If($Testpath){
      Invoke-Command -ComputerName $ADMachineName -ScriptBlock { Set-temProperty -Path $Regkey -Name $KeyName -Value $Keyvalue}
    }else{
        Write-host "Error: Test path does not exist"

}
}