# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set theme
ZSH_THEME="robbyrussell-nix"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Prepare auto-start or attach tmux on SSH
tmux_ssh_autostart() {
  # Only run on SSH, not local shells
  if [[ -n "$SSH_CONNECTION" ]] && [[ -z "$TMUX" ]]; then
    local session_name="main"
    command -v tmux >/dev/null 2>&1 || return
    tmux has-session -t "$session_name" 2>/dev/null \
      && exec tmux attach-session -t "$session_name" \
      || exec tmux new-session -s "$session_name"
  fi
}

# Prepare NVM initializarion
nvm_init() {
  command -v nvm >/dev/null 2>&1 && return

  # Standard NVM directory
  export NVM_DIR="$HOME/.nvm"

  # Load nvm if it exists
  if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    source "$NVM_DIR/nvm.sh"
  fi

  # Load bash_completion for nvm
  if [[ -s "$NVM_DIR/bash_completion" ]]; then
    source "$NVM_DIR/bash_completion"
  fi
}

# User configuration
source ~/.zshrc-custom

# Aliases
source ~/.alias
source ~/.alias-custom

