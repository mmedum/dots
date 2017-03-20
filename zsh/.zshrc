

#
# User configuration sourced by interactive shells
#

# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

# Path
export SPARK_HOME=/opt/spark
export PYTHONPATH=$SPARK_HOME/python

# Aliases
alias vi='nvim'
alias vim='nvim'
