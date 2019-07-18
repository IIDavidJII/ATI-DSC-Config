# Hard-Disk Information
Write "******************************************************************"
Write "Hard-Disk Information"
Write "******************************************************************"
$name = (Get-Item env:\Computername).Value
Get-WmiObject win32_diskDrive -ComputerName $name  | select Model,SerialNumber,InterfaceType,Size,Partitions