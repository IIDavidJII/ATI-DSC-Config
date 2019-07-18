#Check Aristocrat Software Installed
Write "******************************************************************"
Write "Check Aristocrat Software Installed (local)"
Write "******************************************************************"
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object $env:COMPUTERNAME ,DisplayName, DisplayVersion, InstallDate , Publisher| Where Publisher -Like 'Aristocrat*' 