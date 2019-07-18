#  Get Last Reboot Information
Write "******************************************************************"
Write "Get Last Reboot Information"
Write "******************************************************************"
 Get-CimInstance -ClassName win32_operatingsystem | select csname, lastbootuptime