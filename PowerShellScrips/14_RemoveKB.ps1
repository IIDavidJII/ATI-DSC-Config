#Remove KBs
Write "******************************************************************"
Write "Check the list of KB and remove them all"
Write "******************************************************************"
Get-Hotfix KB2500170,
 KB3102467, KB3134815, 
 KB3150513, KB3151864, 
 KB3172614, KB3179574, 
 KB3186539, KB4019215, 
 KB4033989, KB4033997, 
 KB4338605, KB4338613  | Select Description, HotFixID, InstalledBY, InstalledOn 

wusa.exe /uninstall /kb:KB2500170 /norestart /quiet
wusa.exe /uninstall /kb:KB3102467 /norestart /quiet
wusa.exe /uninstall /kb:KB3134815 /norestart /quiet
wusa.exe /uninstall /kb:KB3150513 /norestart /quiet
wusa.exe /uninstall /kb:KB3151864 /norestart /quiet 
wusa.exe /uninstall /kb:KB3172614 /norestart /quiet
wusa.exe /uninstall /kb:KB3179574 /norestart /quiet
wusa.exe /uninstall /kb:KB3186539 /norestart /quiet
wusa.exe /uninstall /kb:KB4019215 /norestart /quiet
wusa.exe /uninstall /kb:KB4033989 /norestart /quiet
wusa.exe /uninstall /kb:KB4033997 /norestart /quiet
wusa.exe /uninstall /kb:KB4338605 /norestart /quiet
wusa.exe /uninstall /kb:KB4338613 /norestart /quiet