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

printOperation "pull dotfiles"
git stash &> /dev/null
git pull &> /dev/null
git stash pop &> /dev/null | true
printOperationResult "pull dotfiles"

printOperation "enable syntax highlighting"
[ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting &> /dev/null
chmod 711 ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
printOperationResult "enable syntax highlighting"

printOperation "enable suggestions"
[ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ] || git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions &> /dev/null
chmod 711 ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
printOperationResult "enable suggestions"

printOperation "install custom themes"
mkdir -p ~/.oh-my-zsh && mkdir -p ~/.oh-my-zsh/themes
ln -sf $(pwd)/oh-my-zsh/themes/* ~/.oh-my-zsh/themes/
printOperationResult "install custom themes"

printOperation "improve colors for dirs"
ln -sf $(pwd)/dircolors ~/.dircolors
printOperationResult "improve colors for dirs"

printOperation "apply settings"
ln -sf $(pwd)/zshrc ~/.zshrc
printOperationResult "apply settings"
