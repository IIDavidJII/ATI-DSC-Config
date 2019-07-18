# Get MSDTC State
Write "******************************************************************"
Write "Get MSDTC State"
Write "******************************************************************"
$name = (Get-Item env:\Computername).Value
$filepath = (Get-ChildItem env:\userprofile).value
Get-ItemProperty -Path HKLM:\Software\Microsoft\MSDTC\Security | select Name, AccountName, DomainControllerState, LuTransactions, NetworkDtcAccess, NetworkDtcAccessAdmin,NetworkDtcAccessClients,NetworkDtcAccessInbound, NetworkDtcAccessOutbound,NetworkDtcAccessTransactions