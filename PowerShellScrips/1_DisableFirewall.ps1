# Turn off advanced firewall profiles. Then disable service and stop service.
Write "******************************************************************"
Write "Firewall Settings"
Write "******************************************************************"
IF( (Get-NetFirewallProfile -Profile Domain -erroraction 'silentlycontinue').Enabled -EQ "true" -OR (Get-NetFirewallProfile -Profile Public -erroraction 'silentlycontinue').Enabled -EQ "true" -OR (Get-NetFirewallProfile -Profile Private -erroraction 'silentlycontinue').Enabled -EQ "true") 
{Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
WRITE "Disabling Firewall Profiles"}
ELSE
{WRITE "Firewall Profiles Already Disabled"}
Set-Service -Name "MpsSvc" -StartupType Disabled -PassThru
Get-Service -Name "MpsSvc" | where {$_.Status -eq 'running'} | Stop-Service -PassThru
get-wmiobject win32_service -filter "name='MpsSvc'"