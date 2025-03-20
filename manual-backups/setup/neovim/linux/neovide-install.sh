# TODO: Add sharkdp/fd? (https://github.com/sharkdp/fd#installation)

if [ -f /etc/os-release ]; then
    # Courtesy of https://askubuntu.com/a/459425
    # Extract OS identifier
    OS_ID=$(awk -F= '/^ID=/{print $2}' /etc/os-release)

    # Extract OS version number
    OS_VERSION_STR=$(awk -F= '/^VERSION_ID/{print $2}' /etc/os-release)
    # Convert OS version number into an integer
    OS_VERSION=$(echo ${OS_VERSION_STR/./} | bc)
    # Get major version
    OS_MAJOR_VERSION=${OS_VERSION_STR%.*}

    # OS: Ubuntu
    if [ ${OS_ID} == 'ubuntu' ]; then
        sudo apt-get install -y git

        # Install node, npm for mason.nvim (if nothing else)
        sudo apt install nodejs npm

        # Install ripgrep
        if [ ${OS_VERSION} -ge 1810 ]; then
            # Only works for Ubuntu 18.10+
            sudo apt-get install -y ripgrep
        else
            # Per https://github.com/BurntSushi/ripgrep#installation
            curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
            sudo dpkg -i ripgrep_13.0.0_amd64.deb
        fi

        # Install universal ctags
        # (Source: https://snapcraft.io/install/universal-ctags/ubuntu)
        if [ ${OS_VERSION} -lt 1604 ]; then
            # Older versions of Ubuntu don't have snap installed by default
            sudo apt install -y snapd
        fi

        sudo snap install universal-ctags # Untested

        # Finally, install neovim
        # If the installation fails, update the script according to
        # https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu
        sudo apt-get install -y ninja-build gettext cmake unzip curl
        setup_dir=$(pwd) # Save current directory, just in case it matters
        dev_dir="${HOME}/dev"
        mkdir -p ${dev_dir}
        cd ${dev_dir}
        git clone https://github.com/neovim/neovim
        cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=Release
        sudo make install
        cd ${setup_dir}
        unset dev_dir setup_dir

    # OS: Red Hat Enterprise Linux
    elif [ ${OS_ID} == 'rhel' ]; then # Everything in here is untested
        sudo yum install -y git

        # Install ripgrep
        sudo yum install -y yum-utils
        sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
        sudo yum install ripgrep

        # Install snap, node/npm
        # RHEL version >= 7
        if [ ${OS_MAJOR_VERSION} -ge 7 ]; then
            # Add the EPEL repository
            if [ ${OS_MAJOR_VERSION} -eq 8 ]; then
                sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
                sudo dnf upgrade
            elif [ ${OS_MAJOR_VERSION} -eq 7 ]; then
                sudo rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
            fi

            # Install node, npm for mason.nvim (if nothing else)
            sudo yum install nodejs npm

            # Add "optional" and "extras" repositories
            sudo subscription-manager repos --enable "rhel-*-optional-rpms" --enable "rhel-*-extras-rpms"
            sudo yum update

            # Install snap
            sudo yum install snapd

            # Enable the systemd unit that manages the main snap communication socket
            sudo systemctl enable --now snapd.socket

            # Enable classic snap support with a symbolic link from /var/lib/snapd/snap and /snap
            sudo ln -s /var/lib/snapd/snap /snap

            echo "Either log out and back in again or restart your system to ensure snap’s paths are updated correctly."
            echo "Once that's done, you can install the following:"
            echo " - universal ctags ('sudo snap install universal-ctags')"
            echo " - neovide ('sudo snap install neovide')"

        # RHEL version < 7
        else
            # No neovide for you

            # Install universal ctags the hard way
            setup_dir=$(pwd) # Save current directory, just in case it matters
            dev_dir="${HOME}/dev"
            mkdir -p ${dev_dir}
            cd ${dev_dir}
            git clone https://github.com/universal-ctags/ctags.git
            cd ctags
            ./autogen.sh
            ./configure # --prefix=/where/you/want # defaults to /usr/local
            make
            make install # may require extra privileges depending on where to install
            cd ${setup_dir}
            unset dev_dir setup_dir
        fi

        # Finally, install neovim
        sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
        sudo yum install -y neovim python3-neovim

        # Bonus: Install neovide (from https://neovide.dev/installation.html#linux)
        sudo dnf install fontconfig-devel freetype-devel @development-tools \
            libstdc++-static libstdc++-devel
        curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh
        cargo install --git https://github.com/neovide/neovide
    fi
fi


# Set up fzf for command-line completion
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Set up git completion
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

# Install vim-plug (Source: https://github.com/junegunn/vim-plug#unix-linux)
# If it doesn't work, see https://github.com/junegunn/vim-plug#installation
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim +PlugInstall +qall

echo "Neovim setup complete. You may need to restart your terminal."
