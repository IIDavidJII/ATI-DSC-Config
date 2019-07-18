# Get System Information
Write "******************************************************************"
Write "Get System Information"
Write "******************************************************************"
$name = (Get-Item env:\Computername).Value
$filepath = (Get-ChildItem env:\userprofile).value
Get-WmiObject Win32_ComputerSystemProduct -ComputerName $name  | Select Vendor,Version,Name,IdentifyingNumber,UUID