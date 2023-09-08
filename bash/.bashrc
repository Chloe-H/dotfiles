# If anything for the current setup doesn't react well to being put in a
# different file, it can be housed here


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# My platform-agnostic, relatively modular customizations

if [ -f ~/.bashrc_extended ]; then
    . ~/.bashrc_extended
fi


# Distro-specific customizations

if [ -f ~/.bashrc_ubuntu ]; then
    . ~/.bashrc_ubuntu
elif [ -f ~/.bashrc_rhel ]; then
    . ~/.bashrc_rhel
fi
