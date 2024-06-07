# HOW TO RUN
# Run PowerShell as an administrator and execute
Set-ExecutionPolicy Bypass -Scope Process -Force
.\apply_windows_update_settings.ps1


# Get the script directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Get the main directory
$mainDir = Split-Path -Parent $scriptDir

# Get Windows version
$windowsVersion = [System.Environment]::OSVersion.Version

# Define paths to .reg files
$win10RegFile = Join-Path $mainDir "win10-disable-automatic-updates.reg"
$win11RegFile = Join-Path $mainDir "win11-disable-automatic-updates.reg"

# Function to import .reg file
function Import-RegFile {
    param (
        [string]$regFilePath
    )
    Start-Process regedit.exe -ArgumentList "/s $regFilePath" -Wait
}

# Check if Windows 10 (version 10.0.xxxx)
if ($windowsVersion.Major -eq 10 -and $windowsVersion.Minor -eq 0 -and $windowsVersion.Build -lt 22000) {
    Write-Output "Detected Windows 10"
    Import-RegFile -regFilePath $win10RegFile
}
# Check if Windows 11 (version 10.0.22000 or higher)
elseif ($windowsVersion.Major -eq 10 -and $windowsVersion.Minor -eq 0 -and $windowsVersion.Build -ge 22000) {
    Write-Output "Detected Windows 11"
    Import-RegFile -regFilePath $win11RegFile
}

Write-Output "Finished applying settings"