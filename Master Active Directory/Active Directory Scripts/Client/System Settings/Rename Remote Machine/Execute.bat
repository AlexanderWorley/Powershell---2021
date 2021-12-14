@echo off
PowerShell.exe -Command "& {Start-Process PowerShell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""\\cmhprdfps53\Data\HelpDesk\Powershell Automation\EUT\Client\System Settings\Rename Remote Machine\Script\Rename_remote_Machine.ps1""' -Verb RunAs}"

exit