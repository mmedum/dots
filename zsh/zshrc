# zsh_unplugged
##? Clone a plugin, identify its init file, source it, and add it to your fpath.
function plugin-load {
  local repo plugdir initfile initfiles=()
  : ${ZPLUGINDIR:=${ZDOTDIR:-~/.config/zsh}/plugins}
  for repo in $@; do
    plugdir=$ZPLUGINDIR/${repo:t}
    initfile=$plugdir/${repo:t}.plugin.zsh
    if [[ ! -d $plugdir ]]; then
      echo "Cloning $repo..."
      git clone -q --depth 1 --recursive --shallow-submodules \
        https://github.com/$repo $plugdir
    fi
    if [[ ! -e $initfile ]]; then
      initfiles=($plugdir/*.{plugin.zsh,zsh-theme,zsh,sh}(N))
      (( $#initfiles )) || { echo >&2 "No init file found '$repo'." && continue }
      ln -sf $initfiles[1] $initfile
    fi
    fpath+=$plugdir
    (( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
  done
}

function plugin-update {
  ZPLUGINDIR=${ZPLUGINDIR:-$HOME/.config/zsh/plugins}
  for d in $ZPLUGINDIR/*/.git(/); do
    echo "Updating ${d:h:t}..."
    command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash
  done
}

# Completions engine
autoload -Uz compinit && compinit

#Always use vi mode in zsh
#bindkey -v
#export KEYTIMEOUT=1

# Use nvim editor
export EDITOR="nvim"
export VISUAL="nvim"

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
# Share history between all sessions.
setopt share_history 
# Treat the '!' character specially during expansion.
setopt bang_hist 
# Add new commands to history
setopt append_history 
# Write to the history file immediately, not when the shell exits.
setopt inc_append_history 
# Write the history file in the ":start:elapsed;command" format.
setopt extended_history 
# Expire duplicate entries first when trimming history.
setopt hist_expire_dups_first 
# Don't record an entry that was just recorded again.
setopt hist_ignore_dups 
# Ignore duplicate commands in history
setopt hist_ignore_all_dups
# Do not display a line previously found.
setopt hist_find_no_dups
# Ignore entry starting with space
setopt hist_ignore_space
# Don't write duplicate entries in the history file.
setopt hist_save_no_dups 
# Remove superfluous blanks before recording entry.
setopt hist_reduce_blanks 

# Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# Alias for lsd
if command -v "lsd" &> /dev/null; then
    lsd_cmd="lsd"
    alias ls="$lsd_cmd"
    alias ll="$lsd_cmd -l"
    alias la="$lsd_cmd -a"
    alias lt="$lsd_cmd --tree"
    alias lla="$lsd_cmd -la"
else
    alias l="ls"
    alias la="ls -a"
    alias lla="ls -la"
fi

# Alias for nvim
if command -v "nvim" &> /dev/null; then
	nvim_cmd="nvim"
	alias vi="$nvim_cmd"
	alias vim="$nvim_cmd"
fi

# fzf
source <(fzf --zsh)

# Java Path
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Rust Path
export PATH="$HOME/.cargo/bin:$PATH"

# Plugins
plugins=(
  # prompt
  sindresorhus/pure
  # completions
  zsh-users/zsh-completions
  # defer using zsh-defer
  romkatv/zsh-defer
  zdharma-continuum/fast-syntax-highlighting
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-history-substring-search
)

plugin-load $plugins
