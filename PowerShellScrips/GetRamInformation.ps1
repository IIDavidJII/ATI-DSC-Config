#  Ram Information
Write "******************************************************************"
Write "Ram Information"
Write "******************************************************************"
$name = (Get-Item env:\Computername).Value
Get-WmiObject Win32_PhysicalMemory -ComputerName $name  | select BankLabel,DeviceLocator,Capacity,Manufacturer,PartNumber,SerialNumber,Speed