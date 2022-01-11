# Script Title
Write-Output '=============================================='
Write-Output '                                              '
Write-Output '      Configure PowerShell Profile Paths      '
#Write-Output '                                              '
Write-Output '=============================================='


If ($host.version -like '5.*') {
    Write-Warning 'PowerShell 5 Detected'
    
    # Create Default Profile
    $ProfilePath = "$([Environment]::GetFolderPath("MyDocuments"))\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
    New-Item -ItemType 'File' -Path $ProfilePath -Force | Out-Null
    Write-Warning -Message 'Default Profile Path Created'

    # Create Synbolic Links 
    New-Item -ItemType SymbolicLink -Target $ProfilePath -Path "$([Environment]::GetFolderPath("MyDocuments"))\PowerShell\Microsoft.PowerShell_profile.ps1" -Force | Out-Null
    New-Item -ItemType SymbolicLink -Target $ProfilePath -Path "$([Environment]::GetFolderPath("MyDocuments"))\PowerShell\Microsoft.VSCode_profile.ps1" -Force | Out-Null
    Write-Warning -Message 'Symbolic Link Created for PowerShell 7.x and Visual Studio Code'

    if ((Get-PackageProvider -Name 'NuGet').version -Join "." -ne '2.8.5.208') {
        Write-Warning -Message 'Installing NuGet'
        Install-PackageProvider -Name 'NuGet' -Force
    }
    Else {
        Write-Warning -Message 'NuGet - Latest Relase Installed'
    }

    Write-Warning -Message 'Checking PSGallery Installation Policy'
    if ((Get-PSRepository -Name PSGallery).InstallationPolicy -ne 'Trusted') {
        Set-PSRepository -Name 'PSGallery' -InstallationPolicy 'Trusted'
        Write-Warning -Message 'PSGallery - InstallationPolicy: Trusted'
    } 
    
    Write-Warning -Message 'Checking PowerShellGet Version on PSGallery'
    if ((Get-Module -Name 'PowerShellGet').version -Join "." -ne (Find-Module -Name PowerShellGet).version) {
        Install-Module PowerShellGet -Force
        Remove-Module PowerShellGet ; Import-Module PowerShelLGet
    }
    Else {
        Write-Warning -Message 'PowerShellGet - Latest Relase Installed'
    }

    Remove-Module -Name 'PowerShellGet'
    Remove-Module -Name 'PackageManagement'
    Start-Sleep -Seconds 2
    Import-Module -Name 'PackageManagement'
    Import-Module -Name 'PowerShellGet'
}

If ($host.version -like '7.*') {
    Write-Warning 'PowerShell 7 Detected'

    # Create Default Profile
    $ProfilePath = "$([Environment]::GetFolderPath("MyDocuments"))\PowerShell\Microsoft.PowerShell_profile.ps1"
    New-Item -ItemType 'File' -Path $ProfilePath -Force | Out-Null
    Write-Warning -Message 'Default Profile Path Created'

    # Create Synbolic Links 
    New-Item -ItemType SymbolicLink -Target $ProfilePath -Path "$([Environment]::GetFolderPath("MyDocuments"))\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Force | Out-Null
    New-Item -ItemType SymbolicLink -Target $ProfilePath -Path "$([Environment]::GetFolderPath("MyDocuments"))\PowerShell\Microsoft.VSCode_profile.ps1" -Force | Out-Null
    Write-Warning -Message 'Symbolic Link Created for PowerShell 5.1 and Visual Studio Code'
} 

# Section Title
Write-Output ''
Write-Output '=============================================='
Write-Output '                                              '
Write-Output '        Installing PowerShell Modules         '
#Write-Output '                                              '
Write-Output '=============================================='

Write-Warning -Message 'Installing... Oh-My-Posh'
Install-Module -Repository 'PSGallery' -Name 'Oh-My-Posh' -Force

Write-Warning -Message 'Installing... Posh-Git'
Install-Module -Repository 'PSGallery' -Name 'Posh-Git' -Force

Write-Warning -Message 'Installing... PSReadLine'
Install-Module -Repository 'PSGallery' -Name 'PSReadLine' -AllowPrerelease -Force

# Section Title
Write-Output ''
Write-Output '=============================================='
Write-Output '                                              '
Write-Output '        Configure PowerShell Profile          '
#Write-Output '                                              '
Write-Output '=============================================='

# Configure Profile
"# Import Modules
Import-Module -Name 'Oh-My-Posh'
Import-Module -Name 'posh-git'
Import-Module -Name 'PSReadLine'

# Define PSReadLine Configuration
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

# Configure Oh-My-Posh Prompt
Set-PoshPrompt -Theme paradox

" | Set-Content -Path $ProfilePath
    (Get-Content $ProfilePath).Trim() | Set-Content $ProfilePath

# Verbose - Setup Complete
Write-Output ''
Write-Output 'Windows Terminal - PowerShell Profile Configured!'
. $Profile