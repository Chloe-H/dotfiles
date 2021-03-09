# Script for running [REDACTED] microservices and composites
#
# Prompts for a directory suffix, then clones all the given [REDACTED]
# repositories into the newly created directory and runs them. See other
# comments in the file for more info.

# Creates a directory, clones all the given repos into it, and runs all of them.
function Main {
    Param([String[]] $reposToClone)

    $TargetDir, $PerformClone = HandleDirectoryCreation

    if ($PerformClone)
    {
        $reposToClone = PromptForReposToClone -reposToClone:$reposToClone
        CloneReposToDirectory -reposToClone:$reposToClone -targetDirectory:$TargetDir
    }

    RunEverythingInDirectory -targetDirectory:$TargetDir
}

# Prompts for directory suffix and handles directory creation with user's guidance
function HandleDirectoryCreation {

    $DirSuffix = Read-Host -Prompt "`nEnter directory suffix"
    $TargetDir = ".\[REDACTED].$DirSuffix\"

    # whether to clone anything into the directory
    $PerformClone = $True
    $TargetDirExists = Test-Path $TargetDir

    if ($TargetDirExists)
    {
        Write-Host "`n'$TargetDir' already exists."
        Write-Host "Options:"
        Write-Host "1) Leave the folder alone, run everything in it"
        Write-Host "2) (Proceed with caution) Force delete the folder and clone everything fresh"
        Write-Host "3) Quit"

        $AcceptedResponses = @(1, 2, 3)

        do
        {
            $Decision = Read-Host -Prompt "`nWhat would you like to do?"
        } until ($AcceptedResponses -Contains $Decision)

        switch ($Decision)
        {
            1 { $PerformClone = $False }
            2 {
                Remove-Item -Confirm -Recurse -Force $TargetDir
                $TargetDirExists = $False
            }
            3 { Exit }
        }
    }

    if (-Not $TargetDirExists)
    {
        New-Item -Confirm -ItemType Directory -Force $TargetDir
    }

    return (Resolve-Path -Path $TargetDir), $PerformClone
}

# Prompts for more repos to clone, returns the updated list
function PromptForReposToClone {
    Param([String[]] $reposToClone)

    Write-Host "`nThe following repos will be cloned:`n- $($reposToClone -Join "`n- ")"

    Write-Host "`nIf there are any other repos you want to clone and run, now is your chance."

    do
    {
        $additionalRepoToClone = Read-Host -Prompt "Enter another repo name (leave blank to stop)"

        if ($additionalRepoToClone -ne '' -And $reposToClone -NotContains $additionalRepoToClone)
        {
            $reposToClone += $additionalRepoToClone
        }
    } until ($additionalRepoToClone -eq '')

    Write-Host "`nThe following repos will be cloned:`n- $($reposToClone -Join "`n- ")"

    return $reposToClone
}

# SSH clones all of the given [REDACTED] repositories to the given
# directory; prompts for a branch other than 'develop' for each one.
function CloneReposToDirectory {
    Param(
        [String[]] $reposToClone,
        [String] $targetDirectory
    )

    foreach ($repo in $reposToClone)
    {
        Write-Host "`n"

        $GitBranch = Read-Host -Prompt "Enter branch name to clone for '$repo' (leave blank to use 'develop')"
        $SshCloneUrl = "git@github.com:[REDACTED]/$repo.git"

        if ($GitBranch -ne '')
        {
            git -C $targetDirectory clone --single-branch --branch $GitBranch $SshCloneUrl

            Write-Host "Checked out branch '$GitBranch'."
        }
        else
        {
            git -C $targetDirectory clone $SshCloneUrl
        }

        Write-Host "`n'$repo' cloned."
    }
}

# Runs the 'run.ps1' scripts in the sub-directories of the given directory
# in separate PowerShell terminals, writing any errors to respective log files.
# Note: at this time, the log files are created whether or not there are any
# errors.
function RunEverythingInDirectory {
    Param([String] $targetDirectory)

    foreach ($dir in Get-ChildItem -Attributes Directory $targetDirectory)
    {
        $ErrorLogFile = "$targetDirectory\$dir.Errors.log"

        Write-Host "Starting 'run.ps1' in $dir; any errors will be written to $ErrorLogFile"
        Start-Process powershell.exe -WorkingDirectory $dir.FullName -ArgumentList '.\run.ps1' -RedirectStandardError $ErrorLogFile
    }
}

# Update the list as needed
Main -reposToClone:@(
    '[REDACTED].Payments'
    ,'[REDACTED].Stores'
    ,'[REDACTED].Utility.Api'
)
