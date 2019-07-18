#  Get Network Adapter Information
Write "******************************************************************"
Write "Get Network Adapter Information"
Write "******************************************************************"
$name = (Get-Item env:\Computername).Value
$filepath = (Get-ChildItem env:\userprofile).value
Get-WmiObject win32_networkadapter -ComputerName $name  | Select Name,Manufacturer,Description ,AdapterType,Speed,MACAddress,NetConnectionID