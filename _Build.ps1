# Check if we are running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # We are not running "as Administrator" - so relaunch as administrator

    # Indicate that we are running as admin
    $arguments = "& {Set-Location -Path '$PWD'; & '" + $myinvocation.mycommand.definition + "'}"

    # Start new process as administrator
    Start-Process powershell -Verb runAs -ArgumentList $arguments

    # Exit from the current, unelevated, process
    Exit
}

pushd ..\windows-openstack-imaging-tools
Import-Module .\WinImageBuilder.psm1
Import-Module .\Config.psm1
Import-Module .\UnattendResources\ini.psm1
# Create a config.ini file using the built in function, then set them accordingly to your needs
$ConfigFilePath = ".\config.ini"

New-WindowsOnlineImage -ConfigFilePath $ConfigFilePath

popd

Read-Host -Prompt "Press Enter to continue"