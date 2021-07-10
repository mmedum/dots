# Arch Linux installation

Arch Linux is installed by using [Endeavouros](https://endeavouros.com/)

## Extra
- i3-gaps
- Rofi
- Dunst
- Polybar
- Neovim
- Zinit
- Alacritty
- Zsh

## X11

```bash
cp *.conf /etc/X11/xorg.conf.d/
```

## Lock machine on sleep/suspend

```bash
cp screenlock@.service /usr/lib/systemd/system/

systemctl enable screenlock@$USER
```
