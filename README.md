# ATI-DSC-Config
ATI Server Prep Desired Configuration

Requirements
  Modules: 'PSDesiredStateConfiguration','NetworkingDSC' , 'xSystemSecurity', 'cDTC', 'ComputerManagementDsc'
  Recommended: update all DSCrecources in powershell via command 
    $Modules = Find-Module -Tag DSCResource
    foreach($Module in $Modules) { Install-module -Name $Module.name -Force -AllowClobber}
