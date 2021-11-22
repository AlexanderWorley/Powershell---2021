@echo off
PowerShell.exe -Command "& {Start-Process PowerShell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Client\System Settings\TPM_Bitlocker Validation\Script\TPM_BItlocker_Validation_Remote.ps1""' -Verb RunAs}"

exit