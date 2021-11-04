$DriverName = "HP Universal Printing PS (v7.0.1)";

If ($ENV:PROCESSOR_ARCHITEW6432 -eq "AMD64") {
    Try {
        &"$ENV:WINDIR\SysNative\WindowsPowershell\v1.0\PowerShell.exe" -File $PSCOMMANDPATH
    }
    Catch {
        Throw "Failed to start $PSCOMMANDPATH"
    }
    Exit
}

$InfPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition) + "\drivers\*.inf";

$infs = Get-ChildItem -Path $InfPath -Name;

Write-Host "Installing the following .inf files:" $infs;

&C:\Windows\System32\pnputil.exe /add-driver $InfPath

Write-Host "Installing Driver for" $DriverName;

Add-PrinterDriver -Name "$DriverName";