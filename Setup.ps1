#Requires -Version 5.1
[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$ConfigPath = (Join-Path $PSScriptRoot 'config'),
    [string]$ScriptsPath = (Join-Path $PSScriptRoot 'scripts')
)

$ErrorActionPreference = 'Stop'

Import-Module (Join-Path $PSScriptRoot 'modules\SetupCommon\SetupCommon.psd1') -Force

Initialize-SetupLog -LogPath (Join-Path $PSScriptRoot 'logs')

try {
    Write-SetupLog -Message 'Starting dev environment setup' -Level Info

    $directoriesConfig = Import-PowerShellDataFile -Path (Join-Path $ConfigPath 'directories.psd1')
    $environmentConfig = Import-PowerShellDataFile -Path (Join-Path $ConfigPath 'environment.psd1')

    $requiresElevation = Test-ElevationRequired -EnvironmentConfig $environmentConfig
    if ($requiresElevation -and -not (Test-IsAdministrator)) {
        throw 'This configuration modifies Machine-scoped settings. Please re-run this script as Administrator.'
    }

    & (Join-Path $ScriptsPath 'New-DirectoryTree.ps1') -Directories $directoriesConfig.Directories

    & (Join-Path $ScriptsPath 'Set-EnvironmentVariables.ps1') -Variables $environmentConfig.Variables

    & (Join-Path $ScriptsPath 'Set-PathEntries.ps1') -Entries $environmentConfig.PathEntries

    Write-SetupLog -Message 'Setup completed successfully' -Level Success
}
catch {
    Write-SetupLog -Message "Setup failed: $($_.Exception.Message)" -Level Error
    throw
}