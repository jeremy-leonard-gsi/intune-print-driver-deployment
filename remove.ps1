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

# Remove printers using this driver.
Write-Host "Removing Printers";
Get-Printer | Where-Object -Property DriverName -eq -Value $DriverName;
Get-Printer | Where-Object -Property DriverName -eq -Value $DriverName | Remove-Printer;

# Remove the driver from the printing system.

Write-Host "Removing Drivers";
Get-PrinterDriver | Where-Object -Property Name -eq -Value $DriverName
Get-PrinterDriver | Where-Object -Property Name -eq -Value $DriverName | Remove-PrinterDriver;

$infs = Get-ChildItem -Path $InfPath -Name;
$oeminfs = &pnputil.exe /enum-drivers;

foreach ($line in $oeminfs){
   if($line -match "^Published Name:\s+.*"){
    $currentOEM=$line.split(":").replace(" ","")[1];
   }
   if($line -match "^Original Name:\s+.*" -and $currentOEM.Length -gt 0){
    $currentInf = $line.Split(":").replace(" ","")[1];
    if($infs.Contains($currentInf)){
        Write-Host "Removing " $currentOEM $currentInf;
        &pnputil.exe /delete-driver $currentOEM -force;
        $currentOEM = $null;
        $currentInf = $null;
    }

   } 
}