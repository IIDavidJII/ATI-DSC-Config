#IPv4 - Power : Uncheck "Allow the computer to turn off this device to save power"
Write "******************************************************************"
Write "IPv4 - Power"
Write "******************************************************************"
    foreach ($NIC in (Get-NetAdapter -Physical))
    {
    $PowerSaving = Get-CimInstance -ClassName MSPower_DeviceEnable -Namespace root\wmi | ? {$_.InstanceName -match [Regex]::Escape($NIC.PnPDeviceID)}
    if ($PowerSaving.Enable){
        $PowerSaving.Enable = $false
        $PowerSaving | Set-CimInstance
    }
    }
Write "Completed"