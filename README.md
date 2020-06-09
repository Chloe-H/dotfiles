# Setup

`sudo apt install stow`

Navigate to repository's directory, then `stow {directory}` to symlink configurations.


## Additional Setup/Information

### Caveats

I've only tried this on Ubuntu 16.04, and I don't know what I'm doing.

I know there is a flag that will let me correctly stow these, but I haven't yet
bothered to figure out what it is and document it, so **do not** use `stow` on
them for now:

- `git-commit-hooks`: doesn't seem to appreciate being symlinked
- `touchpad`: it belongs in `/etc`

### libinput-gestures

When you change the gestures, use `libinput-gestures-setup restart` to load them.

### git-commit-hooks

**Copy, don't symlink**

`cp git-commit-hooks/.git-templates/hooks/prepare-commit-msg ~/.git-templates/hooks/prepare-commit-msg`

On Linux, run `chmod +x ~/.git-templates/hooks/prepare-commit-msg` to make
the script executable before running the command above.

Open Powershell or bash and enter
`git config --global init.templatedir "~/.git-templates"`.
Alternatively, you might should get the same effect by stowing `git`.

Any repositories cloned after this setup should automatically be configured to
execute the commit hook. To use the commit hook in repositories you cloned before
setting up the hook, navigate to their containing directories and run `git init`.

You can test that the commit hook is working by creating a new branch and
adding a commit to it. If the hook is working, the commit message should look
like `[branch_name] Commit message`.

### SSH

After stowing the config file, I got a message from git saying "Bad owner or permissions on ~/.ssh/config".
I had to run the following commands to fix the issue:

`chown $USER ~/.ssh/config`

`chmod 644 ~/.ssh/config`

[Source](https://serverfault.com/a/710453)


## To Do

- Add a script or something for git exclude files
- Add Vim setup as a submodule
- Add links to helpful pages for each configuration
- Try to resolve the caveats
    - Check out
    [this](https://stackoverflow.com/questions/4592838/symbolic-link-to-a-hook-in-git)
    to see whether there is a solution for the `git-commit-hook` symlink
    nonsense

