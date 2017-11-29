#!/usr/bin/env sh
TMPBG=/tmp/screen.png
LOCK=/home/mark/.config/i3/scripts/lock.png
RES=$(xrandr | grep 'current' | sed -E 's/.*current\s([0-9]+)\sx\s([0-9]+).*/\1x\2/')

param=(--insidecolor=28282899 --ringcolor=EBDBB2FF --line-uses-inside \
  --keyhlcolor=FB4934FF --bshlcolor=FB4934FF --separatorcolor=282828FF \
  --insidevercolor=FABD2F99 --insidewrongcolor=FB493499 \
  --ringvercolor=EBDBB2FF --ringwrongcolor=EBDBB2FF --indpos='x+50:y+2100' \
  --radius=23 --veriftext='' --wrongtext='')

ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -i $LOCK -filter_complex "boxblur=5:1,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $TMPBG -loglevel quiet
i3lock "${param[@]}" -i $TMPBG

rm $TMPBG
