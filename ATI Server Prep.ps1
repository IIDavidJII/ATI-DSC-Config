
Configuration ATIServerPrep 
{
  Param
    ( [String]
      $TimeZone = 'Pacific Standard Time',

      [String]
      $LocalUser = 'AtiService1',

      $Password = ("{PUG=pXk>x99uUN" | ConvertTo-SecureString -asPlainText -Force),

      [PSCredential]
      $Credential = (New-Object System.Management.Automation.PSCredential($LocalUser,$password))
    )

Import-DscResource -ModuleName 'PSDesiredStateConfiguration','NetworkingDSC' , 'xSystemSecurity', 'cDTC', 'ComputerManagementDsc'

Node $AllNodes.NodeName {

#Disable Firewall
  Script DisableFirewalls
     {
       GetScript = {(Get-NetFirewallProfile -All -ErrorAction SilentlyContinue).Enabled}

       TestScript = {
                       IF((Get-NetFirewallProfile -all -ErrorAction SilentlyContinue).Enabled) 
                            {return $true} 
                       ELSE {return $false} 
                    }
       SetScript = {Set-NetFIrewallProfile -all -Enabled False}
     }


#TimeZone
    TimeZone SetTimeZone
     {
       IsSingleInstance = 'Yes'
       TimeZone = $TimeZone
     }

#add Local service account
    User LocalUser
    {
      Ensure = "Present"
      UserName = $LocalUser
      Password = $Credential
    }


#add EXISTING account to local admin   
    Group Administrators 
     {
       GroupName="Administrators"
       MembersToInclude=$LocalUser
       DependsOn = "[User]LocalUser"
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
 }
 
 Node $AllNodes.Where{$_.Role -eq "nConnect"}.nodename
 {
   WindowsFeature IISInstall1 {
     Name =  'Web-Server'
     Ensure = 'Present'
   }

   WindowsFeature IISInstall2 {
     Name = 'Web-WebServer'
     Ensure = 'Present'
   }

   WindowsFeature IISInstall3 {
     Name = 'Web-Common-Http'
     Ensure = 'Present'
   }

   WindowsFeature IISInstall4 {
     Name = 'Web-Default-Doc'
     Ensure = 'Present'
   }

   WindowsFeature IISInstall5 {
     Name = 'Web-Dir-Browsing'
     Ensure = 'Present'
   }

#Registry edit for HTTP2
   Registry HTTP2Disable1  {
     Ensure = "Present"
     Key = "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\HTTP\Parameters"
     ValueName = "EnableHttp2Tls"
     ValueData = "0"
   }

   Registry HTTP2Disable2 {
     Ensure = "Present"
     Key = "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\HTTP\Parameters"
     ValueName = "EnableHttp2Cleartext"
     ValueData = "0"
   }
      
  }

}
#Only allowed one node name change as needed

$cd = @{
    AllNodes = @(
        @{
            NodeName = "*"
            PsDscAllowPlainTextPassword = $true
         }

        @{
            NodeName = "localhost"
            Role = "nConnect"
         }
#        @{
#            NodeName = "localhost"
#            Role = "MMT"
#         }
#
#        @{
#            NodeName = "localhost"
#            Role = "PMT"
#         }
#
#        @{
#            NodeName = "localhost"
#            Role = "SMMT"
#         }
#
#        @{
#            NodeName = "localhost"
#            Role = "SMCache"
#         }
#
#        @{
#            NodeName = "localhost"
#            Role = "PollerClients"
#         }
#
#
#        @{
#            NodeName = "localhost"
#            Role = "Security"
#         }
#
#        @{
#            NodeName = "localhost"
#            Role = "Configuration"
#         }
#
#        @{
#            NodeName = "localhost"
#            Role = "Patron"
#         }
#
#        @{
#            NodeName = "localhost"
#            Role = "PatronBalance"
#         }
    )
}
ATIServerPrep -ConfigurationData $cd -OutputPath C:\DSC

Start-DscConfiguration -Path C:\DSC -Wait -Force -Verbose
