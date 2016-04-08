export CLICOLOR=1

export CLASSPATH=~/Documents/JavaLibs/'*':.

export PATH="/usr/local/sbin:$PATH"

source /usr/local/bin/virtualenvwrapper.sh
source ~/.profile

if which jenv > /dev/null; then eval "$(jenv init -)"; fi

#export HD_HOME=~/tools/hd
export JAVA_HOME="$(/usr/libexec/java_home)"

export BOOST_VERSION=1.60.0_1
export BOOST_HOME=/usr/local/Cellar/boost/${BOOST_VERSION}
export EIGEN_VERSION=3.2.8
export EIGEN_HOME=/usr/local/Cellar/eigen/${EIGEN_VERSION}/include/eigen3/  

export HADOOP_VERSION=2.7.2
export HADOOP_BASE=/usr/local/Cellar/hadoop/${HADOOP_VERSION}
export HADOOP_HOME=${HADOOP_BASE}/libexec

export HBASE_VERSION=1.1.2
export HBASE_HOME=/usr/local/Cellar/hbase/${HBASE_VERSION}/libexec
export HBASE_CONF_DIR=$HBASE_HOME/conf

alias hstart="/usr/local/Cellar/hadoop/${HADOOP_VERSION}/sbin/start-dfs.sh;/usr/local/Cellar/hadoop/${HADOOP_VERSION}/sbin/start-yarn.sh"
alias hstop="/usr/local/Cellar/hadoop/${HADOOP_VERSION}/sbin/stop-yarn.sh;/usr/local/Cellar/hadoop/${HADOOP_VERSION}/sbin/stop-dfs.sh"
alias hbstart="/usr/local/Cellar/hbase/${HBASE_VERSION}/bin/start-hbase.sh"
alias hbstop="/usr/local/Cellar/hbase/${HBASE_VERSION}/bin/stop-hbase.sh"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
