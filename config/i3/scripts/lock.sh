#!/usr/bin/env sh
LOCK=/home/mark/.config/i3/scripts/lock.png

maim \
  | convert png:- -scale 10% -scale 1000% png:- \
  | convert png:- "$LOCK" -gravity center -composite -matte png:- \
  | i3lock -e -i /dev/stdin \
  --insidecolor=28282899 --ringcolor=EBDBB2FF --line-uses-inside \
  --keyhlcolor=FB4934FF --bshlcolor=FB4934FF --separatorcolor=282828FF \
  --insidevercolor=FABD2F99 --insidewrongcolor=FB493499 \
  --ringvercolor=EBDBB2FF --ringwrongcolor=EBDBB2FF --indpos='x+45:y+2100' \
  --radius=23 --veriftext='' --wrongtext=''
