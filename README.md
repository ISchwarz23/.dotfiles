# .dotfiles

This repository contains all config files of tools in my personal setup. It uses `stow` for applying the dot-files via symlinks.  

## Structure

The repository contains multiple stow packages. Each package is a separate folder inside this dotfiles repo. This allows selecting and applying config for specific tools.

## Installation

### Step 0

To use the config from this dot-files repo, you need to have `stow` installed on your system.

### Step 1

Clone this repo to your home directory.

```shell
cd ~ && git clone https://github.com/ISchwarz23/.dotfiles.git && cd .dotfiles
```

### Step 2

Install the config for the tools you use on your system.

```shell
make
```

In case you want to install only specific configs, you can do so by using the following commands:

```shell
make git
make zsh
# ...
```

> Please make sure you know what you are doing, when applying only specific configs, as there are some interdependencies.

## To Do

- nvim config
- nix shell config and alias
