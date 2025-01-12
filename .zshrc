# export ZSH alias
export ZSH="$HOME/.oh-my-zsh"

# Set theme
ZSH_THEME="robbyrussell"

# Alias VIM and VI to NVIM
alias vi=nvim
alias vim=nvim

# Copy config and push to git
alias starvitz_copy_config="cp_dotfiles.sh"

# Export path
export PATH=$PATH:/home/starvitz/.local/bin

# Script
bindkey -s '^[[23~' 'fzf_nvim\n' 
bindkey '^@' autosuggest-accept

# Setup FZF
source <(fzf --zsh)

# Install all plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting sudo)

# Start oh my zsh
source $ZSH/oh-my-zsh.sh

# Start OhMyPosh with the catppuccin theme.
eval "$(oh-my-posh init zsh --config /home/starvitz/.oh-my-posh/catppuccin.omp.json)"
