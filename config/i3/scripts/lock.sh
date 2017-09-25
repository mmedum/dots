#!/usr/bin/env sh
TMPBG=/tmp/screen.png
LOCK=/home/mark/.config/i3/scripts/lock.png
RES=$(xrandr | grep 'current' | sed -E 's/.*current\s([0-9]+)\sx\s([0-9]+).*/\1x\2/')

param=(--textcolor=ffffff00 --insidecolor=faddc500 --ringcolor=fafafa00 \
    --linecolor=2d283e00 --keyhlcolor=fabb5caa --ringvercolor=fadd5caa \
    --separatorcolor=22222200 \
    --insidevercolor=fadd5c00 \
    --ringwrongcolor=f13459aa --insidewrongcolor=f1345900)


ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -i $LOCK -filter_complex "boxblur=5:1,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $TMPBG -loglevel quiet
i3lock "${param[@]}" -i $TMPBG
rm $TMPBG
