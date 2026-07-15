#Requires -Version 5.1
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [array]$Variables
)

$ErrorActionPreference = 'Stop'

foreach ($variable in $Variables) {
    $name = $variable.Name
    $value = $variable.Value
    $scope = $variable.Scope

    $currentValue = [Environment]::GetEnvironmentVariable($name, $scope)

    if ($currentValue -eq $value) {
        Write-SetupLog -Message "Environment variable already set: $name ($scope)" -Level Info
        continue
    }

    if ($PSCmdlet.ShouldProcess("$name=$value", "Set $scope environment variable")) {
        [Environment]::SetEnvironmentVariable($name, $value, $scope)
        Write-SetupLog -Message "Set environment variable: $name=$value ($scope)" -Level Success
    }
}