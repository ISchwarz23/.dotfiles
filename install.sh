#!/bin/bash

# constants
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# methods
function printOperation {
        echo -n "[ ] $1"
}

function printOperationResult {
    if [ $? == 0 ]; then
        echo -e "\r\033[K[${GREEN}✔${NC}] $1"
    else
        echo -e "\r\033[K[${RED}✘${NC}] $1"
    fi
}

# get git user information
git_name=`git config --global user.name`
git_email=`git config --global user.email`
if [ $? != 0 ]; then
    echo -n "Enter name for git: "
    read git_name
    echo -n "Enter email for git: "
    read git_email
fi

# force password input
sudo echo

# start of script
printOperation "update packages"
sudo apt-get -qq update &> /dev/null
printOperationResult "update packages"

printOperation "install base packages"
sudo apt-get -qq -y install curl zsh git &> /dev/null
printOperationResult "install base packages"

printOperation "update dotfiles"
git stash &> /dev/null
git pull &> /dev/null
git stash pop &> /dev/null | true
printOperationResult "update dotfiles"

printOperation "set zsh as default shell"
ln -sf $(pwd)/bashrc ~/.bashrc
printOperationResult "set zsh as default shell"

printOperation "configure zsh"
# syntax highlighting
[ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting &> /dev/null
chmod 711 ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
# suggestions
[ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ] || git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions &> /dev/null
chmod 711 ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
# themes
mkdir -p ~/.oh-my-zsh && mkdir -p ~/.oh-my-zsh/themes
ln -sf $(pwd)/oh-my-zsh/themes/* ~/.oh-my-zsh/themes/
# color fix
ln -sf $(pwd)/dircolors ~/.dircolors
# settings
ln -sf $(pwd)/zshrc ~/.zshrc
printOperationResult "configure zsh"

printOperation "configure git"
yes | cp -f $(pwd)/gitconfig ~/.gitconfig
git config --global user.name "$git_name"
git config --global user.email "$git_email"
printOperationResult "configure git"

printOperation "create alias for windows programs"
sudo ln -sf $(pwd)/bin/* /usr/bin/
printOperationResult "create alias for windows programs"

printOperation "create alias for windows folders"
win_username=`cmd.exe /C echo %username% | tr -cd "[0-9a-zA-Z]"`
rm -f ~/c
ln -sf /mnt/c ~/c
rm -f ~/projects
ln -sf /mnt/c/Users/$win_username/Projects ~/projects
rm -f ~/downloads
ln -sf /mnt/c/Users/$win_username/Downloads ~/downloads
rm -f ~/pictures
ln -sf /mnt/c/Users/$win_username/Pictures ~/pictures
printOperationResult "create alias for windows folders"

printOperation "install dev tools"
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - &> /dev/null
sudo apt-get install -qq -y nodejs &> /dev/null
sudo apt-get install -qq -y npm &> /dev/null
sudo apt-get install -qq -y python-pip &> /dev/null
printOperationResult "install dev tools"

printOperation "install other tools"
sudo apt-get install -qq -y screenfetch &> /dev/null
sudo apt-get install -qq -y cmatrix &> /dev/null
printOperationResult "install other tools"

printOperation "add custom scripts"
mkdir -p ~/.scripts
cp $(pwd)/scripts/* ~/.scripts/
printOperationResult "add custom scripts"
