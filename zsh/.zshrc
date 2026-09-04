export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="bira"

plugins=( 
    git
    dnf
    zsh-autosuggestions
    zsh-syntax-highlighting
    colored-man-pages
    npm
    nvm
)

source $ZSH/oh-my-zsh.sh
# fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Set-up icons for files/directories in terminal using lsd
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
