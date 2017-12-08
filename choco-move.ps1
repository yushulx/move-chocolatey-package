# https://technet.microsoft.com/en-us/library/ff730964.aspx
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/?view=powershell-5.1
$chocoDefault = "C:\ProgramData\chocolatey\lib"
$partition = "e:"
$appName = "dbr"
$binaryFolder = "tools"
$sourceDir = Join-Path $chocoDefault -ChildPath $appName
try {
    $destinationDir = Join-Path $partition -ChildPath "chocolatey" -ErrorAction Stop
}
catch {
    $exception = $_
    Write-Output $exception
    Exit 1
}

$envPath = Join-Path $destinationDir -ChildPath $appName | Join-Path -ChildPath $binaryFolder 

# Create a new folder.
if (![System.IO.Directory]::Exists($destinationDir)) { 
    [System.IO.Directory]::CreateDirectory($destinationDir)
}

#Copy the package to the target folder and remove the package from the default Chocolatey directory.
try {
    Write-Output "Copy the package to $destinationDir."
    Copy-Item $sourceDir $destinationDir -Force -Recurse -ErrorAction Stop

    ## Add the path to environment variables
    $environmentVariables = [Environment]::GetEnvironmentVariable("Path", "Machine")
    
    if ($environmentVariables.Contains($envPath)) {
        Write-Output "Environment Path already exists."
    }
    else {
        Write-Output "Add the path to environment variables."
        $environmentVariables = "$envPath;" + $environmentVariables
        [Environment]::SetEnvironmentVariable("Path", $environmentVariables, "Machine")
    }

    # Uninstall Dynamsoft Barcode Reader
    choco uninstall $appName
}
catch {
    $exception = $_
    Write-Output $exception
}

# try {
#     # Remove package-related files
#     $path = Join-Path $sourceDir -ChildPath "tools"
#     $fileNames = Get-ChildItem -Path $path -Include *.exe -Name
#     foreach($fileName in $fileNames) {
#         Write-Output "Remove $fileName from C:\ProgramData\chocolatey\bin"
#         $filePath = Join-Path "C:\ProgramData\chocolatey\bin" -ChildPath $fileName
#         Remove-Item -Path $filePath -Force
#     }

#     Write-Output "Remove the package from C:\ProgramData\chocolatey\lib."
#     Remove-Item $sourceDir -Force -Recurse -ErrorAction Stop
# }
# catch {
#     $exception = $_
#     Write-Output $exception
# }

Write-Output "Finished."