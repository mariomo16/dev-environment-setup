#Requires -Version 5.1
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [array]$Symlinks
)

$ErrorActionPreference = 'Stop'

foreach ($link in $Symlinks) {
    $source = $link.Source
    $target = $link.Target

    if (-not (Test-Path -Path $source)) {
        Write-SetupLog -Message "Source file not found, skipping: $source" -Level Warning
        continue
    }

    $targetDir = Split-Path -Path $target -Parent
    if (-not (Test-Path -Path $targetDir)) {
        New-Item -Path $targetDir -ItemType Directory -Force | Out-Null
    }

    $existingItem = Get-Item -Path $target -Force -ErrorAction SilentlyContinue

    if ($existingItem -and $existingItem.LinkType -eq 'SymbolicLink') {
        Write-SetupLog -Message "Symlink already exists: $target" -Level Info
        continue
    }

    if ($existingItem) {
        $backupPath = "$target.bak"
        Move-Item -Path $target -Destination $backupPath -Force
        Write-SetupLog -Message "Existing file backed up: $target -> $backupPath" -Level Warning
    }

    if ($PSCmdlet.ShouldProcess($target, "Create symbolic link to $source")) {
        New-Item -Path $target -ItemType SymbolicLink -Value $source -Force | Out-Null
        Write-SetupLog -Message "Created symlink: $target -> $source" -Level Success
    }
}