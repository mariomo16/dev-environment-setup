@{
    Symlinks = @(
        @{
            Source = 'dotfiles\.gitconfig'
            Target = '{0}\.gitconfig' -f $env:USERPROFILE
        }
        @{
            Source = 'dotfiles\.npmrc'
            Target = '{0}\.npmrc' -f $env:USERPROFILE
        }
        @{
            Source = 'dotfiles\config.yaml'
            Target = '{0}\Local\pnpm\config\config.yaml' -f $env:LOCALAPPDATA
        }
        # @{
        #     Source = 'dotfiles\Microsoft.PowerShell_profile.ps1'
        #     Target = $PROFILE
        # }
        @{
            Source = 'dotfiles\.lesshst'
            Target = '{0}\.lesshst' -f $env:USERPROFILE
        }
        @{
            Source = 'dotfiles\biome.jsonc'
            Target = '{0}\biome.jsonc' -f $env:USERPROFILE
        }
        @{
            Source = 'dotfiles\.angular-config.json'
            Target = '{0}\.angular-config.json' -f $env:USERPROFILE
        }
    )
}