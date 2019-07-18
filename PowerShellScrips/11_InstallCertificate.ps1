#Install the default cerficate
Write "******************************************************************"
Write "Install the default cerficate"
Write "******************************************************************"
$p7b = 'C://Temp/Aristocrat.ServiceFramework.Comm256.pfx'
Import-PfxCertificate -FilePath $p7b -CertStoreLocation Cert:\LocalMachine\Root