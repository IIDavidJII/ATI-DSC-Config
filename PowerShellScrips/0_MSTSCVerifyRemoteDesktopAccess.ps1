#Enable Remote Connections if they are not already enabled
Write "******************************************************************"
Write "Enable Remote Connections if they are not already enabled"
Write "******************************************************************"
If ( (Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections").fdenytsconnections -ne 0)
{Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0 -PassThru}
Else
{Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections"}