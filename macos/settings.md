# MacOS Settings

## Key Repeat

From [stackexchange](https://apple.stackexchange.com/questions/10467/how-to-increase-keyboard-key-repeat-rate-on-os-x)

```bash
defaults write -g InitialKeyRepeat -float 10.0 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -float 1.0 # normal minimum is 2 (30 ms)
```

## Change the System Hostname

From [trio.so](https://www.trio.so/blog/macbook-hostname-change/)

From  
```bash
sudo scutil --set LocalHostName New-MacBook-Name
sudo scutil --set ComputerName New-MacBook-Name
```
