#!/bin/bash

# constants
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# get script dir
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

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
sudo yum -y update &> /dev/null
printOperationResult "update packages"

printOperation "install base packages"
sudo yum -y install curl dos2unix zsh oh-my-zsh git &> /dev/null
printOperationResult "install base packages"

printOperation "update dotfiles"
#git stash &> /dev/null
#git pull &> /dev/null
#git stash pop &> /dev/null | true
printOperationResult "update dotfiles"

printOperation "set zsh as default shell"
ln -sf $DIR/bashrc ~/.bashrc
printOperationResult "set zsh as default shell"

printOperation "configure zsh"
# install oh-my-zsh
curl -Lo install-zsh.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh &> /dev/null
sh install-zsh.sh --unattended &> /dev/null
rm -f install-zsh.sh
# syntax highlighting
[ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting &> /dev/null
chmod 711 ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
# suggestions
[ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ] || git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions &> /dev/null
chmod 711 ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
# themes
mkdir -p ~/.oh-my-zsh && mkdir -p ~/.oh-my-zsh/themes
ln -sf $DIR/oh-my-zsh/themes/* ~/.oh-my-zsh/themes/
# settings
rm ~/.zshrc
ln -sf $DIR/zshrc ~/.zshrc
printOperationResult "configure zsh"

printOperation "configure git"
yes | cp -f $DIR/gitconfig ~/.gitconfig
git config --global user.name "$git_name"
git config --global user.email "$git_email"
printOperationResult "configure git"

printOperation "install web-dev tools"
sudo yum install -y gcc-c++ make &> /dev/null
curl -sL https://rpm.nodesource.com/setup_10.x | sudo -E bash - &> /dev/null
sudo yum install -y nodejs &> /dev/null
printOperationResult "install web-dev tools"

