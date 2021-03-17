# Clones and runs Wayroo microservices and composites.
#
# Prompts for a directory suffix, then clones all the given Retail-Success
# repositories into the newly created directory and runs them. See other
# comments in the file for more info.

# Prompts for directory suffix and handles directory creation with user's guidance
function CloneAndRunWayrooRepos-HandleDirectoryCreation {

    $DirSuffix = Read-Host -Prompt "`nEnter directory suffix"
    $TargetDir = ".\Wayroo.$DirSuffix\"

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
function CloneAndRunWayrooRepos-PromptForReposToClone {
    param([String[]] $ReposToClone)

    Write-Host "`nThe following repos will be cloned:`n- $($ReposToClone -Join "`n- ")"

    Write-Host "`nIf there are any other repos you want to clone and run, now is your chance."

    do
    {
        $additionalRepoToClone = Read-Host -Prompt "Enter another repo name (leave blank to stop)"

        if ($additionalRepoToClone -ne '' -And $ReposToClone -NotContains $additionalRepoToClone)
        {
            $ReposToClone += $additionalRepoToClone
        }
    } until ($additionalRepoToClone -eq '')

    Write-Host "`nThe following repos will be cloned:`n- $($ReposToClone -Join "`n- ")"

    return $ReposToClone
}

# SSH clones all of the given Retail-Success repositories to the given
# directory; prompts for a branch other than 'develop' for each one.
function CloneAndRunWayrooRepos-CloneReposToDirectory {
    param(
        [String[]] $ReposToClone,
        [String] $TargetDirectory
    )

    foreach ($repo in $ReposToClone)
    {
        Write-Host "`n"

        $GitBranch = Read-Host -Prompt "Enter branch name to clone for '$repo' (leave blank to use 'develop')"
        $SshCloneUrl = "git@github.com:Retail-Success/$repo.git"

        if ($GitBranch -ne '')
        {
            git -C $TargetDirectory clone --single-branch --branch $GitBranch $SshCloneUrl

            Write-Host "Checked out branch '$GitBranch'."
        }
        else
        {
            git -C $TargetDirectory clone $SshCloneUrl
        }

        Write-Host "`n'$repo' cloned."
    }
}

# Runs the 'run.ps1' scripts in the sub-directories of the given directory
# in separate PowerShell terminals, writing any errors to respective log files.
# Note: at this time, the log files are created whether or not there are any
# errors.
function CloneAndRunWayrooRepos-RunEverythingInDirectory {
    param([String] $TargetDirectory)

    foreach ($dir in Get-ChildItem -Attributes Directory $TargetDirectory)
    {
        $ErrorLogFile = "$TargetDirectory\$dir.Errors.log"

        Write-Host "Starting 'run.ps1' in $dir; any errors will be written to $ErrorLogFile"
        Start-Process powershell.exe -WorkingDirectory $dir.FullName -ArgumentList '.\run.ps1' -RedirectStandardError $ErrorLogFile
    }
}

# Creates a directory, clones all the given repos into it, and runs all of them.
function CloneAndRunWayrooRepos {
    param([String[]] $ReposToClone)

    $TargetDir, $PerformClone = CloneAndRunWayrooRepos-HandleDirectoryCreation

    if ($PerformClone)
    {
        $ReposToClone = CloneAndRunWayrooRepos-PromptForReposToClone -reposToClone:$ReposToClone
        CloneAndRunWayrooRepos-CloneReposToDirectory -reposToClone:$ReposToClone -targetDirectory:$TargetDir
    }

    CloneAndRunWayrooRepos-RunEverythingInDirectory -targetDirectory:$TargetDir
}
