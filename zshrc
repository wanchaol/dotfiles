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
    # for uv
    PATH="$PATH:$HOME/.local/bin"
    source $HOME/.local/bin/env

elif [[ "$OS" == "Ubuntu" ]]; then
    alias ls="ls --color=auto"
    PATH="$PATH:$HOME/.local/bin"
fi

# common settings across OS

export PATH

# setting EDITOR would interfere with tmux status-keys
# export EDITOR=nvim
export GIT_EDITOR=hx

# alias
alias vim="hx"
alias vi="hx"
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

# zimfw related configs
ZIM_CONFIG_FILE=~/.config/zsh/zimrc
ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi
# Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# END
# Below must be put in the end of zshrc!
# source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
