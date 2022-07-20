# Intune Print Driver Deployment

There are three scripts needed.
1. install.ps1
2. detect.ps1
3. remove.ps1

## Steps:

1. Download the needed driver.
2. Extract the driver so you have the .inf, .cab, and all supporting files.
3. Create a temporary folder and copy the three powershell scripts to this temporary directory.
4. Create a "drivers" directory and copy the extracted files from the driver package to this directory.
5. Open the .inf file and get the EXACT name of the driver you wish to install.
6. Update the install.ps1 file with the name of the driver from the .inf file.
7. Update the detect.ps1 file with the name of the driver from the .inf file.
8. Update the remove.ps1 file with the name of the driver from the .inf file.
9. Use the [IntuneWinAppUtil](https://github.com/Microsoft/Microsoft-Win32-Content-Prep-Tool) to build the package.
10. Import the .intunewin file into Endpoint Management.
11. Set the install command line to: `powershell.exe -ExecutionPolicy Bypass -File install.ps1`
12. Set the removal command line to: `powershell.exe -ExecutionPolicy Bypass -File remove.ps1`
13. set the Detection rules to be custom script and import the detect.ps1 script from the temp directory created above.
