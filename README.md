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

### `caveats`

I don't know what I'm doing.

I know there is a flag that will let me correctly stow some of the
configurations in the `caveats` directory, but I haven't yet bothered to figure
out what it is and document it, so **do not** use `stow` on them for now.

- `git-commit-hooks`: doesn't seem to appreciate being symlinked
- `touchpad-libinput-gestures`: contents belong in `/etc`


#### `git-commit-hooks` setup

1. (Linux only) Run `chmod u+x ~/.git-templates/hooks/prepare-commit-msg` to
    make the script executable before copying it into the templates
    directory.
2. Copy the file into the templates directory:
    `cp git-commit-hooks/.git-templates/hooks/prepare-commit-msg ~/.git-templates/hooks/prepare-commit-msg`
3. Open the terminal you'll use git in and run
    `git config --global init.templatedir "~/.git-templates"`.
    - Alternatively, you might should get the same effect by stowing `git`.

Any repositories cloned after this setup should automatically be configured to
execute the commit hook.

To use the commit hook in repositories you cloned before setting up the hook,
navigate to their containing directories and run `git init`.

You can test that the commit hook is working by creating a new branch and
adding a commit to it. If the hook is working, the commit message should look
like `[branch_name] Commit message`.


#### `touchpad-libinput-gestures` setup

When you change the gestures, use `libinput-gestures-setup restart` to load them.


## To Do

- Try to resolve the caveats
    - Check out
    [this](https://stackoverflow.com/questions/4592838/symbolic-link-to-a-hook-in-git)
    to see whether there is a solution for the `git-commit-hook` symlink
    nonsense
    - Look into `stow` parameters for symlinking to places like `etc`
