# Chocolatey Move
If you don't have a licensed Chocolatey edition, all packages will be installed to **C:\ProgramData\chocolatey**. Using **PowerShell** script can quickly move packages to other locations.

## How to Use 
Set a disk:

```ps
$partition = "e:"
```

Select your package:

```ps
$appName = "dbr"
```

Run PowerShell as **administrator**.

Check PowerShell version:

```ps
$PSVersionTable.PSVersion
```
![Check PowerShell version](screenshots\powershell-version.PNG)

Set **ExecutionPolicy**:

```ps
Set-ExecutionPolicy RemoteSigned
```

Run the script:

```ps
.\choco-move.ps1
```
![Move chocolatey packages with PowerShell script](screenshots\powershell-chocolatey-package.PNG)