$PSScriptRoot = "$Home\\Documents\\WindowsPowerShell"

Import-Module $PSScriptRoot\[REDACTED].Powershell.Utilities\AddPackageToLocalFeed.ps1
Import-Module $PSScriptRoot\[REDACTED].Powershell.Utilities\Load[REDACTED]DbBackups.ps1
Import-Module $PSScriptRoot\[REDACTED].Powershell.Utilities\CloneAndRun[REDACTED]Repos.ps1

# Function for creating a [REDACTED] db Docker container (custom)
function Create[REDACTED]DbContainer {
    Param(
        [String]$ContainerName,
        [String]$DbPassword
    )

    docker create -p 1433:1433 -e SA_PASSWORD=$DbPassword -e ACCEPT_EULA="Y" --name $ContainerName mcr.microsoft.com/mssql/server:2019-latest
}

# Tab complete up to the next point of ambiguity (custom)
# Set-PSReadlineKeyHandler -Key Tab -Function Complete
# Show an arrow key-navigable menu of options for tab completion (custom)
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Tab completion for Docker container names
Import-Module DockerCompletion

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
