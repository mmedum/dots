#!/usr/bin/env sh

tmpbg=/tmp/screen.png

maim $tmpbg
convert $tmpbg -scale 10% -scale 1000% $tmpbg

i3lock -i $tmpbg \
    --insidecolor=28282899 --ringcolor=EBDBB2FF --line-uses-inside \
    --keyhlcolor=FB4934FF --bshlcolor=FB4934FF --separatorcolor=282828FF \
    --insidevercolor=FABD2F99 --insidewrongcolor=FB493499 \
    --ringvercolor=EBDBB2FF --ringwrongcolor=EBDBB2FF --indpos='x+40:h-50' \
    --radius=20 --veriftext='' --wrongtext=''

rm $tmpbg
