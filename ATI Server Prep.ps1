Configuration ATIServerPrep 
{
  Param
    ( [String]
      $TimeZone = 'Pacific Standard Time',
      
      [String]
      $username = 'ATIService'

    )

Import-DscResource -ModuleName 'PSDesiredStateConfiguration','NetworkingDSC' , 'xSystemSecurity', 'cDTC', 'ComputerManagementDsc'



#TimeZone
    TimeZone SetTimeZone
     {
       IsSingleInstance = 'Yes'
       TimeZone = $TimeZone
     }


#add EXISTING account to local admin   
    Group Administrators 
     {
       GroupName="Administrators"
       MembersToInclude=$username
     }

#install required windows features

    WindowsFeature MessageQueuing 
     {
      Name = "MSMQ"
      Ensure = "Present"
     }
    WindowsFeature MessageQueuingService 
     {
      Name = "MSMQ-Services"
      Ensure = "Present"
     }

    WindowsFeature MessageQueingServer
     {
      Name = "MSMQ-Server"
      Ensure = "Present"
     }

#User Account Control    
    xUac DisableUAC 
     {
      Setting ='NeverNotifyAndDisableAll'
     }

#Distributed Transactions     
     cDTCNetworkSetting DistributedTrans 
     {
       DtcName = "Local"
       RemoteClientAccessEnabled = $true
       RemoteAdministrationAccessEnabled = $true
       InboundTransactionsEnabled = $true
       OutboundTransactionsEnabled = $true
       AuthenticationLevel = "NoAuth"
     }

#Power Plan
     PowerPlan SetPlanHighPerformance
        {
          IsSingleInstance = 'Yes'
          Name             = 'High performance'
        }

#IP6 Disable
      NetAdapterRsc DisableIPV6
       {
            Name = 'Ethernet'
            Protocol = 'IPv6'
            State = $false 
       }

#IPV4 disable nic Power Management
     Script DisablePowerManagement
       {
         TestScript = {
                        $adapterPower = Get-NetAdapterPowerManagement
                        
                        If (
                             $adapterPower.ArpOffload -eq "Unsupported"  -and $adapterPower.NSOffload -eq "Unsupported" -and $adapterPower.RsnRekeyOffload -eq "Unsupported" -and $adapterPower.D0PacketCoalescing-eq "Unsupported" -and $adapterPower.SelectiveSuspend -eq "Unsupported" -and $adapterPower.DeviceSleepOnDisconnect -eq "Unsupported" -and $adapterPower.WakeOnMagicPacket -eq "Unsupported" -and $adapterPower.WakeOnPattern -eq "Unsupported"
                           ){return $true}
                             Else {return $false}
                      }

         SetScript = {$adapters = Get-NetAdapter
                      FOREACH ($adapter in $adapters){Disable-NetAdapterPowerManagement -Name $adapter.Name}
                     }

         GetScript = {Get-NetAdapterPowerManagement}
       }

#Bad Hotfixes
      
}

$cd = @{
    AllNodes = @(
        @{
            NodeName = 'localhost'
            PSDscAllowPlainTextPassword = $true
        }
    )
}
ATIServerPrep -ConfigurationData $cd -OutputPath C:\DSC

Start-DscConfiguration -Path C:\DSC -Wait -Force -Verbose
