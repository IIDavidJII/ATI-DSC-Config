#Installs .Net 3.5 & 4.5
Write "******************************************************************"
Write "Windows Feature - NET-Framework-Features"
Write "******************************************************************"
get-windowsfeature -name NET-Framework-Features | install-windowsfeature -source d:\sources\sxs
get-windowsfeature -name NET-Framework-Features  | Format-list Name, Installstate

Write "******************************************************************"
Write "Windows Feature - NET-Framework-Core"
Write "******************************************************************"
get-windowsfeature -name NET-Framework-Core | install-windowsfeature -source d:\sources\sxs
get-windowsfeature -name NET-Framework-Core | Format-list Name, Installstate

Write "******************************************************************"
Write "Windows Feature - NET-Framework-45-Features"
Write "******************************************************************"
get-windowsfeature -name NET-Framework-45-Features | install-windowsfeature -source d:\sources\sxs
get-windowsfeature -name NET-Framework-45-Features | Format-list Name, Installstate

Write "******************************************************************"
Write "Windows Feature - NET-Framework-45-Core "
Write "******************************************************************"
get-windowsfeature -name NET-Framework-45-Core | install-windowsfeature -source d:\sources\sxs
get-windowsfeature -name NET-Framework-45-Core | Format-list Name, Installstate