# Setup

**Bootstrapping by OS:**

- **Linux:** Use `manual-backups\setup\neovim\linux\neovide-install.sh` to
    bootstrap neovim (and, if possible, neovide).
- **Windows:** Use `manual-backups\setup\neovim\windows\neovide-install.ps1` to
    boostrap **the entire setup**, including neovim and neovide, **prior to
    cloning this repo.**
    - At minimum, get through the git installation before cloning
    - I haven't yet gotten the script to _run_ on Windows, so just copy/paste
        commands for now

In any case, update each script as needed after each usage.

Before setting up an SSH key to clone the repo, check the contents of `ssh/` for
the appropriate key file name.

## Linux
(Ubuntu, usually)

1. Install `stow`(e.g. `sudo apt install stow`)
2. Clone this repository to your home directory.
3. Navigate to the repository's directory, then run `stow {directory}` to
    symlink the configurations in `{directory}`.
    - Symlinks can't target existing files/directories, so if you run into any
        errors when stowing, it's likely because one or more of the targets
        already exist
    - Exceptions:
        - [`libinput-gestures-touchpad-config`](#libinput-gestures--libinput-gestures-touchpad-config)
        - [`manual-backups`](#manual-backups)

## Additional software

### `tree`

- **Install:** `sudo apt install tree`

### Auto-completion

#### `fzf`

- **Install:**
    ```sh
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
    ```
    - Accept fuzzy auto-completion and key bindings
    - Updates to shell configuration file shouldn't be necessary; check
    `.bashrc_extended`

`Ctrl + R` or start typing to auto complete

#### `git` completion

- **Install:** Download `git-completion.bash`, as needed:
    ```sh
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
    ```
    - It's probably safest to replace `master` in the above command with your
    installed version (e.g. `v2.39.1`)

### Python virtual environment manager and wrapper

- **Install:** `sudo { pip3 | pip } install virtualenv virtualenvwrapper`
    - Additional setup is already in `.bashrc`
<!-- TODO: Is `sudo` okay and/or necessary? -->

### Vim 8.2+

⚠️ Unmaintained now that I've fully embraced Neovim ⚠️

**Install** for distros that are behind the times:
1. `sudo add-apt-repository ppa:jonathonf/vim`
1. `sudo apt update`
1. `sudo apt install vim`

[Source](https://tipsonubuntu.com/2016/09/13/vim-8-0-released-install-ubuntu-16-04/)

**Finally,** clone my [Vim setup repo](https://bitbucket.org/ChloeH/vim-setup/)
and follow the instructions in the README.

# Rundown of stowables

## `libinput-gestures` / `libinput-gestures-touchpad-config`

- **Install:** [GitHub](https://github.com/bulletmark/libinput-gestures)

**Notes:**
- Stow `libinput-gestures-touchpad-config` with
`sudo stow --target=/etc libinput-gestures-touchpad-config`
- Stow `libinput-gestures` like normal
- When you change the gestures, use `libinput-gestures-setup restart` to load
them

## `bash`

(Probably) platform-agnostic configurations.

Work-specific configurations should be added in `~/.bashrc_work`, which will be
sourced by `.bashrc`.

### `bash-ubuntu`

Bash configurations for Ubuntu systems.
Automatically sourced by `.bashrc`.

### `bash-rhel`

Bash configurations for Red Hat Enterprise Linux systems.
Automatically sourced by `.bashrc`.

## `git`

### `.git-templates`

When the hook is working, commit messages on non-`main` branches will start
with `[<branch name>]`

- **Note:** Run `git init` in repositories cloned before setting up the hook to
update them to use it

#### Setting up the commit hook manually

1. Copy the `.git-templates` directory to your home directory (or somewhere
    else, if you're a degenerate).
1. Run `git config --global init.templatedir "path/to/.git-templates"` to update
    your git config.

If you make any changes to an existing global hook, [`git init` will not
overwrite the hook defined in your git repo](https://coderwall.com/p/jp7d5q/create-a-global-git-commit-hook).
You just gotta delete the offending file(s) from the local repo before
running `git init`.

## `neovim`

**Setup scripts:** `manual-backups/setup/neovim/`

⚠️ The setup scripts are not guaranteed to be fully tested! ⚠️

## `powershell`

**Symlinking on Windows:** In an elevated PowerShell terminal at the repo's
root, run
```powershell
New-Item -ItemType Directory -Path $env:USERPROFILE\Documents\WindowsPowerShell\

New-Item -ItemType SymbolicLink `
    -Path $env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 `
    -Target .\powershell\.config\powershell\Microsoft.PowerShell_profile.ps1
```

⚠️ The current stow path (everything after `dotfiles/powershell/`) is untested! ⚠️

## `ssh`

**Recommendation:** Don't put passwords on SSH keys. I haven't yet taken the
time to figure out how to avoid the password prompt *every time* I want to use a
password-protected key.

- **Pro:** I won't have to fiddle with SSH settings going forward
- **Con:** SSH key file names for GitHub and BitBucket are hardcoded

## `tmux`

- **Install:** [GitHub wiki](https://github.com/tmux/tmux/wiki)

**Win11:** Seems like I have to manually install and update the plugins for some
reason ([instructions](https://github.com/tmux-plugins/tpm#key-bindings)).

## `youtube-dl`

- **Install:** [Homepage](https://ytdl-org.github.io/youtube-dl/index.html)

**Note** [this outstanding issue](https://github.com/ytdl-org/youtube-dl/issues/31530)

[yt-dlp](#yt-dlp) is actively maintained and more consistently functional
nowadays, so it should probably be your go-to. As nice as youtube-dlg is, my
`youtube-dl` config will only get more out of date with time.

## `yt-dlp`

- **Install:** [GitHub](https://github.com/yt-dlp/yt-dlp)

# `manual-backups`

<!-- TODO: Move more of these to stowable directories and add symlinking instructions for Windows -->

I've put these in their own section because they don't actually fit the `stow`
model.

- `fonts/`: Font hoarding
    - **Favorites:**
        - **OneNote:**
            - **Default:** `Ubuntu Nerd Font Light`, 11.5 pt
                - Configurable in options, but only changes "Normal" style
            - **Code:** `UbuntuMono Nerd Font Mono`
        - **MobaXterm:** `DejaVuSansM Nerd Font Mono`, 12 pt
            - Go-to font for Neovim, broadly
    - **Resources:**
        - [Nerd Fonts](https://www.nerdfonts.com/font-downloads): Fonts with
        extra symbols added in; necessary for fancy status lines in, e.g., tmux
        and Vim/Neovim
        - Fonts and sites recommended by friends:
            - [Victor Mono](https://rubjo.github.io/victor-mono/)
            - [Go fonts - The Go Programming
            Language](https://go.dev/blog/go-fonts)
            - [Equity ‹ MB Type](https://mbtype.com/fonts/equity/)
- `scripts/`: General purpose scripts
- `setup/`: Scripts for automating setup for software (e.g. installing
dependencies)
- `software/`: Configurations for software whose setup I have not automated,
whether due to lack of bandwidth or infeasibility
    - `copy-to/`: Manually copy the contents of each the top-level directories to
    the respective locations provided [below](#softwarecopy-to)
    - `import/`: Import directories' contents into the respective software
        - **Installs:**
            - [Indicator Stickynotes](https://github.com/umangv/indicator-stickynotes)
            - [OneNote 2016](https://www.onenote.com/download)
            - [ShareX](https://getsharex.com/downloads)

## `software/copy-to`

### `autohotkey`

1. Download v1.1 of [AutoHotKey](https://www.autohotkey.com/).
1. Clone [VD.ahk](https://github.com/FuPeiJiang/VD.ahk). This is an
AutoHotKey library that adds several script functions for managing virtual
desktops.
1. Copy (or, WSL permitting, symlink) your script into the cloned directory.
1. Double-click the script to run it.
1. To make sure the script runs on every Windows startup, create a shortcut
to it in the Startup programs folder. Open that folder by entering
`shell:startup` in Run (`Win + R`). (I name the shortcut `Move To Desktop (AHK)`).

**Source:** [SuperUser](https://superuser.com/a/1728476),
[Evernote](https://www.evernote.com/client/web#?n=e941401f-0437-46e0-b902-7f607e509a41&)

### `move-to-desktop`

- **Install:** [Move To Desktop](https://github.com/Eun/MoveToDesktop/releases)
    - Make sure to set up
    [the scheduled task](https://github.com/Eun/MoveToDesktop/blob/master/help/scheduled-tasks.md)
    as well
- **Destination:** `%AppData%`

**Win11:** Move To Desktop doesn't seem to work; use [AutoHotKey](#autohotkey)
instead.

### `sublime-text-2`

- **Install:** [Sublime Text 2](https://www.sublimetext.com/2)
- **Destination:** `C:\Users\%USERNAME%\AppData\Roaming\Sublime Text 2\Packages\User\Preferences.sublime-settings`
