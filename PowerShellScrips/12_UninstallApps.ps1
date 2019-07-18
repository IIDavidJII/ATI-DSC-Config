#Uninstall Aristocrat applications
Write "******************************************************************"
Write "Uninstall Aristocrat applications"
Write "******************************************************************"
$app = Get-WmiObject Win32_Product | Where-Object {$_.Vendor -like 'Aristocrat*'} 
if($app){$app.Uninstall()}
Write "Operation Completed"