# Installation notes

## Homebrew

For installing all brew dependencies

```bash
brew bundle
```

## Change hostname

Type the following command to change the primary hostname of your Mac:
This is your fully qualified hostname, for example myMac.domain.com

```bash
sudo scutil --set HostName <new host name>
```

Type the following command to change the Bonjour hostname of your Mac:
This is the name usable on the local network, for example myMac.local.

```bash
sudo scutil --set LocalHostName <new host name>
```

If you also want to change the computer name, type the following command:
This is the user-friendly computer name you see in Finder, for example myMac.

```bash
sudo scutil --set ComputerName <new name>
```

Flush the DNS cache by typing:

```bash
dscacheutil -flushcache
```

Restart the machine afterwards

## ZSH

### Use Homebrew zsh instead of default zsh

Since brew install `zsh` at `/usr/local/bin/zsh`, it is needed to point the
the default shell to that specific path.

```bash
sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
```

### ZSH job control problems

For job control with zsh, there could be a problem with a lock being placed
when using zsh [github issue](https://github.com/zplug/zplug/issues/374), the
solution is to run

```bash
rm /usr/local/opt/zplug/log/job.lock
```

### Insecure dir

If `zsh` complains about insecure dirs, run below command

```bash
compaudit | xargs chmod g-w
```

## zinit

### Zinit update problems

if the LANG is not set, zplug will have updating problems, 
see [github issue](https://github.com/zplug/zplug/issues/420), the solution is
to set LANG in `zshrc`

```bash
export LANG=en_US.UTF-8
```

## yabai

For installing scripting additions to yabai

```bash
sudo yabai --install-sa
```
