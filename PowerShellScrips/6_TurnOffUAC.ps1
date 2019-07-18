#Turn off UAC - Restart required
Write "******************************************************************"
Write "Turn off UAC"
Write "******************************************************************" 
Set-ItemProperty -Path HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -Value 0 -PassThru