$PSScriptRoot = "$Home\\Documents\\WindowsPowerShell"

# Tab complete up to the next point of ambiguity (custom)
# Set-PSReadlineKeyHandler -Key Tab -Function Complete
# Show an arrow key-navigable menu of options for tab completion (custom)
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Tab completion for Docker container names (custom)
# GitHub: https://github.com/matt9ucci/DockerCompletion
Import-Module DockerCompletion
