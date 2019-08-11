#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch primary bar and launch 
# secondary bar if monitor connected
MONITOR=eDP-1 polybar top &
#MONITOR=VIRTUAL4 polybar top &

echo "Bars launched..."
