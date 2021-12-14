@echo off
PowerShell.exe -Command "& {Start-Process PowerShell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""\\cmhprdfps53\Data\HelpDesk\Powershell Automation\EUT\Client\Application-SCCM\SCCM\Collections\GetCollection\Script\Get_Collections.ps1""' -Verb RunAs}"
exit