@echo off
PowerShell.exe -Command "& {Start-Process PowerShell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""\\cmhprdfps53\Data\HelpDesk\Powershell Automation\ServiceDesk\Active Directory\User\Mirror AD Groups\Script\NewHireGroups.ps1""' -Verb RunAs}"

exit