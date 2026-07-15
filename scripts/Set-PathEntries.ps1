#Requires -Version 5.1
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [array]$Entries
)

$ErrorActionPreference = 'Stop'

foreach ($entry in $Entries) {
    $path = $entry.Path
    $scope = $entry.Scope

    $currentPath = [Environment]::GetEnvironmentVariable('Path', $scope)
    $existingEntries = $currentPath -split ';' | Where-Object { $_ -ne '' }

    if ($existingEntries -contains $path) {
        Write-SetupLog -Message "PATH already contains: $path ($scope)" -Level Info
        continue
    }

    if ($PSCmdlet.ShouldProcess($path, "Add to $scope PATH")) {
        $newPath = if ($currentPath) { "$currentPath;$path" } else { $path }
        [Environment]::SetEnvironmentVariable('Path', $newPath, $scope)
        Write-SetupLog -Message "Added to PATH: $path ($scope)" -Level Success
    }
}