#!/usr/bin/env sh

image="${HOME}/walls/forest.jpg"

i3lock --centered \
    --color=282828FF \
    --image="$image" \
    --insidecolor=00000000 \
    --insidevercolor=00000000 \
    --insidewrongcolor=00000000 \
    --ringcolor=282828FF \
    --ringvercolor=282828FF \
    --ringwrongcolor=282828FF \
    --linecolor=00000000 \
    --keyhlcolor=EBDBB2FF \
    --separatorcolor=282828FF \
    --timecolor=EBDBB2FF \
    --datecolor=EBDBB2FF \
    --ring-width=2 \
    --timestr='%H:%M:%S' \
    --time-font='Source Code Pro Medium' \
    --greetertext='' \
    --veriftext='' \
    --wrongtext='' \
    --noinputtext='' \
    --locktext='' \
    --lockfailedtext='' \
    --ignore-empty-password \
    --pass-media-keys \
    --pass-screen-keys \
    --force-clock
