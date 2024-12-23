# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

alias vim='nvim'
alias notes='nvim -c "Neorg workspace notes"'

export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:/home/starvitz/.local/bin
export PATH=$PATH:/home/starvitz/.local/scripts

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions sudo)

bindkey -s '^[[23~' 'fzf-nvim\n' 
bindkey -s '^[[23;2~' "tmux-windowizer\n"
bindkey -s '^F' 'tmux-sessionizer\n'
bindkey '^@' autosuggest-accept

# User configuration
export PATH=$PATH:/usr/local/go/bin
source $ZSH/oh-my-zsh.sh
source <(fzf --zsh)

# Set MANPAGER to use less with Vi keybindings
export MANPAGER="less -X"

# Optional: Set LESS options to fine-tune less behavior
export LESS='-RFX'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
