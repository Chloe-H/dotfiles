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
        - [`backups`](#backups)

## Additional information

### `backups`

Manually copy contents of top-level to the locations provided below:

- `move-to-desktop`
    - [Move To Desktop](https://github.com/Eun/MoveToDesktop/releases)
    - **Destination:** `%AppData%`
- `sublime-text-2`
    - [Sublime Text 2](https://www.sublimetext.com/2)
    - **Destination:** `C:\Users\%USER%\AppData\Roaming\Sublime Text 2\Packages\User\Preferences.sublime-settings`

#### `import`

Import directory contents into their respective programs:

- `indictaor-stickynotes`
    - [Indicator Stickynotes](https://github.com/umangv/indicator-stickynotes)
- `onenote-2016`
    - [OneNote 2016](https://www.onenote.com/download)
- `sharex`
    - [ShareX](https://getsharex.com/downloads/)

### `bash`

I've included "(custom)" as a comment above things I've added or modified in my
`.bashrc` for easy searching.

### `git`

#### `.git-templates`

Any repositories cloned after this setup should automatically be configured to
execute the commit hook.

To use the commit hook in repositories you cloned before setting up the hook,
navigate to their containing directories and run `git init`.

You can test that the commit hook is working by creating a new branch and
adding a commit to it. If the hook is working, the commit message should look
like `[branch_name] Commit message`.

##### Setting up the commit hook manually

1. Copy the `.git-templates` directory to your home directory (or somewhere
    else, if you're a degenerate).
2. Run `git config --global init.templatedir "path/to/.git-templates"` to update
    your git config.

If you make any changes to an existing global hook, [`git init` will not
overwrite the hook defined in your git repo](https://coderwall.com/p/jp7d5q/create-a-global-git-commit-hook).
You just gotta delete the offending file(s) from the local repo before
running `git init`.

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
    `sudo { pip3 | pip } install virtualenv virtualenvwrapper`
    - Additional setup is already in `.bashrc`
    - **TODO:** is `sudo` okay and/or necessary?
- [Vim 8.2+](https://tipsonubuntu.com/2016/09/13/vim-8-0-released-install-ubuntu-16-04/):
    1. `sudo add-apt-repository ppa:jonathonf/vim`
    2. `sudo apt update`
    3. `sudo apt install vim`
    4. Clone down [Vim setup repo](https://bitbucket.org/ChloeH/vim-setup/)
        and follow the instructions in its README.
