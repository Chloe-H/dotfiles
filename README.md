# Setup

`apt get install stow`

Navigate to repository's directory, then `stow {directory}` to symlink configurations.


## Additional Setup/Information

### libinput-gestures

When you change the gestures, use `libinput-gestures-setup restart` to load them.

### git-commit-hooks

**Copy, don't symlink**

On Linux, run `chmod +x ~/.git-templates/hooks/prepare-commit-msg` to make
the script executable before running the command above.

Open Powershell or bash and enter
`git config --global init.templatedir "~/.git-templates"`.

Any repositories cloned after this setup should automatically be configured to
execute the commit hook. To use the commit hook in repositories you cloned before
setting up the hook, navigate to their containing directories and run `git init`.

You can test that the commit hook is working by creating a new branch and
adding a commit to it. If the hook is working, the commit message should look
like `[branch_name] Commit message`.


## Caveats

I've only tried this on Ubuntu 16.04, and I don't know what I'm doing.

I don't know whether it's possible to stow these things or how to do it, so **do not** use `stow` on them:

- `git-commit-hooks`: doesn't seem to appreciate being symlinked
- `touchpad`: it belongs in `/etc`
- `ckb-next` it's just a screenshot of my favorite configuration
- `compiz-config`: it's just a backup of my configurations

## To Do

- Remove all this bs from Google Drive once it's shown to work smoothly using `stow`
- Add links to helpful pages for each configuration
- Try to automate stowing
- Maintain separate branches for different machines
