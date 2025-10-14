ZSH_CUSTOM ?= $(HOME)/.oh-my-zsh/custom


# Collections
basics: stow curl git zsh nvim


# cURL

curl: install-curl

install-curl:
	@bash -c install.sh curl


# Stow

stow: install-stow

install-stow:
	@./install.sh stow


# git

git: install-git configure-git

install-git:
	@bash -c install.sh git

configure-git:
	@stow git
	@touch ~/.gitconfig-custom


# zsh + oh-my-zsh

zsh: install-zsh configure-zsh

install-zsh:
	@bash -c install.sh zsh

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
	@bash -c install.sh nvim

configure-nvim:
	@stow nvim

