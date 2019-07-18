#Remove KBs with Oasis360 issues
Write "******************************************************************"
Write "Check the list of KB and remove them all"
Write "******************************************************************"
Get-HotFix

function Uninstall-Hotfix {
[cmdletbinding()]
param(
[string] $HotfixID
)            
$computername = $env:computername
$hotfixes = Get-WmiObject -ComputerName $computername -Class Win32_QuickFixEngineering | select hotfixid            

if($hotfixes -match $hotfixID) {
    $hotfixID = $HotfixID.Replace("KB","")
    Write "Found the hotfix KB" + $HotfixID
    Write "Uninstalling the hotfix"
    $UninstallString = "cmd.exe /c wusa.exe /uninstall /KB:$hotfixID /quiet /norestart"
    ([WMICLASS]"\\$computername\ROOT\CIMV2:win32_process").Create($UninstallString) | out-null            

    while (@(Get-Process wusa -computername $computername -ErrorAction SilentlyContinue).Count -ne 0) {
        Start-Sleep 3
        Write "Waiting for update removal to finish ..."
    }
write "Completed the uninstallation of $hotfixID"
}
else {            

write-host "Given hotfix($hotfixID) not found"
return
}            

}
Uninstall-HotFix -HotfixID KB2500170
Uninstall-HotFix -HotfixID KB3102467
Uninstall-HotFix -HotfixID KB3134815
Uninstall-HotFix -HotfixID KB3150513
Uninstall-HotFix -HotfixID KB3151864
Uninstall-HotFix -HotfixID KB3172614
Uninstall-HotFix -HotfixID KB3179574
Uninstall-HotFix -HotfixID KB3186539
Uninstall-HotFix -HotfixID KB4019215
Uninstall-HotFix -HotfixID KB4033989
Uninstall-HotFix -HotfixID KB4033997
Uninstall-HotFix -HotfixID KB4338605
Uninstall-HotFix -HotfixID KB4338613