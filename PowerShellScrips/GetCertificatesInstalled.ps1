#Check for cerfificates installed 
Write "******************************************************************"
Write "Check for cerfificates installed"
Write "******************************************************************"
dir cert: -Recurse | Where-Object { $_.Issuer -like "*Aristocrat*" }
