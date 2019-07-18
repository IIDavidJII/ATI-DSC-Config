# Show Current Roles And Features Installed
Write "******************************************************************"
Write "Show Current Roles And Features Installed"
Write "******************************************************************"
Get-WindowsFeature | where {$_.InstallState -eq "Installed"} | Select DisplayName, Name, InstallState