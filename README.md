# Setup

1. Install `stow`: `sudo apt install stow`
2. Clone this repository to your home directory.
3. Navigate to the repository's directory, then run `stow {directory}` to
    symlink the configurations in `{directory}`.
    - Symlinks can't target existing files/directories, so if you run into any
        errors when stowing, it's likely because one or more of the targets
        already exist
    - Exceptions:
        - [`libinput-gestures-touchpad-config`](#libinput-gestures--libinput-gestures-touchpad-config)
        - [`manual-backups`](#manual-backups)

## Additional setup

- `tree`: `sudo apt-get install tree`
- Python virtual environment manager and wrapper:
    `sudo { pip3 | pip } install virtualenv virtualenvwrapper`
    - Additional setup is already in `.bashrc`
    - **TODO:** is `sudo` okay and/or necessary?
- [Vim 8.2+](https://tipsonubuntu.com/2016/09/13/vim-8-0-released-install-ubuntu-16-04/):
    1. `sudo add-apt-repository ppa:jonathonf/vim`
    2. `sudo apt update`
    3. `sudo apt install vim`
    4. Clone down [Vim setup repo](https://bitbucket.org/ChloeH/vim-setup/)
        and follow the instructions in its README.

### `libinput-gestures` / `libinput-gestures-touchpad-config`

[GitHub](https://github.com/bulletmark/libinput-gestures)

Stow `libinput-gestures-touchpad-config` with
`sudo stow --target=/etc libinput-gestures-touchpad-config`.

Stow `libinput-gestures` like normal.

When you change the gestures, use `libinput-gestures-setup restart` to load them.

## Additional information

### `bash`

Search for `(custom)` to find my additions to `.bashrc`.

### `git`

#### `.git-templates`

- Run `git init` in repositories cloned before setting up the hook to update
them to use it
- When the hook is working, commit messages on non-`main` branches will start
with `[<branch name>]`

##### Setting up the commit hook manually

1. Copy the `.git-templates` directory to your home directory (or somewhere
    else, if you're a degenerate).
2. Run `git config --global init.templatedir "path/to/.git-templates"` to update
    your git config.

If you make any changes to an existing global hook, [`git init` will not
overwrite the hook defined in your git repo](https://coderwall.com/p/jp7d5q/create-a-global-git-commit-hook).
You just gotta delete the offending file(s) from the local repo before
running `git init`.

### `git-work`

Git configuration(s) for work.

### `manual-backups`

#### `software`

##### `copy-to`

Manually copy contents of top-level to the locations provided below:

- `move-to-desktop`
    - [Move To Desktop](https://github.com/Eun/MoveToDesktop/releases)
    - **Destination:** `%AppData%`
- `powershell`
    - **Destination:** `C:\Users\%USERNAME%\Documents\WindowsPowerShell\`
    - `(custom)` denotes my additions
    - `(work)` denotes additions for work
- `sublime-text-2`
    - [Sublime Text 2](https://www.sublimetext.com/2)
    - **Destination:** `C:\Users\%USERNAME%\AppData\Roaming\Sublime Text 2\Packages\User\Preferences.sublime-settings`

##### `import`

Import directory contents into their respective programs:

- `indictaor-stickynotes`
    - [Indicator Stickynotes](https://github.com/umangv/indicator-stickynotes)
- `onenote-2016`
    - [OneNote 2016](https://www.onenote.com/download)
- `sharex`
    - [ShareX](https://getsharex.com/downloads/)

### `tmux`

[GitHub wiki](https://github.com/tmux/tmux/wiki)

### `youtube-dl`

[Homepage](https://ytdl-org.github.io/youtube-dl/index.html)

Replaced by [youtube-dlp](#yt-dlp).

### `yt-dlp`

[GitHub](https://github.com/yt-dlp/yt-dlp)
