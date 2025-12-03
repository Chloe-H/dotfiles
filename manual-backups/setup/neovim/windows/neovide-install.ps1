<#
    Windows doesn't seem to like running this script, but it's still valuable
    as a reference.

    Alternate source for a lot of this: https://community.ops.io/aowendev/managing-packages-on-windows-with-scoop-411d
#>

# TODO: Add fzf, git completion?

# Get current execution policy, in case you want to reset it after the install
Get-ExecutionPolicy -Scope CurrentUser

# Necessary to run a remote script the first time and to run scoop commands
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Install scoop
irm get.scoop.sh | iex

# Install git for dotfiles, possibly also scoop's extras bucket
scoop install git

<#
    Symlink configurations (probably need an elevated shell for this);
    run these at the repo's root
#>
New-Item -ItemType SymbolicLink -Path $env:LOCALAPPDATA\nvim\ -Target .\neovim\.config\nvim\

New-Item -ItemType SymbolicLink -Path $env:USERPROFILE\.gitconfigs\ -Target .\git\.gitconfigs\
New-Item -ItemType SymbolicLink -Path $env:USERPROFILE\.git-templates\ -Target .\git\.git-templates\

New-Item -ItemType SymbolicLink -Path $env:USERPROFILE\.ssh\config -Target .\ssh\.ssh\config

# Add extras bucket
scoop bucket add extras

# Install neovim and neovide
scoop install neovim
scoop install vcredist2022 neovide

scoop install ripgrep # For `:Rg` in fzf.vim, `live-grep` and `grep_string` in telescope
scoop install fd # (Optional) Alternative to `find` for `find_files` and `fd` in telescope (fairly certain)
scoop install perl # For `:Tags`, `:Helptags` in fzf.vim
scoop install universal-ctags # For tagbar
scoop install nodejs # For mason.nvim, so it can install tools

scoop install mingw gcc make # 90% sure /all/ are needed for telescope-fzf-native

# Install vim-plug (https://github.com/junegunn/vim-plug#windows-powershell-1)
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

# Install neovim plugins with vim-plug
nvim.exe +PlugInstall
