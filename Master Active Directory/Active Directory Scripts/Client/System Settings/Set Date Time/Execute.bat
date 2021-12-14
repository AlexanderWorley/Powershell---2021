@echo off
PowerShell.exe -Command "& {Start-Process PowerShell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""\\cmhprdfps53\Data\HelpDesk\Powershell Automation\EUT\Client\System Settings\Set Date Time\Script\Set_Date_Time.ps1""' -Verb RunAs}"

exit