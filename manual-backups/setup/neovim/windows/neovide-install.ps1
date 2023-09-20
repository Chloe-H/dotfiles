# Alternate source for a lot of this: https://community.ops.io/aowendev/managing-packages-on-windows-with-scoop-411d

# Get current execution policy, in case you want to reset it after the install
Get-ExecutionPolicy -Scope CurrentUser

# Optional (kind of): Needed to run a remote script the first time
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Install scoop
irm get.scoop.sh | iex

# Add extras bucket
scoop install git
scoop bucket add extras

# Install neovim and neovide
scoop install neovim
scoop install vcredist2022
scoop install neovide

# Install vim-plug (https://github.com/junegunn/vim-plug#windows-powershell-1)
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

scoop install ripgrep # For `:Rg` in fzf.vim, `live-grep` in telescope
scoop install perl # For `:Tags`, `:Helptags` in fzf.vim
scoop install universal-ctags # For tagbar

# /All/ needed for telescope-fzf-native (90% sure)
# TODO: I've experienced weirdness around getting telescope-fzf-native working;
# I wasn't very careful when getting it fixed both times, but my best guess is
# that navigating to its directory in PowerShell and running `make` again fixes
# it? Or opening a new neovide instance to get the updated PATH? Or some
# combination of the two?
scoop install mingw
scoop install gcc
scoop install make

# TODO: reset execution policy (depending on the machine)
# Keeping in mind you need RemoteSigned to run scoop commands

# Install vim-plug
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
