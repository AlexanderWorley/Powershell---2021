@echo off
PowerShell.exe -Command "& {Start-Process PowerShell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Client\Printer\Add Remote Shared Printer\Script\Add_remote_Shared_Printer.ps1""' -Verb RunAs}"

exit