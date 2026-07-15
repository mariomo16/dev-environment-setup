#Requires -Version 5.1
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [array]$Directories
)

$ErrorActionPreference = 'Stop'

foreach ($directory in $Directories) {
    $path = $directory.Path

    if (Test-Path -Path $path) {
        Write-SetupLog -Message "Directory already exists: $path" -Level Info
        continue
    }

    if ($PSCmdlet.ShouldProcess($path, 'Create directory')) {
        New-Item -Path $path -ItemType Directory -Force | Out-Null
        Write-SetupLog -Message "Created directory: $path" -Level Success
    }
}