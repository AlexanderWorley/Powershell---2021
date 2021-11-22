Function Get-AccountLockoutStatus {
[CmdletBinding()]
    param(
        [Parameter(
            ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true,Position=0)]
 
        [string[]]$DomainController = (Get-ADDomainController -Filter * |  select -ExpandProperty Name),
        [Parameter()][int]$DaysFromToday = 3,
        [Parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true,Position=0,Mandatory)]$Username
    )
 
 
    BEGIN {
        $Object = @()
    }
 
    PROCESS {
        Foreach ($Computer in $DomainController) {
            try {
                $EventID = Get-WinEvent -ComputerName $Computer -FilterHashtable @{Logname = 'Security'; ID = 4740; StartTime = (Get-Date).AddDays(-$DaysFromToday)} -EA 0
                Foreach ($Event in $EventID) {
                    $Properties = @{Computername   = $Computer
                                    Time           = $Event.TimeCreated
                                    Username       = $Event.Properties.value[0]
                                    CallerComputer = $Event.Properties.value[1]
                                    }
                    $Object += New-Object -TypeName PSObject -Property $Properties | Select ComputerName, Username, Time, CallerComputer
                }
 
            } catch {
                $ErrorMessage = $Computer + " Error: " + $_.Exception.Message
                    
            } finally {
                if ($Username) {
                        Write-Output $Object | Where-Object {$_.Username -eq $Username}
                    } else {
                        Write-Output $Object
                }
                $Object = $null
            }
 
        }
             
    }     
 
 
    END {}
 
}Get-AccountLockoutStatus