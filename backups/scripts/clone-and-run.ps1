$StartingDir = Get-Location
$DirSuffix = Read-Host -Prompt "`nEnter directory suffix"
$TargetDir = "Luci.$DirSuffix\"

New-Item -Confirm -ItemType Directory -Force .\$TargetDir
cd $TargetDir
$TargetDirAbsolutePath = Get-Location

# Update the list as needed
$ReposToClone = @(
    'Luci.Payments'
    ,'Luci.Stores'
    ,'Luci.Utility.Api'
)

# clone repos
foreach ($repo in $ReposToClone)
{
    Write-Host "`n"
    $GitBranch = Read-Host -Prompt "Enter branch name to clone for '$repo' (leave blank to use 'develop')"

    $SshCloneUrl = "git@github.com:Retail-Success/$repo.git"
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

cd $TargetDirAbsolutePath

foreach ($dir in Get-ChildItem .\)
{
    Start-Process powershell.exe -WorkingDirectory $dir -ArgumentList '.\run.ps1'
}

cd $StartingDir
