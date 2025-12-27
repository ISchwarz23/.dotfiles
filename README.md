# .dotfiles

This repository contains all config files of tools in my personal setup. It uses `stow` for applying the dot-files via symlinks.  

## Installation

### Step 0

In case your system is behind a proxy, follow [this](./PROXY.md) instructions.

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

The tools are organized in setups. To install the tools with config on your system select one of the following setups.

```shell
make basic-setup
# or
make web-dev-setup
# or
make dev-ops-setup
# or
make full-setup
```

In case you want to install only specific tools with configs, you can do so by using the following commands:

```shell
make git
make zsh
# ...
```

> When you install specific tools only, the corresponsing dependencies will be installed as well (e.g. if you want to install a specific zsh plugin without zsh installed, then zsh will be installed first)

## To Do

- nix shell config
