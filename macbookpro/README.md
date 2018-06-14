# Installs
- homebrew
- cask
- zsh
- zsh-completions
- zplug
- coreutils
- neovim
- python
- chunkwm
- chunkwm-blur

# Notes

## Zsh job control problems

For job control with iterm and zsh, there is a problem with a lock being placed
when using zsh [github issue](https://github.com/zplug/zplug/issues/374), the
fix is to
'''
rm <path-to-zplug>/zplug/log/job.lock
'''

## Zplug update problems
if the LANG is not set, zplug will have updating problems, see [github issue](https://github.com/zplug/zplug/issues/420), 
fix is to set
'''
export LANG=en_US.UTF-8
'''
in zshrc file
