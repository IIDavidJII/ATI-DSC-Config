# Processor Information
Write "******************************************************************"
Write "Processor Information"
Write "******************************************************************"
$name = (Get-Item env:\Computername).Value
Get-WmiObject Win32_Processor -ComputerName $name  | Select Name,Manufacturer,Caption,DeviceID,CurrentClockSpeed,CurrentVoltage,DataWidth,L2CacheSize,L3CacheSize,NumberOfCores,NumberOfLogicalProcessors,Status