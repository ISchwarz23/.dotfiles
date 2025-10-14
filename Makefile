ZSH_CUSTOM ?= $(HOME)/.oh-my-zsh/custom


# Collection of setups
basic-setup: stow curl git zsh nvim jq

web-dev-setup: basic-setup nvm node
dev-ops-setup: basic-setup podman kubectl

full-setup: web-dev-setup dev-ops-setup


# cURL

curl: install-curl

install-curl:
	@bash -c "./install.sh curl"


# Stow

stow: install-stow

install-stow:
	@bash -c "./install.sh stow"


# git

git: install-git configure-git

install-git:
	@bash -c "./install.sh git"

configure-git:
	@stow git
	@touch ~/.gitconfig-custom


# jq

jq: install-jq

install-jq:
	@bash -c "./install.sh jq"


# zsh + oh-my-zsh

zsh: install-zsh configure-zsh

install-zsh:
	@bash -c "./install.sh zsh"

configure-zsh:
	@stow zsh
	@touch ~/.alias-custom
	@touch ~/.zshrc-custom


oh-my-zsh: install-oh-my-zsh install-oh-my-zsh-plugins

install-oh-my-zsh: zsh
	@sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

install-oh-my-zsh-plugins: install-oh-my-zsh install-oh-my-zsh-plugin-syntax-highlighting install-oh-my-zsh-plugin-auto-suggestions

install-oh-my-zsh-plugin-syntax-highlighting:
	@PLUGIN_NAME="zsh-syntax-highlighting"; \
	PLUGIN_URL="https://github.com/zsh-users/zsh-syntax-highlighting.git"; \
	PLUGIN_DIR="$(ZSH_CUSTOM)/plugins/zsh-syntax-highlighting"; \
	if [ ! -d "$$PLUGIN_DIR" ]; then \
		git clone $$PLUGIN_URL $$PLUGIN_DIR; \
		sed -i.bak "s/plugins=(\(.*\))/plugins=(\1 $$PLUGIN_NAME/)" ~/.zshrc; \
	fi

install-oh-my-zsh-plugin-auto-suggestions:
	@PLUGIN_NAME="zsh-autosuggestions"; \
	PLUGIN_URL="https://github.com/zsh-users/zsh-autosuggestions.git"; \
	PLUGIN_DIR="$(ZSH_CUSTOM)/plugins/zsh-autosuggestions"; \
	if [ ! -d "$$PLUGIN_DIR" ]; then \
		git clone $$PLUGIN_URL $$PLUGIN_DIR; \
		sed -i.bak "s/plugins=(\(.*\))/plugins=(\1 $$PLUGIN_NAME/)" ~/.zshrc; \
	fi

# nvim

nvim: install-nvim configure-nvim

install-nvim:
	@bash -c "./install.sh neovim"

configure-nvim:
	@stow nvim


# nvm

nvm: install-nvm

install-nvm: curl
	@curl -s https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash > /dev/null


# node

node: install-node

install-node: nvm
	. ~/.nvm/nvm.sh && nvm install --lts


# podman

podman: install-podman

install-podman:
	@bash -c "./install.sh podman"


# kubectl

podman: install-kubectl

install-kubectl: curl
	@curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

