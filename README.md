# Setup

1. Install `stow`: `sudo apt install stow`
2. Clone the repository.
3. Navigate to the repository's directory, then run `stow {directory}` to
    symlink the configurations in `{directory}`.


## Additional setup information

### `bash`

Delete `~/.bashrc` before stowing.

**Note:** I've included "(custom)" as a comment above things I've added or
modified in my `.bashrc` for easy searching.

### `backups`

Not meant to be symlinked; it contains files that either aren't configurations
or that must be imported into Windows programs.

### `git`

May need to delete `~/.gitconfig` before stowing.

Any repositories cloned after this setup should automatically be configured to
execute the commit hook.

To use the commit hook in repositories you cloned before setting up the hook,
navigate to their containing directories and run `git init`.

You can test that the commit hook is working by creating a new branch and
adding a commit to it. If the hook is working, the commit message should look
like `[branch_name] Commit message`.


### `caveats`

**Do not** use `stow` on anything in this directory.

- `touchpad-libinput-gestures`: contents belong in `/etc`

#### `touchpad-libinput-gestures` setup

Contents belong in `/etc`.

When you change the gestures, use `libinput-gestures-setup restart` to load them.

`libinput-gestures` contains the user-specific gestures;
`caveats/touchpad-libinput-gestures` contains the configurations needed to get Ubuntu
to recognize the touchpad (or something like that).


## To Do

- Look into `stow` parameters for symlinking to places like `etc`
