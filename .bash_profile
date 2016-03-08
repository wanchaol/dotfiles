export CLICOLOR=1

export CLASSPATH=~/Documents/JavaLibs/'*':.

export PATH="/usr/local/sbin:$PATH"

source /usr/local/bin/virtualenvwrapper.sh
source ~/.profile

if which jenv > /dev/null; then eval "$(jenv init -)"; fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
