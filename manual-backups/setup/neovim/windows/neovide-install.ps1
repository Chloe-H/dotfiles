# Alternate source for a lot of this: https://community.ops.io/aowendev/managing-packages-on-windows-with-scoop-411d

# Get current execution policy, in case you want to reset it after the install
Get-ExecutionPolicy -Scope CurrentUser

# Optional: Needed to run a remote script the first time
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

# Install vim-plug: https://github.com/junegunn/vim-plug#windows-powershell-1
# scoop install perl # For `:Tags`, `:Helptags` in fzf.vim
# scoop install universal-ctags # For tagbar

# TODO: reset execution policy (depending on the machine)
# Keeping in mind you need RemoteSigned to run scoop commands
