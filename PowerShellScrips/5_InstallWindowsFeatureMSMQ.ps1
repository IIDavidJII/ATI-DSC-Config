#Installs Windows Feature - MSMQ
Write "******************************************************************"
Write "Windows Feature - MSMQ"
Write "******************************************************************"
get-windowsfeature -name MSMQ | install-windowsfeature
get-windowsfeature -name MSMQ | Format-list Name, Installstate

Write "******************************************************************"
Write "Windows Feature - MSMQ-Services"
Write "******************************************************************"
get-windowsfeature -name MSMQ-Services | install-windowsfeature
get-windowsfeature -name MSMQ-Services | Format-list Name, Installstate

Write "******************************************************************"
Write "Windows Feature - MSMQ-Server"
Write "******************************************************************"
get-windowsfeature -name MSMQ-Server | install-windowsfeature
get-windowsfeature -name MSMQ-Server | Format-list Name, Installstate