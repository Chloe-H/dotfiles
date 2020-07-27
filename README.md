# Setup

1. Install `stow`: `sudo apt install stow`
2. Clone this repository to your home directory.
3. Navigate to the repository's directory, then run `stow {directory}` to
    symlink the configurations in `{directory}`.
    - Exceptions:
        - [`libinput-gestures-touchpad-config`](#libinput-gestures--libinput-gestures-touchpad-config)
        - [`backups`](#backups)

## Additional information

### `backups`

Not meant to be symlinked; it contains files that either aren't configurations
or that must be imported into Windows programs.

- [JetBrains ReSharper](https://account.jetbrains.com/licenses)
- [Sublime Text 3](https://www.sublimetext.com/3)
- [Compiz Config](https://packages.ubuntu.com/search?keywords=compizconfig-settings-manager)
- [MoveToDesktop](https://github.com/Eun/MoveToDesktop/releases)
    - The configuration file belongs in `%AppData%`.
- [OneNote 2016](https://www.onenote.com/download)
- [ShareX](https://getsharex.com/downloads/)

### `bash`

Delete `~/.bashrc` before stowing.

**Note:** I've included "(custom)" as a comment above things I've added or
modified in my `.bashrc` for easy searching.

### `git`

May need to delete `~/.gitconfig` before stowing.

Any repositories cloned after this setup should automatically be configured to
execute the commit hook.

To use the commit hook in repositories you cloned before setting up the hook,
navigate to their containing directories and run `git init`.

You can test that the commit hook is working by creating a new branch and
adding a commit to it. If the hook is working, the commit message should look
like `[branch_name] Commit message`.

### `libinput-gestures` / `libinput-gestures-touchpad-config`

[GitHub](https://github.com/bulletmark/libinput-gestures)

Stow `libinput-gestures-touchpad-config` with
`sudo stow --target=/etc libinput-gestures-touchpad-config`.

Stow `libinput-gestures` like normal.

When you change the gestures, use `libinput-gestures-setup restart` to load them.

### `tmux`

[GitHub wiki](https://github.com/tmux/tmux/wiki)

### `youtube-dl`

[Homepage](https://ytdl-org.github.io/youtube-dl/index.html)

## Other stuff to install

- `tree`: `sudo apt-get install tree`
- Python virtual environment manager and wrapper:
    `sudo pip3 install virtualenv virtualenvwrapper`
    - Additional setup is already in `.bashrc`
- [Vim 8.2+](https://tipsonubuntu.com/2016/09/13/vim-8-0-released-install-ubuntu-16-04/):
    1. `sudo add-apt-repository ppa:jonathonf/vim`
    2. `sudo apt update`
    3. `sudo apt install vim`
    4. Clone down [Vim setup repo](https://bitbucket.org/ChloeH/vim-setup/src/master/)
        and follow the instructions.
