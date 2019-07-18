#Shutoff all firewal by profile
Write "******************************************************************"
Write "Shutoff all firewal by profile"
Write "******************************************************************"
$command = "netsh advfirewall set allprofiles state off"
Invoke-WmiMethod -class Win32_process -name Create -ArgumentList ($cmd + $command)

Set-Service -Name "MpsSvc" -StartupType Disabled