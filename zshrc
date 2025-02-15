# Detect OS
if [[ "$(uname)" == "Darwin" ]]; then
    export OS="macOS"
elif [[ "$(uname)" == "Linux" ]] && grep -qi "ubuntu" /etc/os-release; then
    export OS="Ubuntu"
else
    export OS="Unknown"
fi

# OS-specific configurations
if [[ "$OS" == "macOS" ]]; then
    alias ls="ls -G"
    # macOS-specific settings

    # The next line updates PATH for the Google Cloud SDK.
    if [ -f '/Users/wanchaol/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/wanchaol/google-cloud-sdk/path.zsh.inc'; fi

    # The next line enables shell command completion for gcloud.
    if [ -f '/Users/wanchaol/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/wanchaol/google-cloud-sdk/completion.zsh.inc'; fi

    PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

    ZSH_SYNTAX="$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    ZSH_SUGGEST="$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

elif [[ "$OS" == "Ubuntu" ]]; then
    alias ls="ls --color=auto"
    PATH="/usr/local/bin:$PATH"
    # Ubuntu-specific settings
    ZSH_SYNTAX="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    ZSH_SUGGEST="/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# common settings across OS

export PATH

eval "$(starship init zsh)"

export EDITOR=nvim

# alias
alias vim="nvim"
alias vi="nvim"
alias g="git"

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# END
# Below must be put in the end of zshrc!
source $ZSH_SYNTAX
source $ZSH_SUGGEST
