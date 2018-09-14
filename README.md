# Setup

`apt get install stow`

Navigate to repository's directory, then `stow {directory}` to symlink configurations.


## Caveats

I don't know whether it's possible to stow these things or how to do it, so **do not** use `stow` on them:

- `touchpad`: it belongs in `/etc`
- `ckb-next` it's just a screenshot of my favorite configuration
- `compiz-config`: it's just a backup of my configurations
