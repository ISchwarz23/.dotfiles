ZSH_CUSTOM ?= $(HOME)/.oh-my-zsh/custom


# Collection of setups
basic-setup: stow curl git oh-my-zsh nvim tmux tmux-xpanes yazi jq

web-dev-setup: basic-setup nvm node
dev-ops-setup: basic-setup podman kubectl

full-setup: web-dev-setup dev-ops-setup


# cURL

curl: install-curl

install-curl:
	@bash -c "./install-pkg.sh curl"


# Stow

stow: install-stow

install-stow:
	@bash -c "./install-pkg.sh stow"


# git

git: install-git configure-git

install-git:
	@bash -c "./install-pkg.sh git"

configure-git:
	@echo "   [INFO] configuring git..."
	@stow git
	@touch ~/.gitconfig-custom
	@echo "[SUCCESS] git configured!"

# yazi

yazi: install-yazi configure-yazi

install-yazi:
	@bash -c "./install-pkg.sh yazi"

configure-yazi:
	@echo "   [INFO] configuring yazi..."
	@stow yazi
	@echo "[SUCCESS] yazi configured!"


# jq

jq: install-jq

install-jq:
	@bash -c "./install-pkg.sh jq"


# zsh + oh-my-zsh

zsh: install-zsh configure-zsh

install-zsh:
	@bash -c "./install-pkg.sh zsh"

configure-zsh:
	@echo "   [INFO] configuring zsh..."
	@stow zsh
	@touch ~/.alias-custom
	@touch ~/.zshrc-custom
	@echo "[SUCCESS] zsh configured!"


oh-my-zsh: install-oh-my-zsh install-oh-my-zsh-plugins

install-oh-my-zsh: zsh
	@if [ ! -d ~/.oh-my-zsh ]; then \
		echo "   [INFO] installing oh-my-zsh..."; \
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" > /dev/null; \
		echo "[SUCCESS] oh-my-zsh installed!"; \
	else \
		echo "   [INFO] oh-my-zsh already installed, skipping..."; \
	fi


install-oh-my-zsh-plugins: install-oh-my-zsh install-oh-my-zsh-plugin-syntax-highlighting install-oh-my-zsh-plugin-auto-suggestions

install-oh-my-zsh-plugin-syntax-highlighting:
	@PLUGIN_NAME="zsh-syntax-highlighting"; \
	PLUGIN_URL="https://github.com/zsh-users/zsh-syntax-highlighting.git"; \
	PLUGIN_DIR="$(ZSH_CUSTOM)/plugins/zsh-syntax-highlighting"; \
	if [ ! -d "$$PLUGIN_DIR" ]; then \
		echo "   [INFO] installing oh-my-zsh $$PLUGIN_NAME..."; \
		git clone -q $$PLUGIN_URL $$PLUGIN_DIR; \
		sed -i.bak "s/plugins=(\(.*\))/plugins=(\1 $$PLUGIN_NAME/)" ~/.zshrc; \
		echo "[SUCCESS] oh-my-zsh $$PLUGIN_NAME installed!"; \
	else \
		echo "   [INFO] oh-my-zsh $$PLUGIN_NAME already installed, skipping."; \
	fi

install-oh-my-zsh-plugin-auto-suggestions:
	@PLUGIN_NAME="zsh-autosuggestions"; \
	PLUGIN_URL="https://github.com/zsh-users/zsh-autosuggestions.git"; \
	PLUGIN_DIR="$(ZSH_CUSTOM)/plugins/zsh-autosuggestions"; \
	if [ ! -d "$$PLUGIN_DIR" ]; then \
		echo "   [INFO] installing oh-my-zsh suggestions..."; \
		git clone -q $$PLUGIN_URL $$PLUGIN_DIR; \
		sed -i.bak "s/plugins=(\(.*\))/plugins=(\1 $$PLUGIN_NAME/)" ~/.zshrc; \
		echo "[SUCCESS] oh-my-zsh $$PLUGIN_NAME installed!"; \
	else \
		echo "   [INFO] oh-my-zsh $$PLUGIN_NAME already installed, skipping."; \
	fi

# nvim

nvim: install-nvim configure-nvim

install-nvim:
	@bash -c "./install-pkg.sh neovim"

configure-nvim:
	@echo "   [INFO] configuring nvim..."
	@stow nvim
	@echo "[SUCCESS] nvim configured!"


# tmux

tmux: install-tmux install-tpm configure-tmux

install-tmux:
	@bash -c "./install-pkg.sh tmux"

install-tpm: install-tmux
	@if [ ! -d ~/.tmux/plugins/tpm ]; then \
		echo "   [INFO] installing tmux plugin manager..."; \
		mkdir -p ~/.config/tmux/plugins; \
		git clone -q https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; \
		echo "[SUCCESS] tmux plugin manager installed!"; \
	else \
		echo "   [INFO] tmux plugin manager already installed, skipping."; \
	fi

configure-tmux:
	@echo "   [INFO] configuring tmux..."
	@stow tmux
	@echo "[SUCCESS] tmux configured!"


tmux-xpanes: tmux install-tmux-xpanes

install-tmux-xpanes: curl
	@if [ ! -f /usr/local/bin/xpanes ]; then \
		echo "   [INFO] installing tmux-xpanes..."; \
		curl -s https://raw.githubusercontent.com/greymd/tmux-xpanes/v4.2.0/bin/xpanes > ./xpanes; \
		sudo install -m 0755 xpanes /usr/local/bin/xpanes; \
		echo "[SUCCESS] tmux-xpanes installed!"; \
	else \
		echo "   [INFO] tmux-xpanes already installed, skipping."; \
	fi


# nvm

nvm: install-nvm

install-nvm: curl
	@if [ ! -d ~/.nvm ]; then \
		echo "   [INFO] installing nvm..."; \
		PROFILE=/dev/null bash -c "curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash > /dev/null 2>&1"; \
		echo "[SUCCESS] nvm installed!"; \
	else \
		echo "   [INFO] nvm already installed, skipping."; \
	fi


# node

node: install-node

install-node: nvm
	@echo "   [INFO] installing node..."
	@. ~/.nvm/nvm.sh && nvm install --lts --no-progress > /dev/null 2>&1
	@echo "[SUCCESS] node installed!"


# podman

podman: install-podman

install-podman:
	@bash -c "./install-pkg.sh podman"


# kubectl

kubectl: install-kubectl

install-kubectl: curl
	@if [ ! -f /usr/local/bin/kubectl ]; then \
		echo "   [INFO] installing kubectl..."; \
		curl -Os "https://dl.k8s.io/release/$$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"; \
		sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl > /dev/null; \
		rm -f kubectl; \
		echo "[SUCCESS] kubectl installed!"; \
	else \
		echo "   [INFO] kubectl already installed, skipping."; \
	fi

