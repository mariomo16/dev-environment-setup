Set-StrictMode -Version Latest

$script:LogFilePath = $null

function Initialize-SetupLog {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$LogPath
    )

    if (-not (Test-Path -Path $LogPath)) {
        New-Item -Path $LogPath -ItemType Directory -Force | Out-Null
    }

    $timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $script:LogFilePath = Join-Path $LogPath "setup-$timestamp.log"
}

function Write-SetupLog {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Message,

        [ValidateSet('Info', 'Success', 'Warning', 'Error')]
        [string]$Level = 'Info'
    )

    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    $line = "[$timestamp] [$Level] $Message"

    switch ($Level) {
        'Info' { Write-Host $line -ForegroundColor Gray }
        'Success' { Write-Host $line -ForegroundColor Green }
        'Warning' { Write-Host $line -ForegroundColor Yellow }
        'Error' { Write-Host $line -ForegroundColor Red }
    }

    if ($script:LogFilePath) {
        Add-Content -Path $script:LogFilePath -Value $line
    }
}

function Test-IsAdministrator {
    [CmdletBinding()]
    param()

    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Test-ElevationRequired {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [hashtable]$EnvironmentConfig
    )

    $machineVariables = $EnvironmentConfig.Variables   | Where-Object { $_.Scope -eq 'Machine' }
    $machinePathEntries = $EnvironmentConfig.PathEntries | Where-Object { $_.Scope -eq 'Machine' }

    return (($machineVariables.Count + $machinePathEntries.Count) -gt 0)
}

Export-ModuleMember -Function Write-SetupLog, Initialize-SetupLog, Test-IsAdministrator, Test-ElevationRequired