@{
    RootModule        = 'SetupCommon.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = 'b3f2a1c4-6e8d-4a2f-9c7b-1d5e8f3a2b90'
    Author            = 'Mario'
    Description       = 'Shared helper functions for dev-environment-setup scripts.'
    PowerShellVersion = '5.1'
    FunctionsToExport = @(
        'Write-SetupLog',
        'Initialize-SetupLog',
        'Test-IsAdministrator',
        'Test-ElevationRequired'
    )
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()
}