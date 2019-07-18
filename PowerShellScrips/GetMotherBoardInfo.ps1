#  Get MotherBoard Information
Write "******************************************************************"
Write "Get MotherBoard Information"
Write "******************************************************************"
$name = (Get-Item env:\Computername).Value
Get-WmiObject -ComputerName $name  Win32_BaseBoard  |  Select Name,Manufacturer,Product,SerialNumber,Status