@echo off
PowerShell.exe -Command "& {Start-Process PowerShell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""\\cmhprdfps53\data\HelpDesk\Powershell Automation\EUT\Browser\Chrome\Clear_Cache_Restart_Chrome\Script\Remote_Chrome_cache.ps1""' -Verb RunAs}"

exit