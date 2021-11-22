@echo off
cls
@pushd %~dp0
PowerShell.exe -Command "& {Start-Process PowerShell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""\\cmhprdfps53\data\HelpDesk\Powershell Automation\ServiceDesk\Client\Windows Credentials\Script\OneDrive_Cred_clear.ps1""' -Verb RunAs}"

exit