#!/usr/bin/env sh

#dunstctl set-paused true

image="${HOME}/walls/firewatch.jpg"

i3lock --centered \
    --color=282828FF \
    --image="$image" \
    --inside-color=00000000 \
    --insidever-color=00000000 \
    --insidewrong-color=00000000 \
    --ring-color=282828FF \
    --ringver-color=282828FF \
    --ringwrong-color=282828FF \
    --line-color=00000000 \
    --keyhl-color=EBDBB2FF \
    --separator-color=282828FF \
    --time-color=EBDBB2FF \
    --date-color=EBDBB2FF \
    --ring-width=2 \
    --time-str='%H:%M:%S' \
    --time-font='Source Code Pro Medium' \
    --greeter-text='' \
    --verif-text='' \
    --wrong-text='' \
    --noinput-text='' \
    --lock-text='' \
    --lockfailed-text='' \
    --ignore-empty-password \
    --pass-volume-keys \
    --pass-media-keys \
    --pass-screen-keys \
    --force-clock

#dunstctl set-paused false
