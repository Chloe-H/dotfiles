# Setup

`apt get install stow`

Navigate to repository's directory, then `stow {directory}` to symlink configurations.


## libinput-gestures

When you change the gestures, use `libinput-gestures-setup restart` to load them.


## Caveats

I don't know whether it's possible to stow these things or how to do it, so **do not** use `stow` on them:

- `touchpad`: it belongs in `/etc`
- `ckb-next` it's just a screenshot of my favorite configuration
- `compiz-config`: it's just a backup of my configurations

## To Do

- Remove all this bs from Google Drive once it's shown to work smoothly using `stow`
- Add `gpom` alias to `.bashrc`
- Add links to helpful pages for each configuration
