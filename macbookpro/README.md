# Installs
- homebrew
- cask upgrade
- zsh
- zplugin
- coreutils
- ripgrep
- neovim
- python
- go
- rust
- yabai
- skhd
- nerdfont (font-sourcecodepro-nerd-font)
- flake8
- Alacritty

# Notes

## Use homebrew zsh instead of default zsh

```bash
sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
```

## Zsh job control problems

For job control with iterm and zsh, there is a problem with a lock being placed
when using zsh [github issue](https://github.com/zplug/zplug/issues/374), the
fix is to
```bash
rm /usr/local/opt/zplug/log/job.lock
```

## Zplug update problems
if the LANG is not set, zplug will have updating problems, see [github issue](https://github.com/zplug/zplug/issues/420), 
fix is to set
```bash
export LANG=en_US.UTF-8
```
in zshrc file

## Insecure dir

```bash
compaudit | xargs chmod g-w
```
