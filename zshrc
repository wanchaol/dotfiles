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

    # for uv
    source $HOME/.local/bin/env

elif [[ "$OS" == "Ubuntu" ]]; then
    alias ls="ls --color=auto"
    PATH="/usr/local/bin:$PATH"
fi

# common settings across OS

export PATH

eval "$(starship init zsh)"

# setting EDITOR would interfere with tmux status-keys
# export EDITOR=nvim
export GIT_EDITOR=nvim

# alias
alias vim="nvim"
alias vi="nvim"
alias g="git"
alias ta="tmux attach -t"
alias tns="tmux new-session -s"
alias tks="tmux kill-session -t"
alias tls="tmux ls"
alias tlk="tmux list-keys | less"


# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# END
# Below must be put in the end of zshrc!
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

