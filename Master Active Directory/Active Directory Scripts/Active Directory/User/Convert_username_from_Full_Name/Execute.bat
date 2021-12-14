@echo off
PowerShell.exe -Command "& {Start-Process PowerShell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Active Directory\User\Convert_username_from_Full_Name\Script\AD-Fullname-To-Username.ps1""' -Verb RunAs}"

exit