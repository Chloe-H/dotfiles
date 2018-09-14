# Setup

`apt get install stow`

Navigate to repository's directory, then `stow {directory}` to symlink configurations.


DO NOT stow `touchpad`: it belongs in `/etc`, and I haven't figured out whether it's even possible to stow that, much less how to do it.
