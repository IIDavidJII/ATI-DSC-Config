#Settings atiservice as local admin
Write "******************************************************************"
Write "Setting atiservice as a local admin"
Write "******************************************************************"
$DomainUser = "atiservice"
$LocalGroup = "Administrators"
$Computer = (Get-WmiObject Win32_ComputerSystem).Name
$Domain = (Get-WmiObject Win32_ComputerSystem).Domain

try{
    ([ADSI]"WinNT://$Computer/$LocalGroup,group").psbase.Invoke("Add",([ADSI]"WinNT://$Domain/$DomainUser").path) 
    Write "$DomainUser is now a member of $LocalGroup."
    }
 catch 
 {
 Write "$DomainUser is already a member of $LocalGroup."
 }     