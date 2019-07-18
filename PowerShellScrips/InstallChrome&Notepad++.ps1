#  Install Chrome & Notepad ++ 
#(The path is related to the executable file not the script file)
Write "******************************************************************"
Write "Install Chrome & Notepad ++"
Write "******************************************************************"
$chrome = "nConnect\ChromeStandaloneSetup64.exe"
$notepad = "nConnect\npp.7.3.2.Installer.exe"

$setup=Start-Process $chrome  -Wait
$setup=Start-Process $notepad -Wait

Write "Instalation Completed"