# .dotfiles

This repository contains all config files of tools in my personal setup. It uses `stow` for applying the dot-files via symlinks.  

## Installation

### Step 1

Clone this repo to your home directory.

```shell
cd ~ && git clone https://github.com/ISchwarz23/.dotfiles.git && cd .dotfiles
```

... or if you want to use ssh:
```shell
cd ~ && git clone git@github.com:ISchwarz23/.dotfiles.git && cd .dotfiles
```

### Step 2

Install the config for the tools you use on your system.

```shell
make
make basic-setup
```

In case you want to install only specific configs, you can do so by using the following commands:

```shell
make git
make zsh
# ...
```

> Please make sure you know what you are doing, when applying only specific configs, as there are some interdependencies.

## To Do

- nix shell config and alias
