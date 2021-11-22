@echo off
PowerShell.exe -Command "& {Start-Process PowerShell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""\\cmhprdfps53\Data\HelpDesk\Powershell Automation\EUT\Client\System Settings\Run Actions\Script\Remote_run_SCCM_Actions.ps1""' -Verb RunAs}"

exit