if not DEFINED IS_MINIMIZED set IS_MINIMIZED=1 && start "" /min "%~dpnx0" %* && exit
pushd %~dp0
powershell.exe -noprofile -ExecutionPolicy Bypass -Command  .\dragndrop_template.ps1
exit