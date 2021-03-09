# Script for running [REDACTED] microservices and composites
#
# tl;dr: Clones and runs all the specified repos.
#
# Prompts for a name, then creates a directory into which all of the repos
# in the list below will be cloned.
# You will have a chance to specify a branch other than "develop" for each repo.
# Once all the repos are cloned, each one's "run.ps1" script is run in a new
# PowerShell window.

# Update the list as needed
$ReposToClone = @(
    '[REDACTED].Payments'
    ,'[REDACTED].Stores'
    ,'[REDACTED].Utility.Api'
)

# Create containing directory
$StartingDir = Get-Location
$DirSuffix = Read-Host -Prompt "`nEnter directory suffix"
$TargetDir = "[REDACTED].$DirSuffix\"

New-Item -Confirm -ItemType Directory -Force .\$TargetDir
cd $TargetDir
$TargetDirAbsolutePath = Get-Location

# Clone repos
foreach ($repo in $ReposToClone)
{
    Write-Host "`n"
    $GitBranch = Read-Host -Prompt "Enter branch name to clone for '$repo' (leave blank to use 'develop')"

    $SshCloneUrl = "git@github.com:[REDACTED]/$repo.git"
    git clone $SshCloneUrl

    if ($GitBranch -ne '')
    {
        cd .\$repo
        git checkout $GitBranch
        cd ..

        Write-Host "'$repo' changed to branch '$GitBranch'."
    }

    Write-Host "`n'$repo' cloned."
}

# Run everything
cd $TargetDirAbsolutePath

foreach ($dir in Get-ChildItem .\)
{
    Start-Process powershell.exe -WorkingDirectory $dir -ArgumentList '.\run.ps1'
}

# Quietly back away
cd $StartingDir
