#!/bin/bash

# Step 1: download tools
install_zsh_users_plugins() {
    echo "installing $1"
    git clone https://github.com/zsh-users/$1.git ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/$1
}
    
if [[ -z "${ZSH}" ]]
then
    echo "installing Oh-My-ZSH"
    ZSH=${HOME}/.oh-my-zsh sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh); exit"
    install_zsh_users_plugins zsh-autosuggestions
    install_zsh_users_plugins zsh-syntax-highlighting
else
    echo "Oh-My-ZSH was already installed, skipping"
fi

if [[ ! -d "${HOME}/.tmux" ]]
then
    echo "Downloading tmux configs from github"
    git clone https://github.com/ruihangdu/.tmux.git ${HOME}/.tmux
else
    while true; do
        read -p "${HOME}/.tmux directory already exists. Do you wish to overwrite it?" yn
        case $yn in
            [Yy]* ) rm -rf ${HOME}/.tmux && git clone https://github.com/ruihangdu/.tmux.git ${HOME}/.tmux; break;;
            [Nn]* ) echo "Skipping .tmux setup"; break;;
            * ) echo "Please answer [Yy]/[Nn]";;
        esac
    done
fi

if [ ! -L "${HOME}/.tmux.conf" ]
then
    ln -s ${HOME}/.tmux/.tmux.conf ${HOME}/.tmux.conf
fi

# Step 2: Install packages
install_package_if_not_installed() {
    if ! type $1 > /dev/null 2>&1; then
        echo "installing $1"
        sudo apt install $1
    else
        echo "Package $1 already installed."
    fi
}

install_convenience_packages() {
    install_package_if_not_installed stow
    install_package_if_not_installed bat

    if [ ! -d "{HOME}/.local/bin" ]; then
        mkdir -p ${HOME}/.local/bin
        ln -s /usr/bin/batcat ${HOME}/.local/bin/bat
    fi
}

while true; do
    read -p "Do you have sudo access to this machine?" yn
    case $yn in
        [Yy]* ) install_convenience_packages; break;;
        [Nn]* ) echo "Skipping installing convenience packages"; break;;
        * ) echo "Please answer [Yy]/[Nn]";;
    esac
done

# Step 3: Clean up previous dotfiles
dotfiles=("${HOME}/.zshrc", "${HOME}/.zsh_functions", "${HOME}/.vimrc", "${HOME}/.vim")
for dotfile in "${dotfiles[@]}"
do
    if [ -e ${dotfile} ]
    then
        rm -rfv ${dotfile}
    fi
done

# Step 4: Unpack dotfiles to home dir
stow -t ${HOME} vim zsh
