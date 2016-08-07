Before umounting arch-chroot, remember to:

1. add $user to wheel group
2. give $user privilege to use sudo - /etc/sudoers
3. Enable watchdog.service for eliminating user wait when shutting down
  3a. sudo pacman -S watchdog
  3b. sudo systemctl enable watchdog.service
