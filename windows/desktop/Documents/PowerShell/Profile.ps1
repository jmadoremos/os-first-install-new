#########################################################################
#
# ! Install PowerShell Core using Winget
# winget install --id Microsoft.Powershell --source winget
#
# ! Create directories and hardlink for PowerShell Core
# New-Item -ItemType Directory -Path "$HOME\Documents\PowerShell\" -Force
# New-Item -ItemType HardLink -Path "$HOME\Documents\PowerShell\profile.ps1" -Target "$HOME\Documents\WindowsPowerShell\profile.ps1"
#
#########################################################################
function prompt {
    
    # Remove conflicting aliases
    Remove-Item alias:sls

    # Check if running as admin
    $winIdentity = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $isAdminMode = $winIdentity.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    # Get powershell version
    $psVersion = Get-Host | Select-Object -ExpandProperty Version

    # Get git branch name if applicable
    $branchName = git rev-parse --abbrev-ref HEAD 2>$null

    # Get current location
    $currentDirectory = (Get-Location).Path.replace($HOME, "~")

    # Print the headers in a single line
    if ($isAdminMode -eq $true) { Write-Host "Admin] " -NoNewLine -ForegroundColor Red }
    Write-Host "v$($psVersion.Major).$($psVersion.Minor).$($psVersion.Build) " -NoNewLine -ForegroundColor Green
    Write-Host "$currentDirectory " -NoNewLine -ForegroundColor Yellow
    if ($branchName -ne $null) { Write-Host "($branchName) " -NoNewLine -ForegroundColor Cyan }

    # Print the actual prompt in a new line
    Write-Host "`nPS>" -NoNewLine

    # Resolve as whitespace to provide spacing between the prompt and the command    
    Return " "

}
