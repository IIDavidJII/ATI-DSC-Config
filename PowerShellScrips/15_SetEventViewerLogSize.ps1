# Set event viewer log size to 16384 KB.
Write "******************************************************************"
Write "Set event viewer log size to 16384 KB"
Write "******************************************************************"
$logs = 'ATI-Application', 'ATI-PMT', 'Application', 'Aristocrat', 'ATI-PC', 'ATI-nTime/Operational', 'ATI-MMT'
foreach($log in $logs)
{
    if(Get-EventLog -list| where {$_.log -eq $log} | Select Machinename,Log,MaximumKilobytes|format-table -auto)
        {
        Write "******************************************************************"
        Write "$log exists on this machine. Setting MaximumSize"
        Limit-EventLog -LogName $log -MaximumSize 16384kb
        Get-EventLog -list| where {$_.log -eq $log} | Select Machinename,Log,MaximumKilobytes|format-table -auto
        Write "******************************************************************"
        "`n"
        }
    else
        {
        Write "******************************************************************"
        write "$log does not exist on this machine."
        Write "******************************************************************"
        "`n"
        }
}