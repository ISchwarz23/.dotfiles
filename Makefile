ZSH_CUSTOM ?= $(HOME)/.oh-my-zsh/custom


install: oh-my-zsh-plugins

oh-my-zsh-plugins: oh-my-zsh-plugin-syntax-highlighting oh-my-zsh-plugin-auto-suggestions

oh-my-zsh-plugin-syntax-highlighting:
	@PLUGIN_NAME="zsh-syntax-highlighting"; \
	PLUGIN_URL="https://github.com/zsh-users/zsh-syntax-highlighting.git"; \
	PLUGIN_DIR="$(ZSH_CUSTOM)/plugins/zsh-syntax-highlighting"; \
	if [ ! -d "$$PLUGIN_DIR" ]; then \
		git clone $$PLUGIN_URL $$PLUGIN_DIR; \
		sed -i.bak "s/plugins=(\(.*\))/plugins=(\1 $$PLUGIN_NAME/)" ~/.zshrc; \
	fi

oh-my-zsh-plugin-auto-suggestions:
	@PLUGIN_NAME="zsh-autosuggestions"; \
	PLUGIN_URL="https://github.com/zsh-users/zsh-autosuggestions.git"; \
	PLUGIN_DIR="$(ZSH_CUSTOM)/plugins/zsh-syntax-highlighting"; \
	if [ ! -d "$$PLUGIN_DIR" ]; then \
		git clone $$PLUGIN_URL $$PLUGIN_DIR; \
		sed -i.bak "s/plugins=(\(.*\))/plugins=(\1 $$PLUGIN_NAME/)" ~/.zshrc; \
	fi
