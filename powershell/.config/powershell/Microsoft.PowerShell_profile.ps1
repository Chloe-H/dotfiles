$PSScriptRoot = "$Home\\Documents\\WindowsPowerShell"

# Tab complete up to the next point of ambiguity
# Set-PSReadlineKeyHandler -Key Tab -Function Complete
# Show an arrow key-navigable menu of options for tab completion
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Tab completion for Docker container names
# GitHub: https://github.com/matt9ucci/DockerCompletion
# TODO: Uncomment only after installing the module
# Import-Module DockerCompletion
