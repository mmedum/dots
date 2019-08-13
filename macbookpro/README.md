# Installation notes

## Homebrew
Installation is done by running
```bash
homebrew bundle
```

## zsh
### Use Homebrew zsh instead of default zsh
Since Homebrew install zsh at `/usr/local/bin/zsh`, it is needed to point the
the default shell to that specific path.
```bash
sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
```

### Zsh job control problems in Iterm
For job control with iterm and zsh, there is a problem with a lock being placed
when using zsh [github issue](https://github.com/zplug/zplug/issues/374), the
fix is to
```bash
rm /usr/local/opt/zplug/log/job.lock
```

### Insecure dir
```bash
compaudit | xargs chmod g-w
```

## zplugin
### Zplug update problems
if the LANG is not set, zplug will have updating problems, see [github issue](https://github.com/zplug/zplug/issues/420), 
fix is to set
```bash
export LANG=en_US.UTF-8
```
in zshrc file

## yabai
### Scripting addition
```bash
sudo yabai --install-sa
```


