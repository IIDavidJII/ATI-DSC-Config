#Update the MSDT Security Settings
Write "******************************************************************"
Write "Update MSDT Local security settings"
Write "******************************************************************"
Set-DtcNetworkSetting -AuthenticationLevel NoAuth -InboundTransactionsEnabled $true -OutboundTransactionsEnabled $true -RemoteClientAccessEnabled $true -RemoteAdministrationAccessEnabled $true  -XATransactionsEnabled $true -LUTransactionsEnabled $true -Confirm:$false
Get-DtcNetworkSetting -DtcName "Local"

#Re-Install MSDT
Write "******************************************************************"
Write "Re-Installing MSDT"
Write "******************************************************************"
if( ([string](Get-WmiObject -Class Win32_service -Filter "Name='msdtc'").State).equals('Running'))
    {Stop-Service -Name msdtc -PassThru}
Else
    {Write 'MSDT Service already stopped/uninstalled'}
Uninstall-DTC
Start-Sleep -s 2
if(Get-WmiObject -Class Win32_service -Filter "Name='msdtc'")
    {Write "MSDT service still exists after uninstall."}
Else
    {Write "MSDT Service successfully uninstalled."}
Install-DTC
Start-Sleep -s 2
if(Get-WmiObject -Class Win32_service -Filter "Name='msdtc'")
    {Write "MSDT Service successfully installed"}
Else
    {Write "MSDT Service did not install properly"}
Start-Sleep -s 2
Start-Service -Name msdtc -PassThru