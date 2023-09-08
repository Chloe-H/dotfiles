# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bashrc_extended ]; then
    . ~/.bashrc_extended
fi

if [ -f ~/.bashrc_ubuntu ]; then
    . ~/.bashrc_ubuntu
elif [ -f ~/.bashrc_rhel ]; then
    . ~/.bashrc_rhel
fi
