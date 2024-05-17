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

## Additional software

### `tree`

- **Install:** `sudo apt install tree`

### Python virtual environment manager and wrapper

- **Install:** `sudo { pip3 | pip } install virtualenv virtualenvwrapper`
    - Additional setup is already in `.bashrc`
    - **TODO:** is `sudo` okay and/or necessary?

### Vim 8.2+

**Install** for distros that are behind the times:
1. `sudo add-apt-repository ppa:jonathonf/vim`
1. `sudo apt update`
1. `sudo apt install vim`

[Source](https://tipsonubuntu.com/2016/09/13/vim-8-0-released-install-ubuntu-16-04/)

**Finally,** clone down [Vim setup repo](https://bitbucket.org/ChloeH/vim-setup/)
and follow the instructions in the README.

# Rundown of stowables

## `libinput-gestures` / `libinput-gestures-touchpad-config`

- **Install:** [GitHub](https://github.com/bulletmark/libinput-gestures)

**Notes:**
- Stow `libinput-gestures-touchpad-config` with
`sudo stow --target=/etc libinput-gestures-touchpad-config`.
- Stow `libinput-gestures` like normal.
- When you change the gestures, use `libinput-gestures-setup restart` to load
them.

## `bash`

(Relatively) platform-agnostic configurations.

Search for `(custom)` to find my additions to an otherwise generalized bash
script file.

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
update them to use it.

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

**Setup script:** `manual-backups/setup/neovim/linux/neovide-install.sh`

Ground-up `init.lua`, by which I mean a Neovim/Neovide configuration file that
I am making from scratch. At time of writing, my intention is to make something
that (at least *probably*) works on Windows, native Ubuntu, and Ubuntu in WSL.

I haven't _fully_ tested my setup script, but I've done my best to account for
various versions of Ubuntu and RHEL.

## `ssh`

**Recommendation:** Don't put passwords on SSH keys. I haven't yet taken the
time to figure out how to avoid the password prompt *every time* I want to use a
password-protected key.

- **Pro:** I won't have to fiddle with SSH settings going forward.
- **Con:** SSH key file names for GitHub and BitBucket are hardcoded.

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

I've put these in their own section because they don't actually fit the `stow`
model.

- `software`: I may, one day, put scripts or other such things in this repo.
Hence, this folder, which I made when I did exactly that, long ago.
    - `copy-to`: Manually copy the contents of each the top-level directories to
    the respective locations provided [below](#softwarecopy-to).
    - `import`: Import directories' contents into their namesake programs.
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

### `powershell`

- **Destination:** `C:\Users\%USERNAME%\Documents\WindowsPowerShell\`

TODO: Move it to the top level and add symlinking instructions

**Notes:**
- `(custom)` denotes my additions
- `(work)` denotes additions for work

### `sublime-text-2`

- **Install:** [Sublime Text 2](https://www.sublimetext.com/2)
- **Destination:** `C:\Users\%USERNAME%\AppData\Roaming\Sublime Text 2\Packages\User\Preferences.sublime-settings`
