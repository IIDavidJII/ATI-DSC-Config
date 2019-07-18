#Disable IPv6 on network adapters
Write "******************************************************************"
Write "Disable IPv6"
Write "******************************************************************"
$Adapters = (Get-NetAdapterBinding -Name * -ComponentID 'ms_tcpip6').name
foreach ($Name in $Adapters) {
    if ($Name) 
    {
        [string]$Enabled = (Get-NetAdapterBinding -Name $Name -ComponentID 'ms_tcpip6').Enabled
        if( $Enabled.equals('True') )
            {
                Disable-NetAdapterBinding -Name $Name -ComponentID 'ms_tcpip6' 
                Write "IPv6 disabled on network adapter:$Name"
            }
        else
            {
                Write "IPv6 is already disabled on network adapter:$Name"
            }
    continue } ; $Name
}
Write-Output "`n"