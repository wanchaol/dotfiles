#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

autoload -U compinit
compinit

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## history
#setopt APPEND_HISTORY
## for sharing history between zsh processes
#setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY

## never ever beep ever
#setopt NO_BEEP

## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
#MAILCHECK=0

# autoload -U colors
#colors
#
#
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

## wanchaol
# added by Miniconda3 installer
. /home/wanchaol/local/conda/etc/profile.d/conda.sh
# default pytorch activation
conda deactivate
conda activate pt

# git/conda worktree related
PYTHON_VERSION=${1:-3}

# pytorch conda env management
alias mkenv="with-proxy conda create -y -p `pwd`-env --clone pt; conda activate `pwd`-env"
alias ca="conda activate `pwd`-env"
alias rmenv="conda env remove -p `pwd`-env"
alias gf='git-feature'
alias vim="~/bin/vim"

export EDITOR=~/bin/vim
export VISUAL=~/bin/vim

alias buildpt_dev_cpu="NO_CAFFE2_OPS=1 NO_CUDA=1 DEBUG=1 python setup.py develop"
alias buildptc2_dev_cpu="NO_CAFFE2_OPS=0 NO_CUDA=1 DEBUG=1 python setup.py develop"
alias buildpt_dev_gpu="CUDA=1 DEBUG=1 python setup.py develop"

export PATH=~/ccache/lib:/usr/local/cuda/bin:$PATH
export PATH=$HOME/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export CUDA_NVCC_EXECUTABLE=~/ccache/cuda/nvcc

# custom config for powerlevel9k zsh theme
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_folders

alias gdb='gdb -q'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
