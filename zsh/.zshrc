source ~/.zplug/init.zsh


# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# Path
export SPARK_HOME=/opt/spark
export PYTHONPATH=$SPARK_HOME/python
export PATH=/home/mark/.gem/ruby/2.4.0/bin:$PATH
# Editor
export EDITOR=vi

# Aliases
alias vi='nvim'
alias vim='nvim'

alias vpn_connect='sudo vpnc JPPOL --local-port 1024'
alias vpn_disconnect='sudo pkill vpnc'

# Zplug
zplug "plugins/git",   from:oh-my-zsh
zplug "mafredri/zsh-async", from:github
zplug "plugins/git", from:oh-my-zsh, if:"hash git"
zplug "modules/utility",    from:prezto
zplug "zsh-users/zsh-completions", from:github, defer:3
zplug "zsh-users/zsh-autosuggestions", from:github, defer:3
zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:3
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

zstyle ':prezto:module:utility:ls'    color 'yes'
zstyle ':prezto:module:utility:diff'  color 'yes'
zstyle ':prezto:module:utility:wdiff' color 'yes'
zstyle ':prezto:module:utility:make'  color 'yes'



PURE_PROMPT_SYMBOL='>>'
PURE_GIT_UP_ARROW='↑'
PURE_GIT_DOWN_ARROW='↓'


zplug load
