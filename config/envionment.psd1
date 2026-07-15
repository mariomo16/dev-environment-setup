@{
    Variables   = @(
        @{ Name = 'JAVA_HOME'; Value = 'C:\Dev\Tools\jdk'; Scope = 'User' }
        @{ Name = 'ANDROID_HOME'; Value = 'C:\Dev\Tools\android-sdk'; Scope = 'User' }
        @{ Name = 'ANDROID_SDK_ROOT'; Value = 'C:\Dev\Tools\android-sdk'; Scope = 'User' }
        @{ Name = 'PUB_CACHE'; Value = 'C:\Dev\Cache\pub'; Scope = 'User' }
        # @{ Name = 'CHROME_EXECUTABLE'; Value = ''; Scope = 'User' }
        # @{ Name = 'GIT_CONFIG_GLOBAL'; Value = 'C:\Dev\Config\.gitconfig'; Scope = 'User' }
        # @{ Name = 'LESSHISTFILE'; Value = 'C:\Dev\Config\.lesshst'; Scope = 'User' }
        # @{ Name = 'NPM_CONFIG_USERCONFIG'; Value = 'C:\Dev\Config\.npmrc'; Scope = 'User' }
        # @{ Name = 'PNPM_HOME'; Value = 'C:\Dev\Config\pnpm'; Scope = 'User' }
    )

    PathEntries = @(
        # Node.js
        @{ Path = 'C:\Dev\Tools\nodejs'; Scope = 'User' }
        @{ Path = 'C:\Dev\Tools\nodejs\npm-global'; Scope = 'User' }
        # @{ Path = '%PNPM_HOME%'; Scope = 'User' }

        # PHP
        @{ Path = 'C:\Dev\Tools\php'; Scope = 'User' }
        @{ Path = 'C:\Dev\Tools\composer'; Scope = 'User' }

        # Java
        @{ Path = '%JAVA_HOME%\bin'; Scope = 'User' }

        # Android SDK
        @{ Path = '%ANDROID_HOME%\cmdline-tools\latest\bin'; Scope = 'User' }
        @{ Path = '%ANDROID_HOME%\platform-tools'; Scope = 'User' }
        @{ Path = '%ANDROID_HOME%\emulator'; Scope = 'User' }

        # Flutter
        @{ Path = 'C:\Dev\Tools\flutter\bin'; Scope = 'User' }

        # Catch-all
        @{ Path = 'C:\Dev\Tools'; Scope = 'User' }
    )
}