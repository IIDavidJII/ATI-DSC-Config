# Get BIOS Information
Write "******************************************************************"
Write "Get BIOS Information"
Write "******************************************************************"
$name = (Get-Item env:\Computername).Value
$filepath = (Get-ChildItem env:\userprofile).value
 Get-WmiObject win32_bios -ComputerName $name  | Select Manufacturer,Name,BIOSVersion,ListOfLanguages,PrimaryBIOS,ReleaseDate,SMBIOSBIOSVersion,SMBIOSMajorVersion,SMBIOSMinorVersion