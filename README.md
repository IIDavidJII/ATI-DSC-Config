# ATI-DSC-Config
ATI Server Prep Desired Configuration

## Modules
 * NetworkingDSC
 * xSystemSecurity
 * cDTC
 * ComputerManagementDs
    
This project was written for Windows Server 2016 and powershell 5.1, but can be made compatable with Windows Server 2012 R2. The desired state configuration will set required windows features in server preperation. The server will have to be connected to the internet to get required modules. If pushing to a multi node envrionment then all target nodes have to have the modules installed and be trusted across the network. 

### Recommended: update all DSCrecources in powershell via command 
```  
    $modules = 'NetworkingDSC','xSystemSecurity','cDTC', 'ComputerManagementDsc'
    foreach($Module in $Modules) { Install-module -Name $Module.name -Force -AllowClobber}
```

### NCONNECT
This installer does not setup IIS site for nConnect. The installer should be on the install share on site. It is recommended that you create a persisitent powershell session to move the file locally to temp then execute silent install.  Replace the following:
 * $computerName with hostname of nConnect node
 * $user with domain\user of the administrative account to be used
 * $file with UNC path of install share directory nConnect folder. For example \\10.131.9.24\z$\Oasis 12.11.Europa\Utilities\nConnect. 
  
```
$session = New-PSSession -ComputerName $computerName -Credential "$user"
Copy-Item -Path $file -ToSession $session -Destination 'c:\windows\temp -Recurse'

Invoke-Command -Session $session -ScriptBlock {
    c:\windows\temp\Install-IIS-W2012.bat /silent
}
Remove-PSSession $session
```
## Desired State Configuraiton for Server Preperation
Desired state configuration describes the windows envrionment to be rather than declaring how it should be set up. Levering this mehtodology allows for dynamic configruation accross multiple versions of windows. Rather than relying on declarative syntax the envrionment is described how it should be. The process invovles creating a MOF file then pushing configuration down to the individual nodes. How to use:
  1. Downloand powershell script to administrative computer or a local node and prepare script
     1. Change params section for 
        1. $timezone
        1. $localUser
        1. $password
     1. Expand to multiple machine
        1. Change $CD nodeName to Host Names of target machines
        1. Change Node localhost to $AllNodes.NodeName
  1. Run scrtipt Ensure -outputpath on second to last line exists and change c:\DSC as necessary
  
 ## Troubleshooting
 
The verbose output will write errors to screen. Also check windows event viewer for errors.
