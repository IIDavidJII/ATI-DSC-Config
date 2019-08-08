# ATI-DSC-Config
ATI Server Prep Desired Configuration

 Modules
 -NetworkingDSC
 -xSystemSecurity
 -cDTC
 -ComputerManagementDs
    
This project was written for Windows Server 2016 and powershell 5.1, but can be made compatable with Windows Server 2012 R2. The desired state configuration will set required windows features in server preperation. Have a reques then add to the issues list to request a feature. The server will have to be connected to the internet to get required modules. If pushing to a multi node envrionment then all target nodes have to have the modules installed.
  
Recommended: update all DSCrecources in powershell via command 
  
    $modules = 'NetworkingDSC','xSystemSecurity','cDTC', 'ComputerManagementDsc'
    foreach($Module in $Modules) { Install-module -Name $Module.name -Force -AllowClobber}

