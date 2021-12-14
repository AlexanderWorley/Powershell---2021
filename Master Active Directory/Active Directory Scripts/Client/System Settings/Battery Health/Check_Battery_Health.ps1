Function Get-BatteryReport
{
Param
(
    [string][Parameter(Mandatory=$true,position=0)]$ComputerName
)

    $ComputerTest = Test-Connection $ComputerName

    If($ComputerTest)
    {
        Invoke-Command -ComputerName $ComputerName -ScriptBlock{powercfg /batteryreport /output "C:\Temp\battery-report.html"} | Out-Null

        $ReportPath = "\\$ComputerName\C$\Temp\battery-report.html"
        If($ComputerName -eq $env:COMPUTERNAME)
        {
            $ReportPath = "C:\Temp\battery-report.html"
        }

        $testPath = Test-Path $ReportPath
        If($testPath)
        {
            $html = New-Object -ComObject "HTMLFile"
            $html.IHTMLDocument2_write($(get-content $ReportPath -raw))
            $FullList = ($html.all.tags('td') | % innertext)[0..27]
            $list = $FullList[24..27]
            $ActualCapacity = ((($list[3] -replace '\W','') -replace ".{3}$")/(($list[1] -replace '\W','') -replace ".{3}$")).ToString("P")
            Return $ActualCapacity
        }
    }
    else
    {
        Write-Host "This computer is not currently online or is unreachable."
    }


}